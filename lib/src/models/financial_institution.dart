import 'dart:convert';

class FinancialInstitution {
  final String organization;
  final String financialInstitutionID;

  FinancialInstitution({
    required this.organization,
    required this.financialInstitutionID,
  });

  FinancialInstitution copyWith({
    String? organization,
    String? financialInstitutionID,
  }) {
    return FinancialInstitution(
      organization: organization ?? this.organization,
      financialInstitutionID:
          financialInstitutionID ?? this.financialInstitutionID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'organization': organization,
      'financial_institution_id': financialInstitutionID,
    };
  }

  factory FinancialInstitution.fromMapOfx(Map<String, dynamic> map) {
    return FinancialInstitution(
      organization: map['ORG'].toString(),
      financialInstitutionID: map['FID'].toString(),
    );
  }

  factory FinancialInstitution.fromMap(Map<String, dynamic> map) {
    return FinancialInstitution(
      organization: map['organization'].toString(),
      financialInstitutionID: map['financial_institution_id'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialInstitution.fromJson(String source) =>
      FinancialInstitution.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FinancialInstitution(organization: $organization, financialInstitutionID: $financialInstitutionID)';
}
