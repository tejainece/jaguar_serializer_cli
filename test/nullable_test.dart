import 'common/models/nullable/nullable.dart';
import 'dart:convert';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:test/test.dart';

main() {
  group("Nullable", () {
    test("global nullable", () {
      final g = new NullableGlobal();
      final decode = g.fromMap({});
      expect(decode.foo, isNull);
      expect(decode.bar, isNull);
      expect(decode.list, isNull);
    });

    test("global nullable with 1 non nullable", () {
      final g = new NullableGlobal1();
      final decode = g.fromMap({});
      expect(decode.foo, equals("bar"));
      expect(decode.bar, isNull);
    });

    test("global non nullable", () {
      final g = new NonNullableGlobal();
      final decode = g.fromMap({});
      expect(decode.foo, equals("bar"));
      expect(decode.bar, equals("foo"));
    });

    test("global non nullable with 1 nullable", () {
      final g = new NonNullableGlobal1();
      final decode = g.fromMap({});
      expect(decode.foo, isNull);
      expect(decode.bar, equals("foo"));
    });

    test("nullable + rename + processor", () {
      final g = new NullableComplex();
      final decode = g.fromMap({"foo": 424242424242});
      expect(decode.foo, isNull);
      expect(decode.bar, isNull);
    });

    test("non-nullable + rename + processor", () {
      final g = new NonNullableComplex();
      final decode = g.fromMap({});
      expect(decode.foo, equals("1994-03-29T06:00:00Z"));
      expect(decode.bar, isNull);
    });

    test("Null Test", () {
      NullTest d = new NullTest();
      d.testModel = [null];
      d.test = "test";
      final serializer = new NullTestSerializer();
      expect(serializer.serialize(d), {
        "test": "test",
        "testModel": [null]
      });
      expect(serializer.serialize(d, withType: true), {
        "test": "test",
        "testModel": [null],
        defaultTypeInfoKey: "NullTest"
      });
    });
  });
}
