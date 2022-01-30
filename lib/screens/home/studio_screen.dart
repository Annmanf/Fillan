import 'package:flutter/material.dart';

class StudioScreen extends StatelessWidget {
  static const routeName = '/studio-screen';
  const StudioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 50, 36, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(
            child: Text(
              "STUDIO",
              style: TextStyle(
                color: Color(0xffffffff),
                overflow: TextOverflow.visible,
                fontFamily: 'Roboto',
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
