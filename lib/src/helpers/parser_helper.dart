part of jaguar_serializer.generator.helpers;

class Field {
  /// Name of the field
  final String name;

  /// Type of the field
  final InterfaceType type;

  final bool isFinal;

  Field(this.name, this.type, {this.isFinal: false});
}

class Model {
  final ctorArguments = <ParameterElement>[];
  final ctorNamedArguments = <ParameterElement>[];
  final _fieldsTo = <String, Field>{};
  final _fieldsFrom = <String, Field>{};

  void addTo(Field field) {
    _fieldsTo[field.name] = field;
  }

  void addFrom(Field field) {
    _fieldsFrom[field.name] = field;
  }

  Field getFrom(String name) => _fieldsFrom[name];

  List<Field> getters() => _fieldsTo.values.toList();

  List<Field> setters() => _fieldsFrom.values.toList();
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
class AnnotationParser {
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

  AnnotationParser(this.element, this.obj);

  SerializerInfo parse() {
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
    ret.model = _parseFields(modelType.element, ret, includeByDefault);
    _makeCtor(modelType.element, ret.model);
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

  void _makeModelString() => modelString = obj.peek('modelName')?.stringValue;

  void _makeFields() {
    final Map<DartObject, DartObject> map = obj.peek('fields')?.mapValue ?? {};
    map.forEach((DartObject dKey, DartObject dV) {
      if (isIgnore.isAssignableFromType(dV.type)) {
        to[dKey.toStringValue()] = null;
        from[dKey.toStringValue()] = null;
      } else {
        _processField(dKey, dV);
      }
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

  Model _parseFields(
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
          mod.addTo(new Field(field.displayName, field.returnType));
        }
      }

      if (field.isSetter) {
        if (info.from[field.displayName] != null ||
            (includeByDefault && !info.from.containsKey(field.displayName))) {
          mod.addFrom(
              new Field(field.displayName, field.type.parameters.first.type));
        }
      }
    });

    el.fields.where((f) => f.isFinal).forEach((FieldElement f) {
      mod.addFrom(new Field(f.displayName, f.type, isFinal: true));
    });

    return mod;
  }

  void _makeCtor(ClassElement el, Model model) {
    ConstructorElement ctor = el.unnamedConstructor;
    if (ctor == null) {
      throw new JaguarCliException(
          "The class `${el.name}` has no default constructor.");
    }
    for (final arg in ctor.parameters) {
      final field = model.getFrom(arg.name);
      if (field?.isFinal == true) {
        if (arg.parameterKind == ParameterKind.NAMED) {
          model.ctorNamedArguments.add(arg);
        } else {
          model.ctorArguments.add(arg);
        }
      }
    }
  }
}
