import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SwichHome extends StatefulWidget {
  const SwichHome({Key? key}) : super(key: key);

  @override
  State<SwichHome> createState() => _SwichHomeState();
}

class _SwichHomeState extends State<SwichHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Text("Continue to checkout"),
        ElevatedButton(onPressed: () => pay(), child: Text("Pay with swish"))
      ],
    )));
  }

  pay() {}
}
