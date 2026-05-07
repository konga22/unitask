// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthData {
  final String name;
  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final int expiresAt;
  final int expiresIn;
  AuthData({
    required this.name,
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.expiresIn,
  });

  AuthData copyWith({
    String? name,
    String? tokenType,
    String? accessToken,
    String? refreshToken,
    int? expiresAt,
    int? expiresIn,
  }) {
    return AuthData(
      name: name ?? this.name,
      tokenType: tokenType ?? this.tokenType,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'token_type': tokenType,
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt,
      'expires_in': expiresIn,
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      name: map['name'],
      tokenType: map['token_type'],
      accessToken: map['access_token'],
      refreshToken: map['refresh_token'],
      expiresAt: map['expires_at'],
      expiresIn: map['expires_in'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) =>
      AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthData(name: $name, tokenType: $tokenType, accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(covariant AuthData other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.tokenType == tokenType &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.expiresAt == expiresAt &&
        other.expiresIn == expiresIn;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        tokenType.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode ^
        expiresAt.hashCode ^
        expiresIn.hashCode;
  }
}
