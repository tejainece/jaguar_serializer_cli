///@nodoc
import 'dart:async';

import 'package:analyzer/dart/element/element.dart';

import 'package:build/src/builder/build_step.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';

import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'models/models.dart';
import 'common/common.dart';

import 'parser/parser.dart';
import 'package:jaguar_serializer_cli/src/writer/writer.dart';

final Logger _log = new Logger("SerializerGenerator");

/// source_gen hook to generate serializer
class SerializerGenerator extends GeneratorForAnnotation<GenSerializer> {
  const SerializerGenerator();

  final _onlyClassMsg =
      "GenSerializer annotation can only be defined on a class.";

  @override
  FutureOr<String> generateForAnnotatedElement(Element element,
      ConstantReader annotation, BuildStep buildStep) {

    if (element is! ClassElement) throw new JaguarCliException(_onlyClassMsg);

    print("Generating serializer for ${element.name} ...");

    try {
      final instantiator = new Instantiator(element, annotation);

      final info = instantiator.instantiate();

      final writerInfo = new WriterInfo.fromInfo(info);

      final writer = new Writer(writerInfo);

      writer.generate();
      return writer.toString();
    } on JaguarCliException catch (e) {
      _log.severe(e.toString());
      return "// $e";
    }
  }
}
