class LoginResponseModel {

  LoginResponseModel(
      this.accessToken, this.tokenType, this.expiresIn, this.userId);

  LoginResponseModel.fromJson(dynamic json) {
    accessToken = json['access_token'] as String;
    tokenType = json['token_type'] as String;
    expiresIn = json['expires_in'] as int;
    userId = json['user_id'] as int;
  }

  late String accessToken;
  late String tokenType;
  late int expiresIn;
  late int userId;


  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['user_id'] = userId;
    return data;
  }
}
