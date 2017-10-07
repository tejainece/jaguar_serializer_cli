///@nodoc
library jaguar_serializer.generator.parser.serializer;

import 'package:analyzer/dart/element/element.dart';
// import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

import '../common/common.dart';
import '../models/models.dart';

export '../models/models.dart' show FieldProcessorInfo;

part 'package:jaguar_serializer_cli/src/parser/field_to.dart';
part 'package:jaguar_serializer_cli/src/parser/field_from.dart';

class WriterInfo {
  final String name;

  final String modelName;

  final String modelString;

  final List<FieldTo> to;

  final List<FieldFrom> from;

  final Map<String, FieldProcessorInfo> processors;

  WriterInfo(this.name, this.modelName, this.modelString, this.to, this.from,
      this.processors);

  factory WriterInfo.fromInfo(SerializerInfo info) {
    List<FieldTo> tos = <FieldTo>[];

    for (ModelField field in info.model.to) {
      String fieldName = field.name;
      String fieldKey = field.name;

      if (info.to[fieldName] != null) fieldKey = info.to[fieldName];

      tos.add(_parseFieldTo(info, field, fieldKey));
    }

    List<FieldFrom> froms = <FieldFrom>[];

    for (ModelField field in info.model.from) {
      String fieldName = field.name;
      String fieldKey = field.name;

      if (info.from[fieldName] != null) fieldKey = info.from[fieldName];

      froms.add(_parseFieldFrom(info, field, fieldKey));
    }

    final String modelName = info.modelType.name;
    final String modelString = info.modelString ?? modelName;

    return new WriterInfo(
        info.name, modelName, modelString, tos, froms, info.processors);
  }
}
