library models;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:jaguar_serializer/jaguar_serializer.dart';

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

  final Map<String, bool> nullableFields;

  final bool globalNullableFields;

  final Map<String, String> defaultValues;

  SerializerInfo(this.name, this.modelType,
      {this.includeByDefault,
      this.modelString,
      this.from,
      this.to,
      this.processors,
      this.providers,
      this.model,
      this.nullableFields,
      this.globalNullableFields,
      this.defaultValues});
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

  Map<String, bool> nullableFields = {};

  Map<String, String> defaultValues = {};

  Instantiator(this.element, this.obj);

  SerializerInfo instantiate() {
    final bool nullable = obj.getField('nullableFields').toBoolValue();

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
        model: model,
        nullableFields: nullableFields,
        globalNullableFields: nullable,
        defaultValues: defaultValues);
    ret.model = parseModel(modelType.element, ret, includeByDefault);
    return ret;
  }

  void _makeName() => name = element.name;

  void _makeModelType() {
    if (!isSerializer.isSuperTypeOf(element.type)) {
      throw new JaguarCliException(
          'serializers must be sub-type of Serializer!');
    }

    InterfaceType i = element.allSupertypes
        .firstWhere((InterfaceType i) => isSerializer.isExactly(i.element));
    modelType = i.typeArguments.first;

    if (modelType.isDynamic) {
      throw new JaguarCliException('Model cannot be dynamic!');
    }
  }

  void _makeIncludeByDefault() =>
      includeByDefault = obj.getField('includeByDefault').toBoolValue() ?? true;

  void _makeModelString() =>
      modelString = obj.getField('modelName').toStringValue();

  void _makeFields() {
    final Map<DartObject, DartObject> map = obj.getField('fields').toMapValue();
    map.forEach((DartObject dKey, DartObject values) {
      if (isList.isExactlyType(values.type)) {
        final List<DartObject> list = values.toListValue();
        list.forEach((DartObject dV) {
          _processField(dKey, dV);
        });
      } else if (isProperty.isAssignableFromType(values.type)) {
        _processField(dKey, values);
      }
    });
  }

  void _processField(DartObject dKey, DartObject dV) {
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
    } else if (isFieldProcessor.isAssignableFromType(dV.type)) {
      processors[key] = new FieldProcessorInfo(dV.type.displayName);
    } else if (isNonNullable.isExactlyType(dV.type)) {
      nullableFields[key] = false;
    } else if (isNullable.isExactlyType(dV.type)) {
      nullableFields[key] = true;
    } else if (isDefaultStringValue.isExactlyType(dV.type)) {
      defaultValues[key] = '"${dV.getField('value').toStringValue()}"';
    } else if (isDefaultBoolValue.isExactlyType(dV.type)) {
      defaultValues[key] = dV.getField('value').toBoolValue().toString();
    } else if (isDefaultDoubleValue.isExactlyType(dV.type)) {
      defaultValues[key] = dV.getField('value').toDoubleValue().toString();
    } else if (isDefaultIntValue.isExactlyType(dV.type)) {
      defaultValues[key] = dV.getField('value').toIntValue().toString();
    } else {
      throw new JaguarCliException(
          'Invalid property specification at "$modelType.${key}" with "${dV.type.displayName}".');
    }
  }

  void _makeIgnore() {
    final List<DartObject> list = obj.getField('ignore').toListValue();
    list.map((DartObject v) => v.toStringValue()).forEach((String key) {
      if (from.containsKey(key)) {
        throw new JaguarCliException('Both fields and ignore has $key!');
      }
      to[key] = null;
      from[key] = null;
    });
  }

  @deprecated
  void _makeProcessors() {
    final Map<DartObject, DartObject> map =
        obj.getField('processors').toMapValue();

    map.forEach((DartObject k, DartObject v) {
      final String key = k.toStringValue();
      final value = new FieldProcessorInfo(v.type.displayName);

      processors[key] = value;
    });
  }

  void _makeSerializers() {
    final List<DartObject> list = obj.getField('serializers').toListValue();
    list.map((DartObject obj) => obj.toTypeValue()).forEach((DartType t) {
      if (!isSerializer.isSuperTypeOf(t)) {
        throw new JaguarCliException(
            'serializers must be sub-type of Serializer!');
      }

      final ClassElement v = t.element;
      final InterfaceType i = v.allSupertypes
          .where((InterfaceType i) => isSerializer.isExactly(i.element))
          .first;

      final DartType key = i.typeArguments[0];
      providers[key] = v;
    });
  }

  Model parseModel(
      ClassElement el, SerializerInfo info, bool includeByDefault) {
    final mod = new Model();

    final accessors = <PropertyAccessorElement>[];
    accessors.addAll(el.accessors);
    el.allSupertypes
        .forEach((InterfaceType i) => accessors.addAll(i.accessors));

    accessors
        .where((PropertyAccessorElement field) =>
            !field.isStatic && !field.isPrivate)
        .forEach((PropertyAccessorElement field) {
      if (field.displayName == 'runtimeType') return;
      if (field.displayName == 'hashCode') return;

      if (field.isGetter) {
        if (info.to[field.displayName] != null ||
            (includeByDefault && !info.to.containsKey(field.displayName))) {
          mod.addTo(new ModelField(field.displayName, field.returnType));
        }
      }

      if (field.isSetter) {
        if (info.from[field.displayName] != null ||
            (includeByDefault && !info.from.containsKey(field.displayName))) {
          mod.addFrom(new ModelField(
              field.displayName, field.type.parameters.first.type));
        }
      }
    });

    return mod;
  }
}
