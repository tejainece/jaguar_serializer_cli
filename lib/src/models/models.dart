library models;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:jaguar_serializer/jaguar_serializer.dart';

import '../common/common.dart';
import 'package:source_gen/source_gen.dart';

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

  final Map<String, bool> defaultValuesFromConstructor;

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
      this.defaultValues,
      this.defaultValuesFromConstructor});
}

/// Instantiates [GenSerializer] from [DartObject]
class Instantiator {
  final ConstantReader obj;

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

  Map<String, bool> defaultValueFromConstructor = {};

  Instantiator(this.element, this.obj);

  SerializerInfo instantiate() {
    final bool nullable = obj.peek('nullableFields')?.boolValue ?? false;

    _makeName();
    _makeModelType();
    _makeIncludeByDefault();
    _makeModelString();
    _makeFields();
    _makeIgnore();
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
        defaultValues: defaultValues,
        defaultValuesFromConstructor: defaultValueFromConstructor);
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
      includeByDefault = obj.peek('includeByDefault')?.boolValue ?? true;

  void _makeModelString() =>
      modelString = obj.peek('modelName')?.stringValue;

  void _makeFields() {
    final Map<DartObject, DartObject> map = obj.peek('fields')?.mapValue ?? {};
    map.forEach((DartObject dKey, DartObject dV) {
      _processField(dKey, dV);
    });
  }

  bool _notNull(DartObject obj) => obj != null && obj.isNull == false;

  void _processField(DartObject dKey, DartObject dV) {
    final String key = dKey.toStringValue();

    to[key] = key;
    from[key] = key;

    if (_notNull(dV.getField('encodeTo'))) {
      to[key] = dV.getField('encodeTo').toStringValue();
    }

    if (_notNull(dV.getField('decodeFrom'))) {
      from[key] = dV.getField('decodeFrom').toStringValue();
    }

    if (_notNull(dV.getField('processor'))) {
      processors[key] =
          new FieldProcessorInfo(dV.getField('processor').type.displayName);
    }

    if (_notNull(dV.getField('isNullable'))) {
      nullableFields[key] = dV.getField('isNullable').toBoolValue();
    }

    if (_notNull(dV.getField('valueFromConstructor'))) {
      defaultValueFromConstructor[key] =
          dV.getField('valueFromConstructor').toBoolValue();
    }

    if (_notNull(dV.getField('defaultsTo'))) {
      final defaultField = dV.getField('defaultsTo');
      if (isString.isExactlyType(defaultField.type)) {
        defaultValues[key] = '"${defaultField.toStringValue()}"';
      } else if (isBool.isExactlyType(defaultField.type)) {
        defaultValues[key] = defaultField.toBoolValue().toString();
      } else if (isDouble.isExactlyType(defaultField.type)) {
        defaultValues[key] = defaultField.toDoubleValue().toString();
      } else if (isInt.isExactlyType(defaultField.type)) {
        defaultValues[key] = defaultField.toIntValue().toString();
      } else {
        throw new JaguarCliException(
            "Invalid value for 'defaultsTo' at '$modelType.${key}'");
      }
    }
  }

  void _makeIgnore() {
    final List<DartObject> list = obj.peek('ignore')?.listValue ?? [];
    list.map((DartObject v) => v.toStringValue()).forEach((String key) {
      if (from.containsKey(key)) {
        throw new JaguarCliException('Both fields and ignore has $key!');
      }
      to[key] = null;
      from[key] = null;
    });
  }

  void _makeSerializers() {
    final List<DartObject> list = obj.peek('serializers')?.listValue ?? [];
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
