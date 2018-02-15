part of jaguar_serializer.generator.parser;

class FieldFrom {
  final PropertyFrom property;

  final String key;

  final String name;

  final String defaultValue;

  final bool nullable;

  final bool defaultValueFromConstructor;

  FieldFrom(this.key, this.name, this.property, this.defaultValue,
      this.defaultValueFromConstructor, this.nullable);
}

abstract class PropertyFrom {
  String get inputTypeStr;
}

class MapPropertyFrom implements PropertyFrom {
  final PropertyFrom key;

  final PropertyFrom value;

  final String keyTypeStr;

  final String valueTypeStr;

  String get inputTypeStr => 'Map<${key.inputTypeStr}, ${value.inputTypeStr}>';

  const MapPropertyFrom(
      this.key, this.keyTypeStr, this.value, this.valueTypeStr);
}

class ListPropertyFrom implements PropertyFrom {
  final PropertyFrom value;

  final String itemTypeStr;

  String get inputTypeStr => 'List<${value.inputTypeStr}>';

  const ListPropertyFrom(this.value, this.itemTypeStr);
}

abstract class LeafPropertyFrom implements PropertyFrom {}

class BuiltinLeafPropertyFrom implements LeafPropertyFrom {
  final String inputTypeStr;

  const BuiltinLeafPropertyFrom(this.inputTypeStr);
}

class CustomPropertyFrom implements LeafPropertyFrom {
  final String instantiationString;

  String get inputTypeStr => 'dynamic';

  const CustomPropertyFrom(this.instantiationString);
}

class SerializedPropertyFrom implements LeafPropertyFrom {
  final String instantiationString;

  String get inputTypeStr => 'Map';

  const SerializedPropertyFrom(this.instantiationString);
}

PropertyFrom _parsePropertyFrom(
    SerializerInfo info, String fieldName, InterfaceType type) {
  if (isList.isExactlyType(type)) {
    final DartType param = type.typeArguments.first;
    return new ListPropertyFrom(
        _parsePropertyFrom(info, fieldName, param), param.displayName);
  } else if (isMap.isExactlyType(type)) {
    final DartType key = type.typeArguments.first;
    final DartType value = type.typeArguments[1];
    return new MapPropertyFrom(
        _parsePropertyFrom(info, fieldName, key),
        key.displayName,
        _parsePropertyFrom(info, fieldName, value),
        value.displayName);
  } else if (info.processors.containsKey(fieldName)) {
    String instStr = info.processors[fieldName].instantiationString;
    return new CustomPropertyFrom(instStr);
  } else if (isBuiltin(type)) {
    return new BuiltinLeafPropertyFrom(type.displayName);
  } else if (type.isDynamic) {
    throw new JaguarCliException(
        'Cannot serialize "dynamic" type for property $fieldName!');
  } else if (type.isObject) {
    throw new JaguarCliException(
        'Cannot serialize "Object" type for property $fieldName!');
  } else {
    DartType ser;

    info.providers.forEach((DartType modelType, ClassElement serializer) {
      if (new TypeChecker.fromStatic(type).isExactlyType(modelType)) {
        ser = serializer.type;
      }
    });

    if (ser == null) {
      throw new JaguarCliException(
          "Serializer not found for '${type.displayName} $fieldName'  in '${info.modelType}'");
    }

    return new SerializedPropertyFrom(ser.displayName);
  }
}

FieldFrom _parseFieldFrom(SerializerInfo info, ModelField field, String key) {
  String defaultValue;

  if (info.defaultValues.containsKey(field.name)) {
    defaultValue = info.defaultValues[field.name];
  }

  bool defaultValueFromConstructor = false;

  if (info.defaultValuesFromConstructor.containsKey(field.name)) {
    defaultValueFromConstructor = info.defaultValuesFromConstructor[field.name];
  }

  bool nullable = info.globalNullableFields;
  if (defaultValueFromConstructor || defaultValue != null) {
    nullable = false;
  } else if (info.nullableFields.containsKey(field.name)) {
    nullable = info.nullableFields[field.name];
  }
  return new FieldFrom(
      key,
      field.name,
      _parsePropertyFrom(info, field.name, field.type),
      defaultValue,
      defaultValueFromConstructor,
      nullable);
}
