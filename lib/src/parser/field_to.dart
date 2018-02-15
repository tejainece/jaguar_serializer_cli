part of jaguar_serializer.generator.parser;

class FieldTo {
  final PropertyTo property;

  final String key;

  final String name;

  final bool nullable;

  FieldTo(this.key, this.name, this.property, this.nullable);
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
  } else if (info.processors.containsKey(fieldName)) {
    String instStr = info.processors[fieldName].instantiationString;
    return new CustomPropertyTo(instStr);
  } else if (isBuiltin(type)) {
    return new BuiltinLeafPropertyTo();
  } else if (type.isDynamic) {
    throw new JaguarCliException(
        'Cannot serialize "dynamic" type for property $fieldName!');
  } else if (type.isObject) {
    throw new JaguarCliException(
        'Cannot serialize "Object" type for property $fieldName!');
  } else {
    DartType ser;

    info.providers.forEach((InterfaceType modelType, ClassElement serializer) {
      if (new TypeChecker.fromStatic(type).isExactlyType(modelType)) {
        ser = serializer.type;
      }
    });

    if (ser == null) {
      throw new JaguarCliException(
          "Serializer not found for '${type.displayName} $fieldName' in '${info.modelType}'");
    }

    return new SerializedPropertyTo(ser.displayName);
  }
}

FieldTo _parseFieldTo(SerializerInfo info, ModelField field, String key) {
  bool nullable = info.globalNullableFields;
  if (info.nullableFields.containsKey(field.name)) {
    nullable = info.nullableFields[field.name];
  }

  return new FieldTo(key, field.name,
      _parsePropertyTo(info, field.name, field.type), nullable);
}
