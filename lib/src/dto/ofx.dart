// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ofx/src/adapter/date_time_adapter.dart';
import 'package:ofx/src/adapter/xml_to_json_adapter.dart';
import 'package:ofx/src/models/financial_institution.dart';
import 'package:ofx/src/models/status.dart';
import 'package:ofx/src/models/transaction.dart';

class Ofx {
  final Status statusOfx;
  final DateTime server;
  final DateTime serverLocal;
  final String language;
  final FinancialInstitution financialInstitution;
  final String transactionUniqueID;
  final Status statusTransaction;
  final String currency;
  final String bankID;
  final String accountID;
  final String accountType;
  final DateTime start;
  final DateTime startLocal;
  final DateTime end;
  final DateTime endLocal;
  final List<Transaction> transactions;

  Ofx({
    required this.statusOfx,
    required this.server,
    required this.serverLocal,
    required this.language,
    required this.financialInstitution,
    required this.transactionUniqueID,
    required this.statusTransaction,
    required this.currency,
    required this.bankID,
    required this.accountID,
    required this.accountType,
    required this.start,
    required this.startLocal,
    required this.end,
    required this.endLocal,
    required this.transactions,
  });

  Ofx copyWith({
    Status? statusOfx,
    DateTime? server,
    DateTime? serverLocal,
    String? language,
    FinancialInstitution? financialInstitution,
    String? transactionUniqueID,
    Status? statusTransaction,
    String? currency,
    String? bankID,
    String? accountID,
    String? accountType,
    DateTime? start,
    DateTime? startLocal,
    DateTime? end,
    DateTime? endLocal,
    List<Transaction>? transactions,
  }) {
    return Ofx(
      statusOfx: statusOfx ?? this.statusOfx,
      server: server ?? this.server,
      serverLocal: serverLocal ?? this.serverLocal,
      language: language ?? this.language,
      financialInstitution: financialInstitution ?? this.financialInstitution,
      transactionUniqueID: transactionUniqueID ?? this.transactionUniqueID,
      statusTransaction: statusTransaction ?? this.statusTransaction,
      currency: currency ?? this.currency,
      bankID: bankID ?? this.bankID,
      accountID: accountID ?? this.accountID,
      accountType: accountType ?? this.accountType,
      start: start ?? this.start,
      startLocal: startLocal ?? this.startLocal,
      end: end ?? this.end,
      endLocal: endLocal ?? this.endLocal,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status_ofx': statusOfx.toMap(),
      'server': server.millisecondsSinceEpoch,
      'server_local': serverLocal.millisecondsSinceEpoch,
      'language': language,
      'financial_institution': financialInstitution.toMap(),
      'transaction_unique_id': transactionUniqueID,
      'status_transaction': statusTransaction.toMap(),
      'currency': currency,
      'bank_id': bankID,
      'account_id': accountID,
      'account_type': accountType,
      'start': start.millisecondsSinceEpoch,
      'start_local': startLocal.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'end_local': endLocal.millisecondsSinceEpoch,
      'transactions': transactions.map((x) => x.toMap()).toList(),
    };
  }

  factory Ofx.fromString(String xml) {
    var map = XmlToJsonAdapter.adapter(xml);
    var ofx = map['OFX'];
    var signon = ofx['SIGNONMSGSRSV1']['SONRS'];
    var statement = ofx['BANKMSGSRSV1']['STMTTRNRS'];
    var statementTransaction = statement['STMTRS'];
    var bank = statementTransaction['BANKACCTFROM'];
    var bankTransactions = statementTransaction['BANKTRANLIST'];

    return Ofx(
      statusOfx: Status.fromMapOfx(
        signon['STATUS'] as Map<String, dynamic>,
      ),
      server: DateTimeAdapter.stringToDateTime(signon['DTSERVER']),
      serverLocal: DateTimeAdapter.stringDateTimeInTimeZoneLocal(
        signon['DTSERVER'],
      ),
      language: signon['LANGUAGE'].toString(),
      financialInstitution: FinancialInstitution.fromMapOfx(
        signon['FI'],
      ),
      transactionUniqueID: statement['TRNUID'].toString(),
      statusTransaction: Status.fromMap(
        statement['STATUS'] as Map<String, dynamic>,
      ),
      currency: statementTransaction['CURDEF'].toString(),
      bankID: bank['BANKID'].toString(),
      accountID: bank['ACCTID'].toString(),
      accountType: bank['ACCTTYPE'].toString(),
      start: DateTimeAdapter.stringToDateTime(bankTransactions['DTSTART']),
      startLocal: DateTimeAdapter.stringDateTimeInTimeZoneLocal(
          bankTransactions['DTSTART']),
      end: DateTimeAdapter.stringToDateTime(bankTransactions['DTEND']),
      endLocal: DateTimeAdapter.stringDateTimeInTimeZoneLocal(
          bankTransactions['DTEND']),
      transactions: List<Transaction>.from(
        (bankTransactions['STMTTRN'] as List<dynamic>).map<Transaction>(
          (x) => Transaction.fromMapOfx(x),
        ),
      ),
    );
  }

  factory Ofx.fromMap(Map<String, dynamic> map) {
    return Ofx(
      statusOfx: Status.fromMap(map['status_ofx'] as Map<String, dynamic>),
      server: DateTime.fromMillisecondsSinceEpoch(map['server'] as int),
      serverLocal:
          DateTime.fromMillisecondsSinceEpoch(map['server_local'] as int),
      language: map['language'] as String,
      financialInstitution: FinancialInstitution.fromMap(
          map['financial_institution'] as Map<String, dynamic>),
      transactionUniqueID: map['transaction_unique_id'] as String,
      statusTransaction:
          Status.fromMap(map['status_transaction'] as Map<String, dynamic>),
      currency: map['currency'] as String,
      bankID: map['bank_id'] as String,
      accountID: map['account_id'] as String,
      accountType: map['account_type'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
      startLocal:
          DateTime.fromMillisecondsSinceEpoch(map['start_local'] as int),
      end: DateTime.fromMillisecondsSinceEpoch(map['end'] as int),
      endLocal: DateTime.fromMillisecondsSinceEpoch(map['end_local'] as int),
      transactions: List<Transaction>.from(
        (map['transactions'] as List<dynamic>).map<Transaction>(
          (x) => Transaction.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory Ofx.fromJson(String source) =>
      Ofx.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Ofx(statusOfx: $statusOfx, server: $server, serverLocal: $serverLocal, language: $language, financialInstitution: $financialInstitution, transactionUniqueID: $transactionUniqueID, statusTransaction: $statusTransaction, currency: $currency, bankID: $bankID, accountID: $accountID, accountType: $accountType, start: $start, startLocal: $startLocal, end: $end, endLocal: $endLocal, transactions: $transactions)';
  }
}
