class PayloadRequestRegister {
  final String email;
  final String password;
  final String fullName;
  final String rolesName;

  PayloadRequestRegister(
      {this.fullName = '',
      this.email = '',
      this.password = '',
      this.rolesName = 'user'});

  factory PayloadRequestRegister.fromJson(Map<String, dynamic> json) =>
      PayloadRequestRegister(
          fullName: json['fullName'] as String,
          email: json['email'] as String,
          password: json['password'] as String,
          rolesName: json['rolesName'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'fullName': this.fullName,
        'email': this.email,
        'password': this.password,
        'rolesName': this.rolesName
      };
}
