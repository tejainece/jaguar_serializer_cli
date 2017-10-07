part of jaguar_serializer.generator.parser.serializer;

class FieldFrom {
  PropertyFrom property;

  String key;

  String name;

  FieldFrom(this.key, this.name, this.property);
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
  if (type.isDynamic) {
    throw new JaguarCliException(
        'Cannot serialize "dynamic" type for property $fieldName!');
  } else if (type.isObject) {
    throw new JaguarCliException(
        'Cannot serialize "Object" type for property $fieldName!');
  }

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
  } else if (isBuiltin(type)) {
    return new BuiltinLeafPropertyFrom(type.displayName);
  } else {
    DartType ser;

    info.providers.forEach((DartType modelType, ClassElement serializer) {
      if (new TypeChecker.fromStatic(type).isExactlyType(modelType)) {
        ser = serializer.type;
      }
    });

    if (ser == null) {
      throw new JaguarCliException(
          "Serializer not found for '${type.displayName} $fieldName'");
    }

    return new SerializedPropertyFrom(ser.displayName);
  }
}

FieldFrom _parseFieldFrom(SerializerInfo info, ModelField field, String key) {
  if (info.processors.containsKey(field.name)) {
    String instStr = info.processors[field.name].instantiationString;
    return new FieldFrom(
        key, field.name, new CustomPropertyFrom("${field.name}$instStr"));
  } else {
    return new FieldFrom(
        key, field.name, _parsePropertyFrom(info, field.name, field.type));
  }
}
