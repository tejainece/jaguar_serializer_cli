import "common/models/base/base.dart";
import "common/models/player/player.dart";
import "package:jaguar_serializer/jaguar_serializer.dart";
import "package:test/test.dart";

void main() {
  group("Base", () {
    group("To", () {
      Player player;

      setUp(() {
        player = new Player();
        player.name = "John";
        player.email = "john@noemail.com";
        player.age = 25;
        player.score = 1000;
        player.emailConfirmed = true;
      });

      // Check if toMap converts all fields to Map items
      test("Map", () {
        PlayerSerializer serializer = new PlayerSerializer();
        Map result = serializer.toMap(player);
        expect(result, containsPair("name", "John"));
        expect(result, containsPair("email", "john@noemail.com"));
        expect(result, containsPair("age", 25));
        expect(result, containsPair("score", 1000));
        expect(result, containsPair("emailConfirmed", true));
      });

      test("Map 2", () {
        player.emailConfirmed = null;

        PlayerSerializer serializer = new PlayerSerializer();

        Map result = serializer.toMap(player);
        expect(result, containsPair("name", "John"));
        expect(result, containsPair("email", "john@noemail.com"));
        expect(result, containsPair("age", 25));
        expect(result, containsPair("score", 1000));
        expect(result, isNot(contains("emailConfirmed")));
      });

      test("IgnoreField", () {
        PlayerSerializerIgnore serializer = new PlayerSerializerIgnore();

        Map result = serializer.toMap(player);
        expect(result, containsPair("name", "John"));
        expect(result, containsPair("email", "john@noemail.com"));
        expect(result, containsPair("age", 25));
        expect(result, containsPair("score", 1000));
        expect(result, isNot(contains("emailConfirmed")));
      });

      test("IgnoreFields", () {
        PlayerSerializerIgnores serializer = new PlayerSerializerIgnores();

        Map result = serializer.toMap(player);
        expect(result, containsPair("name", "John"));
        expect(result["email"], isNull);
        expect(result["age"], isNull);
        expect(result, containsPair("score", 1000));
        expect(result["emailConfirmed"], isNull);
      });

      test("Rename key", () {
        PlayerSerializerRename serializer = new PlayerSerializerRename();
        Map result = serializer.toMap(player);
        expect(result, containsPair("N", "John"));
        //todo: does not work on browser
        //expect(result, containsPair("E", "john@noemail.com"));
        //expect(result, containsPair("A", 25));
        expect(result, containsPair("S", 1000));
        expect(result, containsPair("eC", true));
      });

      // Check if toMap converts all fields to Map items
      test("Exclude by default", () {
        ExcludeByDefaultCodec serializer = new ExcludeByDefaultCodec();
        ExcludeByDefault model = new ExcludeByDefault();
        model.id = "2";
        model.name = "kleak";
        model.email = "cryptic";
        model.number = 2;

        Map result = serializer.toMap(model);
        expect(result, containsPair("id", "2"));
        expect(result, containsPair("name", "kleak"));
        expect(result, isNot(contains("email")));
        expect(result, isNot(contains("number")));
      });
    });

    group("From", () {
      Map m;

      setUp(() {
        m = {};
        m["name"] = "John";
        m["email"] = "john@noemail.com";
        m["age"] = 25;
        m["score"] = 1000;
        m["emailConfirmed"] = true;
      });

      // Check if fromMap converts all Map items to fields
      test("Map", () {
        PlayerSerializer serializer = new PlayerSerializer();
        Player player = serializer.fromMap(m);
        expect(player.name, "John");
        expect(player.email, "john@noemail.com");
        expect(player.age, 25);
        expect(player.score, 1000);
        expect(player.emailConfirmed, true);
      });

      // When field not present in Map
      test("Field not present", () {
        m.remove("emailConfirmed");

        PlayerSerializer serializer = new PlayerSerializer();
        Player player = serializer.fromMap(m);
        expect(player.name, "John");
        expect(player.email, "john@noemail.com");
        expect(player.age, 25);
        expect(player.score, 1000);
        expect(player.emailConfirmed, isNull);
      });

      // Ignore field
      test("IgnoreField", () {
        PlayerSerializerIgnore serializer = new PlayerSerializerIgnore();
        Player player = serializer.fromMap(m);
        expect(player.name, "John");
        expect(player.email, "john@noemail.com");
        expect(player.age, 25);
        expect(player.score, 1000);
        expect(player.emailConfirmed, isNull);
      });

      // Ignore fields
      test("IgnoreFields", () {
        PlayerSerializerIgnores serializer = new PlayerSerializerIgnores();
        Player player = serializer.fromMap(m);
        expect(player.name, "John");
        expect(player.email, null);
        expect(player.age, null);
        expect(player.score, 1000);
        expect(player.emailConfirmed, isNull);
      });

      test("Rename key", () {
        m = {};
        m["N"] = "John";
        m["email"] = "john@noemail.com";
        m["age"] = 25;
        m["S"] = 1000;
        m["eC"] = true;

        PlayerSerializerRename serializer = new PlayerSerializerRename();
        Player player = serializer.fromMap(m);
        expect(player.name, "John");
        expect(player.email, "john@noemail.com");
        expect(player.age, 25);
        expect(player.score, null);
        expect(player.emailConfirmed, true);
      });
    });

    test("Inheritance", () {
      Inheritance d = new Inheritance();
      final serializer = new InheritanceSerializer();
      expect(serializer.serialize(d),
          {"clazzA": "ClassA", "clazzB": "inheritance"});
      expect(serializer.serialize(d, withType: true), {
        "clazzA": "ClassA",
        "clazzB": "inheritance",
        defaultTypeInfoKey: "Inheritance"
      });
    });

    test("ModelInt", () {
      ModelInt d = new ModelInt();
      final serializer = new ModelIntSerializer();
      expect(serializer.serialize(d), {"bar": 42, "clazzA": "ClassA"});
      expect(serializer.serialize(d, withType: true),
          {"bar": 42, "clazzA": "ClassA", defaultTypeInfoKey: "ModelInt"});
    });

    test("ModelDouble", () {
      ModelDouble d = new ModelDouble();
      final serializer = new ModelDoubleSerializer();
      expect(serializer.serialize(d), {"bar": 42.42, "clazzA": "ClassA"});
      expect(serializer.serialize(d, withType: true), {
        "bar": 42.42,
        "clazzA": "ClassA",
        defaultTypeInfoKey: "ModelDouble"
      });
    });

    test("DateTimeProcessor", () {
      DateTime now = new DateTime.now();

      Date d = new Date(now);
      final serializer = new DateSerializer();
      expect(serializer.serialize(d),
          {"date": now.toIso8601String(), "clazzA": "ClassA"});
      expect(serializer.serialize(d, withType: true), {
        "date": now.toIso8601String(),
        "clazzA": "ClassA",
        defaultTypeInfoKey: "Date"
      });
    });

    test("Serialized name", () {
      ModelRenamed model = new ModelRenamed("foo");
      final serializer = new ModelRenamedSerializer();

      expect(serializer.serialize(model), {"renamed": "foo"});
    });

    test("Serialize With CustomModelName", () {
      CustomModelName model = new CustomModelName()..foo = "bar";
      final serializer = new CustomModelNameSerializer();
      expect(serializer.serialize(model, withType: true),
          {"foo": "bar", defaultTypeInfoKey: "MyCustomModelName"});
    });

    // Check if fromMap converts all Map items to fields
    test("Exclude by default", () {
      ExcludeByDefaultCodec serializer = new ExcludeByDefaultCodec();
      Map m = {};
      m["id"] = "1";
      m["name"] = "teja";
      m["email"] = "secret";
      m["number"] = 1000;

      ExcludeByDefault model = serializer.fromMap(m);
      expect(model.id, "1");
      expect(model.name, "teja");
      expect(model.email, null);
      expect(model.number, null);
    });
  });
}
