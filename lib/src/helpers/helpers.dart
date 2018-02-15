library jaguar_serializer.generator.helpers;

import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:source_gen/source_gen.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'parser_helper.dart';
part 'type_helper.dart';

class JaguarCliException implements Exception {
  final message;

  JaguarCliException([this.message]);

  String toString() {
    if (message == null) return "JaguarCliException";
    return "JaguarCliException: $message";
  }
}

String firstCharToLowerCase(String str) =>
    str[0].toLowerCase() + str.substring(1);
