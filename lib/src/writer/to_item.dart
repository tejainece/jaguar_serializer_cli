part of jaguar_serializer.generator.writer;

class ToItemWriter {
  final FieldTo field;

  ToItemWriter(this.field);

  String writeToListProperty(String reference, ListPropertyTo prop) {
    StringBuffer _w = new StringBuffer();

    if (field.nullable) {
      _w.write("nullableIterableMapper<${prop.itemTypeStr}>($reference, ");
    } else {
      _w.write("nonNullableIterableMapper<${prop.itemTypeStr}>($reference, ");
    }
    _w.write('(${prop.itemTypeStr} val) => ');
    _w.write(writeToProperty('val', prop.value));
    if (!field.nullable) {
      _w.write(", []");
    }
    _w.write(')');

    return _w.toString();
  }

  String writeToMapProperty(String reference, MapPropertyTo map) {
    StringBuffer _w = new StringBuffer();

    if (field.nullable) {
      _w.write('nullableMapMaker<${map.valueTypeStr}>(');
    } else {
      _w.write('nonNullableMapMaker<${map.valueTypeStr}>(');
    }
    _w.write(reference);
    _w.write(',');
    _w.write('(${map.valueTypeStr} value) =>');
    _w.write(writeToProperty('value', map.value));
    if (!field.nullable) {
      _w.write(", <String, dynamic>{}");
    }
    _w.write(')');

    return _w.toString();
  }

  String writeToLeafProperty(String reference, LeafPropertyTo leaf) {
    StringBuffer _w = new StringBuffer();
    if (leaf is BuiltinLeafPropertyTo) {
      _w.write(reference);
    } else if (leaf is CustomPropertyTo) {
      _w.write("_${firstCharToLowerCase(leaf.instantiationString)}" +
          '.serialize($reference)');
    } else if (leaf is SerializedPropertyTo) {
      _w.write("_${firstCharToLowerCase(leaf.instantiationString)}" +
          '.toMap($reference, withType: withType, typeKey: typeKey)');
    }

    return _w.toString();
  }

  String writeToProperty(String reference, PropertyTo prop) {
    if (prop is ListPropertyTo) {
      return writeToListProperty(reference, prop);
    } else if (prop is MapPropertyTo) {
      return writeToMapProperty(reference, prop);
    } else if (prop is LeafPropertyTo) {
      return writeToLeafProperty(reference, prop);
    } else {
      throw new JaguarCliException('Dont know how to handle this!');
    }
  }

  String generate(String reference) {
    return writeToProperty(reference, field.property);
  }
}
