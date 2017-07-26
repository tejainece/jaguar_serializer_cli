library models;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:jaguar_serializer/serializer.dart';

import '../common/common.dart';

class ModelField {
  /// Name of the field
  String name;

  /// Type of the field
  InterfaceType type;

  ModelField(this.name, this.type);
}

class Model {
  Map<String, ModelField> _fieldsTo = {};

  Map<String, ModelField> _fieldsFrom = {};

  void addTo(ModelField field) {
    _fieldsTo[field.name] = field;
  }

  void addFrom(ModelField field) {
    _fieldsFrom[field.name] = field;
  }

  List<ModelField> get to => _fieldsTo.values.toList();

  List<ModelField> get from => _fieldsFrom.values.toList();
}

class FieldProcessorInfo {
  final String instantiationString;

  FieldProcessorInfo(this.instantiationString);
}

class SerializerInfo {
  /// Name of the serializer
  final String name;

  /// Model type
  final DartType modelType;

  /// Should fields be included by default
  final bool includeByDefault;

  /// Model string
  final String modelString;

  /// From field names
  final Map<String, String> from;

  /// To field names
  final Map<String, String> to;

  final Map<String, FieldProcessorInfo> processors;

  final Map<InterfaceType, ClassElement> providers;

  Model model;

  SerializerInfo(this.name, this.modelType,
      {this.includeByDefault,
      this.modelString,
      this.from,
      this.to,
      this.processors,
      this.providers,
      this.model});
}

/// Instantiates [GenSerializer] from [DartObject]
class Instantiator {
  final DartObject obj;

  final ClassElement element;

  /// Name of the serializer
  String name;

  /// Model type
  DartType modelType;

  /// Should fields be included by default
  bool includeByDefault;

  /// Model string
  String modelString;

  /// From field names
  Map<String, String> from = {};

  /// To field names
  Map<String, String> to = {};

  Map<String, FieldProcessorInfo> processors = {};

  Map<InterfaceType, ClassElement> providers = {};

  Model model;

  Instantiator(this.element, this.obj);

  SerializerInfo instantiate() {
    _makeName();
    _makeModelType();
    _makeIncludeByDefault();
    _makeModelString();
    _makeFields();
    _makeIgnore();
    _makeProcessors();
    _makeSerializers();

    final ret = new SerializerInfo(name, modelType,
        includeByDefault: includeByDefault,
        modelString: modelString,
        from: from,
        to: to,
        processors: processors,
        providers: providers,
        model: model);
    ret.model = parseModel(modelType.element, ret, includeByDefault);
    return ret;
  }

  void _makeName() => name = element.name;

  void _makeModelType() {
    if (!isSerializer.isSuperTypeOf(element.type)) {
      throw new Exception('serializers must be sub-type of Serializer!');
    }

    InterfaceType i = element.allSupertypes
        .firstWhere((InterfaceType i) => isSerializer.isExactly(i.element));
    modelType = i.typeArguments.first;

    if (modelType.isDynamic) {
      throw new Exception('Model cannot be dynamic!');
    }
  }

  void _makeIncludeByDefault() =>
      includeByDefault = obj.getField('includeByDefault').toBoolValue() ?? true;

  void _makeModelString() =>
      modelString = obj.getField('modelName').toStringValue();

  void _makeFields() {
    final Map<DartObject, DartObject> map = obj.getField('fields').toMapValue();
    map.forEach((DartObject dKey, DartObject dV) {
      final String key = dKey.toStringValue();
      if (isEncodeOnly.isExactlyType(dV.type)) {
        to[key] = dV.getField('alias').toStringValue();
        from[key] = null;
      } else if (isDecodeOnly.isExactlyType(dV.type)) {
        to[key] = null;
        from[key] = dV.getField('alias').toStringValue();
      } else if (isEnDecode.isExactlyType(dV.type)) {
        to[key] = dV.getField('alias').toStringValue();
        from[key] = dV.getField('alias').toStringValue();
      } else if (isIgnore.isExactlyType(dV.type)) {
        to[key] = null;
        from[key] = null;
      } else
        throw new Exception('Invalid property specification!');
    });
  }

  void _makeIgnore() {
    final List<DartObject> list = obj.getField('ignore').toListValue();
    list.map((DartObject v) => v.toStringValue()).forEach((String key) {
      if (from.containsKey(key)) {
        throw new Exception('Both fields and ignore has $key!');
      }
      to[key] = null;
      from[key] = null;
    });
  }

  void _makeProcessors() {
    final Map<DartObject, DartObject> map =
        obj.getField('processors').toMapValue();

    map.forEach((DartObject k, DartObject v) {
      final String key = k.toStringValue();
      //TODO
      final value = new FieldProcessorInfo(v.toTypeValue().displayName);

      processors[key] = value;
    });
  }

  void _makeSerializers() {
    final List<DartObject> list = obj.getField('serializers').toListValue();
    list.map((DartObject obj) => obj.toTypeValue()).forEach((DartType t) {
      if (!isSerializer.isSuperTypeOf(t)) {
        throw new Exception('serializers must be sub-type of Serializer!');
      }

      final ClassElement v = t.element;
      final InterfaceType i = v.allSupertypes
          .where((InterfaceType i) => isSerializer.isExactly(i.element))
          .first;

      final DartType key = i.typeArguments[0];
      providers[key] = v;
    });
  }

  Model parseModel(ClassElement el, SerializerInfo info, bool includeByDefault) {
    final mod = new Model();

    final accessors = <PropertyAccessorElement>[];
    accessors.addAll(el.accessors);
    el.allSupertypes.forEach((InterfaceType i) => accessors.addAll(i.accessors));

    accessors
        .where((PropertyAccessorElement field) =>
    !field.isStatic && !field.isPrivate)
        .forEach((PropertyAccessorElement field) {
      if(field.displayName == 'runtimeType') return;
      if(field.displayName == 'hashCode') return;

      if (field.isGetter) {
        if (includeByDefault || info.to[field.displayName] != null) {
          mod.addTo(new ModelField(field.displayName, field.returnType));
        }
      }

      if (field.isSetter) {
        if (includeByDefault || info.from[field.displayName] != null) {
          mod.addFrom(new ModelField(
              field.displayName, field.type.parameters.first.type));
        }
      }
    });

    return mod;
  }
}