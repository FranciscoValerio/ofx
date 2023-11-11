import 'dart:convert';

class Status {
  final int code;
  final String severity;

  Status({
    required this.code,
    required this.severity,
  });

  Status copyWith({
    int? code,
    String? severity,
  }) {
    return Status(
      code: code ?? this.code,
      severity: severity ?? this.severity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'severity': severity,
    };
  }

  factory Status.fromMapOfx(Map<String, dynamic> map) {
    return Status(
      code: int.parse(map['CODE']),
      severity: map['SEVERITY'].toString(),
    );
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      code: map['code'] ?? 0,
      severity: map['severity'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) =>
      Status.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Status(code: $code, severity: $severity)';
}
