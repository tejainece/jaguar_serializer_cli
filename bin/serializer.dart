import 'dart:io';
import 'package:jaguar_serializer_cli/jaguar_serializer_build.dart';
import 'package:jaguar_serializer_cli/src/config/config.dart';

main(List<String> args) async {
  await _start(args);
}


String get _usage => '''
Available commands:
  - build
  - watch
  - init
''';

// shoud we keep this ?
_start(List<String> args) {
  if (args.length > 0) {
    if (args[0] == 'watch') {
      return watch();
    } else if (args[0] == 'build') {
      return build();
    } else if (args[0] == 'init') {
      return _init();
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