import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Row(
          children: [
            Container(
              child: Column(
                children: const [
                  Text("Pay with swish"),
                  Icon(Icons.swipe_sharp)
                ],
              ),
              margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade800,
              ),
            ),
            Container(
              child: Column(
                children: const [
                  Text("Pay with card"),
                  Icon(Icons.credit_card)
                ],
              ),
              margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/***
 * Padding(
      padding: const EdgeInsets.fromLTRB(36, 60, 36, 20),
      child: Container(
      margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade800,
      ),
      child: Column(
        children: [
          Text(
            widget.question,
            style: Fil_LanTheme.slTextStyle,
          ),
           Column(),),
 */