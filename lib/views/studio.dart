import 'package:flutter/widgets.dart';

class Studio extends StatelessWidget {
  const Studio({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              "STUDIO",
              style: TextStyle(
                color: Color(0xffffffff),
                overflow: TextOverflow.ellipsis,
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            //countdown
          ),
          Text("hej"),
        ],
      ),
    );
  }
}
