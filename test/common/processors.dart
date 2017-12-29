import 'package:jaguar_serializer/jaguar_serializer.dart';

class DateTimeProcessor implements FieldProcessor<DateTime, String> {
  const DateTimeProcessor();

  DateTime deserialize(String input) {
    return DateTime.parse(input);
  }

  String serialize(DateTime value) {
    return value.toIso8601String();
  }
}

class MapKeyNumToStringProcessor
    implements FieldProcessor<Map<num, String>, Map<dynamic, String>> {
  const MapKeyNumToStringProcessor();

  Map<num, String> deserialize(final Map<dynamic, String> input) {
    if (input == null) {
      return null;
    }
    Map<num, String> fromMap = {};
    for (var key in input.keys) {
      if (key is String) {
        fromMap[num.parse(key)] = input[key];
      } else if (key is num) {
        fromMap[key] = input[key];
      }
    }
    return fromMap;
  }

  Map<String, String> serialize(final Map<num, String> value) {
    if (value == null) {
      return null;
    }
    Map<String, String> toMap = {};
    for (num key in value.keys) {
      toMap[key.toString()] = value[key];
    }
    return toMap;
  }
}
