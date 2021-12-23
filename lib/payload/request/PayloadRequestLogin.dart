class PayloadRequestLogin {
  final String email;
  final String password;

  PayloadRequestLogin({this.email = '', this.password = ''});

  factory PayloadRequestLogin.fromJson(Map<String, dynamic> json) =>
      PayloadRequestLogin(
          email: json['email'] as String, password: json['password'] as String);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'email': this.email, 'password': this.password};
}
