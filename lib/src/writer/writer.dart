///@nodoc
library jaguar_serializer.generator.writer;

import 'package:jaguar_serializer_cli/src/common/common.dart';
import 'package:jaguar_serializer_cli/src/parser/parser.dart';

part 'to_item.dart';

part 'from_item.dart';

class Writer {
  final WriterInfo info;

  List<String> _providers = [];

  List<String> _customsProcessors = [];

  final _w = new StringBuffer();

  Writer(this.info);

  String get name => info.name;

  String get modelName => info.modelName;

  String toString() => _w.toString();

  void generate() {
    _w.writeln('abstract class _\$$name implements Serializer<$modelName> {');

    _providerWriter();

    _toWriter();

    _fromWriter();

    _w.writeln('String modelString() => "${info.modelString}";');

    _w.writeln('}');
  }

  void _serializedPropertyToWriter(PropertyTo to) {
    if (to is SerializedPropertyTo) {
      final fieldName = "_${firstCharToLowerCase(to.instantiationString)}";
      if (_providers.contains(fieldName)) {
        return;
      }
      _providers.add(fieldName);
      _w.writeln('final $fieldName = new ${to.instantiationString}();');
    } else if (to is ListPropertyTo) {
      _serializedPropertyToWriter(to.value);
    } else if (to is MapPropertyTo) {
      _serializedPropertyToWriter(to.key);
      _serializedPropertyToWriter(to.value);
    }
  }

  void _serializedPropertyFromWriter(PropertyFrom from) {
    if (from is SerializedPropertyFrom) {
      final fieldName = "_${firstCharToLowerCase(from.instantiationString)}";
      if (_providers.contains(fieldName)) {
        return;
      }
      _providers.add(fieldName);
      _w.writeln('final $fieldName = new ${from.instantiationString}();');
    } else if (from is ListPropertyFrom) {
      _serializedPropertyFromWriter(from.value);
    } else if (from is MapPropertyFrom) {
      _serializedPropertyFromWriter(from.key);
      _serializedPropertyFromWriter(from.value);
    }
  }

  void _serializedPropertyCustomWriter(
      String key, FieldProcessorInfo customProcessor) {
    final fieldName =
        "_${firstCharToLowerCase(customProcessor.instantiationString)}";
    if (!_customsProcessors.contains(fieldName)) {
      _customsProcessors.add(fieldName);
      _w.writeln(
          'final $fieldName = const ${customProcessor.instantiationString}();');
    }
  }

  void _providerWriter() {
    info.processors.forEach(_serializedPropertyCustomWriter);
    info.to.forEach((FieldTo item) {
      _serializedPropertyToWriter(item.property);
    });
    info.from.forEach((FieldFrom item) {
      _serializedPropertyFromWriter(item.property);
    });
    _w.writeln("");
  }

  void _toWriter() {
    _w.writeln(
        'Map toMap($modelName model, {bool withType: false, String typeKey}) {');
    _w.writeln(r'Map<String, dynamic> ret;');

    _w.writeln('if(model != null) {');
    _w.writeln('ret = <String, dynamic>{};');
    for (FieldTo item in info.to) {
      _toItemWriter(item);
    }
    _w.writeln('setTypeKeyValue(typeKey, modelString(), withType, ret);');
    _w.writeln('}');
    _w.writeln(r'return ret;');
    _w.writeln(r'}');
  }

  void _toItemWriter(FieldTo item) {
    if (item.nullable == true) {
      _w.writeln('setNullableValue(ret,');
    } else {
      _w.writeln('setNonNullableValue(ret,');
    }
    _w.writeln('"${item.key}",');
    final writer = new ToItemWriter(item.property);
    _w.writeln(writer.generate('model.${item.name}'));
    _w.writeln(');');
  }

  void _fromWriter() {
    _w.writeln(
        '$modelName fromMap(Map map, {$modelName model, String typeKey}) {');
    _w.writeln(r'if(map is! Map) {');
    _w.writeln(r'return null;');
    _w.writeln(r'}');

    _w.writeln('if(model is! $modelName) {');
    _w.writeln(r'model = createModel();');
    _w.writeln(r'}');

    for (FieldFrom item in info.from) {
      _fromItemWriter(item);
    }

    _w.writeln(r'return model;');
    _w.writeln(r'}');
  }

  void _fromItemWriter(FieldFrom item) {
    FromItemWriter writer = new FromItemWriter(item.property);

    _w.write('model.${item.name} = ');
    if (!item.nullable && item.defaultValue != null) {
      _w.write(writer.generate('map["${item.key}"] ?? ${item.defaultValue}'));
    } else if (!item.nullable &&
        item.defaultValue == null &&
        item.defaultValueFromConstructor) {
      _w.write(writer.generate('map["${item.key}"]'));
      _w.write(' ?? model.${item.name}');
    } else {
      _w.write(writer.generate('map["${item.key}"]'));
    }
    _w.write(';');
  }
}
