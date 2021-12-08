class UserInfoModel {
  UserInfoModel(
      this.id,
      this.classObjectId,
      this.firstName,
      this.lastName,
      this.age,
      this.email,
      this.className
      );

  UserInfoModel.fromJson(dynamic json) {
    id = json['id'] as int;
    classObjectId = json['class_id'] as String;
    firstName = json['first_name'] as String;
    lastName = json['last_name'] as String;
    age = json['age'] as String;
    email = json['email'] as String;
    className = json['class_name'] as String;
  }

  late int id;
  late String classObjectId;
  late String firstName;
  late String lastName;
  late String age;
  late String email;
  late String className;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['class_id'] = classObjectId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['age'] = age;
    data['email'] = email;
    data['class_name'] = className;
    return data;
  }
}
