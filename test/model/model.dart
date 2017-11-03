library models;

import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'model.g.dart';

class Player {
  String id;

  String name;

  String email;
}

@GenSerializer()
class PlayerCodec extends Serializer<Player> with _$PlayerCodec {
  @override
  Player createModel() => new Player();
}

@GenSerializer(ignore: const ['email'])
class PlayerIgnoreCodec extends Serializer<Player> with _$PlayerIgnoreCodec {
  @override
  Player createModel() => new Player();
}

@GenSerializer(fields: const {'email': const Ignore()})
class PlayerIgnoreFieldCodec extends Serializer<Player>
    with _$PlayerIgnoreFieldCodec {
  @override
  Player createModel() => new Player();
}
