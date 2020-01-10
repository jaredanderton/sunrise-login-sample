import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'auth_response.jser.dart';


class AuthResponse {
  AuthResponseMeta meta;
}

@GenSerializer()
class AuthResponseJsonSerializer extends Serializer<AuthResponse> with _$AuthResponseJsonSerializer {}

class AuthResponseMeta {
  String accessToken;
}

@GenSerializer()
class AuthResponseMetaJsonSerializer extends Serializer<AuthResponseMeta> with _$AuthResponseMetaJsonSerializer {}