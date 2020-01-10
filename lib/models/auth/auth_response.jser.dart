// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AuthResponseJsonSerializer
    implements Serializer<AuthResponse> {
  Serializer<AuthResponseMeta> __authResponseMetaJsonSerializer;
  Serializer<AuthResponseMeta> get _authResponseMetaJsonSerializer =>
      __authResponseMetaJsonSerializer ??= AuthResponseMetaJsonSerializer();
  @override
  Map<String, dynamic> toMap(AuthResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'meta', _authResponseMetaJsonSerializer.toMap(model.meta));
    return ret;
  }

  @override
  AuthResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = AuthResponse();
    obj.meta = _authResponseMetaJsonSerializer.fromMap(map['meta'] as Map);
    return obj;
  }
}

abstract class _$AuthResponseMetaJsonSerializer
    implements Serializer<AuthResponseMeta> {
  @override
  Map<String, dynamic> toMap(AuthResponseMeta model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'accessToken', model.accessToken);
    return ret;
  }

  @override
  AuthResponseMeta fromMap(Map map) {
    if (map == null) return null;
    final obj = AuthResponseMeta();
    obj.accessToken = map['accessToken'] as String;
    return obj;
  }
}
