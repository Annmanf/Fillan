import 'package:fil_lan/payment/hmm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swish_payment/flutter_swish_payment.dart';

import 'package:url_launcher/url_launcher.dart';

void main() => runApp(SwishDemoApp());

class SwishDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fil_lan example swish',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SwishDemo(),
    );
  }
}

class SwishDemoState extends State<SwishDemo> {
  String _paymentRequestToken = 'none';

  Widget futureTokenWidgetOnButtonPress() {
    return new FutureBuilder<String>(builder: (context, snapshot) {
      if (_paymentRequestToken != null) {
        return new Text('Payment token: ' + _paymentRequestToken);
      }
      return new Text('no token yet');
    });
  }

  Future<Null> _getToken() async {
    String token = await postWithClientCertificate();
    setState(() {
      _paymentRequestToken = token;
    });
  }

  _openSwish() async {
    var callbackUrl = 'https://www.google.com';
    var url = 'swish://paymentrequest?token=' +
        _paymentRequestToken +
        '&callbackurl=' +
        callbackUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> opeSwish({
    required SwishPaymentRequest swishPaymentRequest,
  }) async {
    String openSwishUrl = 'swish://paymentrequest?token=' +
        swishPaymentRequest.id! +
        '&callbackurl=' +
        swishPaymentRequest.callbackUrl!;
    if (await canLaunch(openSwishUrl)) {
      await launch(openSwishUrl);
    } else {
      throw 'Could not launch Swish';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swish Demo AppBar Title'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: const Text('Get payment token from Swish'),
                onPressed: _getToken,
              ),
              futureTokenWidgetOnButtonPress(),
              ElevatedButton(
                child: const Text('Pay with Swish'),
                onPressed: _openSwish,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwishDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SwishDemoState();
}
