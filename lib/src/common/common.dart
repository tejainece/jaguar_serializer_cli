
import 'package:analyzer/dart/element/type.dart';

import 'package:source_gen/source_gen.dart';
import 'package:jaguar_serializer/serializer.dart';

final isSerializer = new TypeChecker.fromRuntime(Serializer);

final isGenSerializer = new TypeChecker.fromRuntime(GenSerializer);

final isEncodeOnly = new TypeChecker.fromRuntime(EncodeOnly);

final isDecodeOnly = new TypeChecker.fromRuntime(DecodeOnly);

final isEnDecode = new TypeChecker.fromRuntime(EnDecode);

final isIgnore= new TypeChecker.fromRuntime(Ignore);

final isList= new TypeChecker.fromRuntime(List);

final isMap= new TypeChecker.fromRuntime(Map);

final isString= new TypeChecker.fromRuntime(String);

final isInt= new TypeChecker.fromRuntime(int);

final isDouble= new TypeChecker.fromRuntime(double);

final isNum= new TypeChecker.fromRuntime(num);

final isBool= new TypeChecker.fromRuntime(bool);

bool isBuiltin(DartType type) {
  if(isString.isExactlyType(type)) return true;
  if(isInt.isExactlyType(type)) return true;
  if(isDouble.isExactlyType(type)) return true;
  if(isNum.isExactlyType(type)) return true;
  if(isBool.isExactlyType(type)) return true;

  return false;
}

