part of jaguar_serializer.generator.parser.serializer;

class FieldTo {
  PropertyTo property;

  String key;

  String name;

  FieldTo(this.key, this.name, this.property);
}

abstract class PropertyTo {}

class MapPropertyTo implements PropertyTo {
  final PropertyTo key;

  final String keyTypeStr;

  final PropertyTo value;

  final String valueTypeStr;

  const MapPropertyTo(this.key, this.keyTypeStr, this.value, this.valueTypeStr);
}

class ListPropertyTo implements PropertyTo {
  final PropertyTo value;

  final String itemTypeStr;

  const ListPropertyTo(this.value, this.itemTypeStr);
}

class LeafPropertyTo implements PropertyTo {}

class BuiltinLeafPropertyTo implements LeafPropertyTo {
  const BuiltinLeafPropertyTo();
}

class CustomPropertyTo implements LeafPropertyTo {
  final String instantiationString;

  const CustomPropertyTo(this.instantiationString);
}

class SerializedPropertyTo implements LeafPropertyTo {
  final String instantiationString;

  const SerializedPropertyTo(this.instantiationString);
}

PropertyTo _parsePropertyTo(
    SerializerInfo info, String fieldName, InterfaceType type) {
  if (type.isDynamic) {
    throw new Exception(
        'Cannot serialize "dynamic" type for property $fieldName!');
  } else if (type.isObject) {
    throw new Exception(
        'Cannot serialize "Object" type for property $fieldName!');
  }

  if (isList.isExactlyType(type)) {
    final DartType param = type.typeArguments.first;
    return new ListPropertyTo(
        _parsePropertyTo(info, fieldName, param), param.displayName);
  } else if (isMap.isExactlyType(type)) {
    final DartType key = type.typeArguments.first;
    final DartType value = type.typeArguments[1];
    return new MapPropertyTo(
        _parsePropertyTo(info, fieldName, key),
        key.displayName,
        _parsePropertyTo(info, fieldName, value),
        value.displayName);
  } else if (isBuiltin(type)) {
    return new BuiltinLeafPropertyTo();
  } else {
    DartType ser;

    info.providers.forEach((InterfaceType modelType, ClassElement serializer) {
      if (new TypeChecker.fromStatic(type).isExactlyType(modelType)) {
        ser = serializer.type;
      }
    });

    if (ser == null) {
      throw new Exception(
          "Serializer not found for '${type.displayName} $fieldName'");
    }

    return new SerializedPropertyTo(ser.displayName);
  }
}

FieldTo _parseFieldTo(SerializerInfo info, ModelField field, String key) {
  if (info.processors.containsKey(field.name)) {
    String instStr = info.processors[field.name].instantiationString;
    return new FieldTo(
        key, field.name, new CustomPropertyTo("${field.name}$instStr"));
  } else {
    return new FieldTo(
        key, field.name, _parsePropertyTo(info, field.name, field.type));
  }
}
