part of jaguar_serializer.generator.writer;

class FromItemWriter {
  final FieldFrom field;

  FromItemWriter(this.field);

  String writeFromListProperty(String reference, ListPropertyFrom prop,
      [String defaultValueRef]) {
    StringBuffer _w = new StringBuffer();

    if (field.nullable) {
      _w.write(
          "nullableIterableMapper<${prop.value.inputTypeStr}>($reference, ");
    } else {
      _w.write(
          "nonNullableIterableMapper<${prop.value.inputTypeStr}>($reference, ");
    }

    _w.write('(${prop.value.inputTypeStr} val) => ');
    _w.write(writeFromProperty('val', prop.value));
    if (!field.nullable) {
      if (defaultValueRef != null) {
        _w.writeln(", $defaultValueRef");
      } else {
        _w.writeln(", []");
      }
    }
    _w.write(')');

    return _w.toString();
  }

  String writeFromMapProperty(String reference, MapPropertyFrom map,
      [String defaultValueRef]) {
    StringBuffer _w = new StringBuffer();
    if (field.nullable) {
      _w.write('nullableMapMaker<${map.value.inputTypeStr}>(');
    } else {
      _w.write('nonNullableMapMaker<${map.value.inputTypeStr}>(');
    }

    _w.write(reference);
    _w.write(',');
    _w.write('(${map.value.inputTypeStr} value) =>');
    _w.write(writeFromProperty('value', map.value));
    if (!field.nullable) {
      if (defaultValueRef != null) {
        _w.writeln(", $defaultValueRef");
      } else {
        _w.writeln(", <String,dynamic>{}");
      }
    }
    _w.write(')');

    return _w.toString();
  }

  String writeFromLeafProperty(String reference, LeafPropertyFrom leaf,
      [String defaultValueRef]) {
    StringBuffer _w = new StringBuffer();

    if (leaf is BuiltinLeafPropertyFrom) {
      _w.write(reference);
    } else if (leaf is CustomPropertyFrom) {
      _w.write("_${firstCharToLowerCase(leaf.instantiationString)}" +
          '.deserialize($reference)');
    } else if (leaf is SerializedPropertyFrom) {
      _w.write("_${firstCharToLowerCase(leaf.instantiationString)}" +
          '.fromMap($reference, typeKey: typeKey)');
    }
    if (defaultValueRef != null) {
      _w.writeln("?? $defaultValueRef");
    }
    return _w.toString();
  }

  String writeFromProperty(String reference, PropertyFrom prop,
      [String defaultValueRef]) {
    if (prop is ListPropertyFrom) {
      return writeFromListProperty(reference, prop, defaultValueRef);
    } else if (prop is MapPropertyFrom) {
      return writeFromMapProperty(reference, prop, defaultValueRef);
    } else if (prop is LeafPropertyFrom) {
      return writeFromLeafProperty(reference, prop, defaultValueRef);
    } else {
      throw new JaguarCliException('Dont know how to handle this!');
    }
  }

  String generate(String reference, [String defaultValueRef]) {
    return writeFromProperty(reference, field.property, defaultValueRef);
  }
}
