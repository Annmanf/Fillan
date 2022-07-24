import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class SwishTest extends StatelessWidget {
  const SwishTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

var jsonMap = {
  'payeePaymentReference': '1',
  'time': new DateTime.now().toIso8601String(),
  'payeeAlias': "0753280860",
  'amount': 20,
  'currency': "sek",
};/*
_paymentRequest() {
  String jsonStr = jsonEncode(jsonMap);
  print(jsonMap);
  HttpClient.put(Uri.encodeFull(url),
      body: jsonStr, headers: {"Accept": "application/json"}).then((result) {
    print(result.statusCode);
    print(result.body);
  });
}
*/