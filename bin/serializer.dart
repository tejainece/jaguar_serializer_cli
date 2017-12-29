import 'dart:io';
import 'package:jaguar_serializer_cli/jaguar_serializer_build.dart';
import 'package:jaguar_serializer_cli/src/config/config.dart';

main(List<String> args) async {
  await _start(args);
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
_start(List<String> args) {
  if (args.length > 0) {
    if (args[0] == 'watch') {
      watch();
      return;
    } else if (args[0] == 'build') {
      build();
      return;
    } else if (args[0] == 'init') {
      _init();
      return;
    } else if (args[0] == 'version') {
      print('0.5.2');
      return;
    } else if (args[0] == 'help') {
      print(_usage);
      return;
    }
  }
  print(_usage);
}

/// Create Serializer Config File
_init() {
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