///@nodoc
import 'dart:async';
import 'dart:io';

import 'package:build_runner/build_runner.dart' as build_runner;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';

import 'package:build/src/builder/build_step.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';

import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'models/models.dart';
import 'common/common.dart';

import 'package:jaguar_serializer_cli/src/phase/phase.dart';
import 'parser/parser.dart';
import 'package:jaguar_serializer_cli/src/writer/writer.dart';
import 'package:jaguar_serializer_cli/src/config/config.dart';

/// Watch files and trigger build function
Stream<build_runner.BuildResult> watch() =>
    build_runner.watch(phaseGroup(), deleteFilesByDefault: true);

/// Build all Serializer
Future<build_runner.BuildResult> build() =>
    build_runner.build(phaseGroup(), deleteFilesByDefault: true);

/// Create Serializer Config File
init() {
  final pubspec = new File("pubspec.yaml");
  if (!pubspec.existsSync()) {
    stderr.writeln("Error: 'pubspec.yaml' not found.");
  } else {
    final configFile = new File(jaguarSerializerConfigFile);
    if (configFile.existsSync()) {
      stderr.writeln("Error: '$jaguarSerializerConfigFile' already exist.");
    } else {
      configFile.writeAsStringSync('''
serializers:
# Add files with your serializable class here.
#- lib/models/my_model.dart
      ''');
    }
  }
}

String get _usage => '''
Available commands:
  - build   -> Generates serializers
  - watch   -> Generates serializers on file changes
  - init    -> Intializes a project for usage with serializer
  - version -> Prints version serializer CLI
  - help    -> Prints this help text
''';

// shoud we keep this ?
start(List<String> args) {
  if (args.length > 0) {
    if (args[0] == 'watch') {
      watch();
      return;
    } else if (args[0] == 'build') {
      build();
      return;
    } else if (args[0] == 'init') {
      init();
      return;
    } else if (args[0] == 'version') {
      print('0.5.1');
      return;
    } else if (args[0] == 'help') {
      print(_usage);
      return;
    }
  }
  print(_usage);
}

final Logger _log = new Logger("SerializerGenerator");

/// source_gen hook to generate serializer
class SerializerGenerator extends Generator {
  const SerializerGenerator();

  final _onlyClassMsg =
      "GenSerializer annotation can only be defined on a class.";

  /// This method is called when build finds an element with
  /// [GenSerializer] annotation.
  ///
  /// [el] is the element annotated with [Api]
  @override
  Future<String> generate(Element el, BuildStep buildStep) async {
    List<ElementAnnotation> annots = el.metadata
        .where((md) =>
            isGenSerializer.isExactlyType(md.computeConstantValue().type))
        .toList();

    if (annots.isEmpty) return null;

    if (annots.length > 1) {
      throw new StateError('Cannot have more than one matching annotation');
    }

    if (el is! ClassElement) throw new JaguarCliException(_onlyClassMsg);

    print("Generating serializer for ${el.name} ...");

    try {
      final SerializerInfo info = _make(el, annots.first);

      final writerInfo = new WriterInfo.fromInfo(info);

      final writer = new Writer(writerInfo);

      writer.generate();
      return writer.toString();
    } on JaguarCliException catch (e) {
      _log.severe(e.toString());
      return "// $e";
    }
  }

  SerializerInfo _make(ClassElement el, ElementAnnotation annot) {
    final DartObject obj = annot.computeConstantValue();
    final instantiator = new Instantiator(el, obj);
    return instantiator.instantiate();
  }
}
