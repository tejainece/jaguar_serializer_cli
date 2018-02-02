import 'package:analyzer/dart/element/type.dart';

import 'package:source_gen/source_gen.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

const isSerializer = const TypeChecker.fromRuntime(Serializer);

const isGenSerializer = const TypeChecker.fromRuntime(GenSerializer);

const isEncodeOnly = const TypeChecker.fromRuntime(EncodeOnly);

const isDecodeOnly = const TypeChecker.fromRuntime(DecodeOnly);

const isEnDecode = const TypeChecker.fromRuntime(EnDecode);

const isIgnore = const TypeChecker.fromRuntime(Ignore);

const isList = const TypeChecker.fromRuntime(List);

const isMap = const TypeChecker.fromRuntime(Map);

const isString = const TypeChecker.fromRuntime(String);

const isInt = const TypeChecker.fromRuntime(int);

const isDouble = const TypeChecker.fromRuntime(double);

const isNum = const TypeChecker.fromRuntime(num);

const isBool = const TypeChecker.fromRuntime(bool);

const isProperty = const TypeChecker.fromRuntime(Property);

const isFieldProcessor = const TypeChecker.fromRuntime(FieldProcessor);

bool isBuiltin(DartType type) {
  if (isString.isExactlyType(type)) return true;
  if (isInt.isExactlyType(type)) return true;
  if (isDouble.isExactlyType(type)) return true;
  if (isNum.isExactlyType(type)) return true;
  if (isBool.isExactlyType(type)) return true;

  return false;
}

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
