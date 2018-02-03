import 'package:jaguar_serializer/jaguar_serializer.dart';

class DateTimeProcessor implements FieldProcessor<DateTime, String> {
  const DateTimeProcessor();

  DateTime deserialize(String input) {
    return input != null ? DateTime.parse(input) : null;
  }

  String serialize(DateTime value) {
    return value?.toIso8601String();
  }
}
