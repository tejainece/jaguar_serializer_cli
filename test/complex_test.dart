import 'common/models/base/base.dart';
import 'common/models/complex/complex.dart';
import 'package:test/test.dart';

void main() {
  group("Complex", () {
    final serializer = new ComplexSerializer();
    test("To", () {
      Complex complex = new Complex()
        ..nums = [1, 2.2, 3]
        ..strings = ["1", "2", "3"]
        ..bools = [true, false, true]
        ..ints = [1, 2, 3]
        ..doubles = [1.1, 2.2, 3.3]
        //  ..dates = [new DateTime(2016, 12, 24), new DateTime(2016, 12, 25), new DateTime(2016, 12, 26)]
        ..ignores = [
          new WithIgnore("1337A", "ThisIsASecretA"),
          new WithIgnore("1337B", "ThisIsASecretB")
        ]
        ..numSet = {"numA": 1, "numB": 12.2}
        ..stringSet = {"strA": "1", "strB": "3"}
        ..boolSet = {"ok": true, "nok": false}
        ..intSet = {"intA": 1, "intB": 12}
        ..doubleSet = {"dblA": 1.1, "dblB": 12.1}
        // ..dateSet = {"fiesta": new DateTime(2016, 12, 24), "christmas": new DateTime(2016, 12, 25)}
        ..ignoreSet = {
          "A": new WithIgnore("1337A", "ThisIsASecretA"),
          "B": new WithIgnore("1337B", "ThisIsASecretB")
        }
        ..listInnerMap1 = {
          "test": ["123456"]
        };

      final mapNoType = serializer.serialize(complex);

      expect(mapNoType["nums"], equals([1, 2.2, 3]));
      expect(mapNoType["strings"], equals(["1", "2", "3"]));
      expect(mapNoType["bools"], equals([true, false, true]));
      expect(mapNoType["ints"], equals([1, 2, 3]));
      expect(mapNoType["doubles"], equals([1.1, 2.2, 3.3]));
      expect(
          mapNoType["ignores"],
          equals([
            {"a": "1337A"},
            {"a": "1337B"}
          ]));
      expect(mapNoType["numSet"], equals({"numA": 1, "numB": 12.2}));
      expect(mapNoType["stringSet"], equals({"strA": "1", "strB": "3"}));
      expect(mapNoType["boolSet"], equals({"ok": true, "nok": false}));
      expect(mapNoType["intSet"], equals({"intA": 1, "intB": 12}));
      expect(mapNoType["doubleSet"], equals({"dblA": 1.1, "dblB": 12.1}));
      expect(
          mapNoType["ignoreSet"],
          equals({
            "A": {"a": "1337A"},
            "B": {"a": "1337B"}
          }));
      expect(
          mapNoType["listInnerMap1"],
          equals({
            "test": ["123456"]
          }));

      final mapType =
          serializer.serialize(complex, withType: true, typeKey: "_type");
      expect(
          mapType["ignores"],
          equals([
            {"a": "1337A", "_type": "WithIgnore"},
            {"a": "1337B", "_type": "WithIgnore"}
          ]));
      expect(
          mapType["ignoreSet"],
          equals({
            "A": {"a": "1337A", "_type": "WithIgnore"},
            "B": {"a": "1337B", "_type": "WithIgnore"}
          }));
      expect(mapType["_type"], equals("Complex"));
    });

    test("From", () {
      Complex complex = serializer.deserialize({
        "@t": "Complex",
        "nums": [1, 2.2, 3],
        "strings": ["1", "2", "3"],
        "bools": [true, false, true],
        "ints": [1, 2, 3],
        "doubles": [1.1, 2.2, 3.3],
        "ignores": [
          {"a": "1337A", "@t": "WithIgnore"},
          {"a": "1337B", "@t": "WithIgnore"}
        ],
        "numSet": {"numA": 1, "numB": 12.2},
        "stringSet": {"strA": "1", "strB": "3"},
        "boolSet": {"ok": true, "nok": false},
        "intSet": {"intA": 1, "intB": 12},
        "doubleSet": {"dblA": 1.1, "dblB": 12.1},
        "ignoreSet": {
          "A": {"a": "1337A", "@t": "WithIgnore"},
          "B": {"a": "1337B", "@t": "WithIgnore"}
        },
        "listInnerMap1": {
          "test": ["123456"]
        }
      });
      //  "dateSet": {"fiesta": "2016-12-24T00:00:00.000", "christmas": "2016-12-25T00:00:00.000"},
      // "dates": ["2016-12-24T00:00:00.000", "2016-12-25T00:00:00.000", "2016-12-26T00:00:00.000"],

      expect(complex.nums, [1, 2.2, 3]);
      expect(complex.strings, ["1", "2", "3"]);
      expect(complex.bools, [true, false, true]);
      expect(complex.ints, [1, 2, 3]);
      expect(complex.doubles, [1.1, 2.2, 3.3]);
      expect(complex.numSet, {"numA": 1, "numB": 12.2});
      expect(complex.stringSet, {"strA": "1", "strB": "3"});
      expect(complex.boolSet, {"ok": true, "nok": false});
      expect(complex.intSet, {"intA": 1, "intB": 12});
      expect(complex.doubleSet, {"dblA": 1.1, "dblB": 12.1});
      expect(complex.listInnerMap1, {
        "test": ["123456"]
      });
    });
  });
}
