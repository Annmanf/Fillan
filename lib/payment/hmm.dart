import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_swish_payment/flutter_swish_payment.dart';

class SwishPayment {
  String payeePaymentReference;
  String callbackUrl;
  String payeeAlias;
  String amount;
  String currency;
  String message;

  SwishPayment(this.payeePaymentReference, this.callbackUrl, this.payeeAlias,
      this.amount, this.currency, this.message);

  SwishPayment.fromJson(Map<String, dynamic> json)
      : payeePaymentReference = json['payeePaymentReference'],
        callbackUrl = json['callbackUrl'],
        payeeAlias = json['payeeAlias'],
        amount = json['amount'],
        currency = json['currency'],
        message = json['message'];

  Map<String, dynamic> toJson() => {
        'payeePaymentReference': payeePaymentReference,
        'callbackUrl': callbackUrl,
        'payeeAlias': payeeAlias,
        'amount': amount,
        'currency': currency,
        'message': message,
      };

  Future<void> some() async {
    WidgetsFlutterBinding.ensureInitialized();
    ByteData cert = await rootBundle.load(
      'assets/swish_certificate.pem',
    );
    ByteData key = await rootBundle.load(
      'assets/swish_certificate.key',
    );

    String credential = "passwordForCertificates";

    SwishAgent swishAgent = SwishAgent.initializeAgent(
      cert: cert,
      key: key,
      credential: credential,
    );
    SwishClient swishClient = SwishClient(
      swishAgent: swishAgent,
    );
  }

  Future<SwishPaymentRequest> createPaymentRequest({
    required SwishPaymentData swishPaymentData,
  }) async {
    http.Response response = await _httpClient.put(
      Uri.parse(
        'https://mss.cpc.getswish.net/swish-cpcapi/api/v2/paymentrequests/' +
            swishAgent.instructionUUID,
      ),
      headers: {
        'Content-type': 'application/json',
      },
      body: json.encode(
        swishPaymentData.toJson(),
      ),
    );

    if (response.headers['location'] != null) {
      return await getPayment(location: response.headers['location']!);
    }

    List<dynamic> responseBody = jsonDecode(
      utf8.decode(
        response.bodyBytes,
      ),
    ) as List<dynamic>;

    Map<String, dynamic> errorInformation =
        responseBody[0] as Map<String, dynamic>;
    return SwishPaymentRequest.fromError(
      statusCode: response.statusCode,
      errorCode: errorInformation['errorCode'],
      errorMessage: errorInformation['errorMessage'],
    );
  }

  Future<String> postWithClientCertificate() async {
    final swishEndpoint = 'https://mss.cpc.getswish.net/swish-cpcapi/api/v1';
    final credential = 'swish';
    var context = SecurityContext.defaultContext;
    ByteData cert = await rootBundle.load('assets/cert/SwishCertificate.p12');
    ByteData key = await rootBundle.load('assets/cert/SwishPrivateKey.key');
    context.useCertificateChainBytes(cert.buffer.asUint8List(),
        password: credential);
    context.usePrivateKeyBytes(key.buffer.asUint8List());
    HttpClient client = new HttpClient(context: context);

    var data = createSamplePayment().toJson();
    var request = await client.openUrl(
        'POST', Uri.parse(swishEndpoint + '/paymentrequests'));
    request.headers.set(HttpHeaders.contentTypeHeader, 'APPLICATION/JSON');
    request.write(json.encode(data));
    var response = await request.close();

    print(response.statusCode);
    var token = response.headers.value('paymentrequesttoken');
    print(token);
    return token!;
  }

  SwishPayment createSamplePayment() {
    return SwishPayment(
        '0123456789',
        'https://example.com/api/swishcb/paymentrequests',
        '1231181189',
        '100',
        'SEK',
        'Kingston USB Flash Drive 8 GB');
  }
}
