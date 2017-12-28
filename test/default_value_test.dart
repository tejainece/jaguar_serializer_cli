import 'common/models/default_value/default_value.dart';
import 'package:test/test.dart';

void main() {
  group("Default Value", () {
    test("default value from constructor", () {
      final DefaultValue val = new DefaultValue();
      final decode = val.fromMap({});
      expect(decode.foo, equals("bar"));
      expect(decode.list, equals(["foo", "bar"]));
      expect(decode.bar, isNull);
    });

    test("default String", () {
      final DefaultString str = new DefaultString();
      final decode = str.fromMap({});
      expect(decode.foo, equals("bar"));
      expect(decode.bar, isNull);
    });

    test("default int", () {
      final DefaultInt integer = new DefaultInt();
      final decode = integer.fromMap({});
      expect(decode.foo, equals(42));
      expect(decode.bar, isNull);
    });

    test("default double", () {
      final DefaultDouble dbl = new DefaultDouble();
      final decode = dbl.fromMap({});
      expect(decode.foo, equals(42.42));
      expect(decode.bar, isNull);
    });

    test("default bool", () {
      final DefaultBool boolean = new DefaultBool();
      final decode = boolean.fromMap({});
      expect(decode.foo, isTrue);
      expect(decode.bar, isNull);
    });

    test("default value + processor + rename", () {
      final DefaultDate date = new DefaultDate();
      final decode = date.fromMap({});

      expect(decode.foo is DateTime, isTrue);
      expect(decode.foo, equals(DateTime.parse("1994-03-29T06:00:00Z")));
      expect(decode.bar, isNull);
    });
  });
}