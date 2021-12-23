class PayloadRequestVerificationCode {
  final String verificationCode;

  PayloadRequestVerificationCode({this.verificationCode = ''});

  factory PayloadRequestVerificationCode.fromJson(Map<String, dynamic> json) =>
      PayloadRequestVerificationCode(
          verificationCode: json['verificationCode'] as String);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'verificationCode': this.verificationCode};
}
