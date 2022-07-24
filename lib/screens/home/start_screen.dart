import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/logic/table_bloc.dart';
import 'package:fil_lan/models/tables.dart';
import 'package:fil_lan/screens/Anmalan/anmalan.dart';
import 'package:fil_lan/screens/Anmalan/book_screen.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/screens/home/bottom_nav_screen.dart';
import 'package:fil_lan/screens/home/home_screen.dart';
import 'package:fil_lan/screens/home/profile_screen.dart';
import 'package:fil_lan/screens/home/studio_screen.dart';
import 'package:fil_lan/service/seat_service.dart';
import 'package:fil_lan/theme/fil_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TableBloc _blocSeater = TableBloc();
  List<Tables>? allSeats;
  int nrTables = 0;

  //var seats = [];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final seatService = Provider.of<SeatService>(context);

    Future.delayed(const Duration(seconds: 0), () async {
      print('hello');
      await authService.getData();
      await seatService.addTablesInFirebase(9, [1, 2, 3, 4, 5, 6, 7, 8, 9], 9);

      /*
      await seatService.getSeatsFromFirebas((e) {}).then((value) {
        setState(() {
          seats = seatService.getTables();
        });

        //print('fetched tables');
      });*/
    });
    Color back = Color(0xff212021);

    Color orange = Color(0xffFBBB78);
    Color blue = Color(0xff1ca3ae);
    Color pink = Color(0xfff8a29f);
    Color error = Color(0xffFF4566);
    Color text = Color(0xff595959);
    return MaterialApp(
      theme: FilLanTheme.filLanTheme,
      routes: {
        '/': (ctx) => const BottomNavScreen(),
        '/home_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: HomeScreen(),
            ),
        '/profile_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: ProfileScreen(),
            ),
        '/studio_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: const StudioScreen(),
            ),
        '/anmalan_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: Anmalan(seats: allSeats),
            ),
        '/book_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: const BookSeats(),
            ),
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _blocSeater.close();
    super.dispose();
  }

  getInitials() async {
    var tmp = await getlength();
    var seats = await getTables();

    setState(() {
      nrTables = tmp;
      allSeats = seats;
    });
  }

  Future<int> getlength() async {
    return await _firestore.collection('seats').snapshots().length;
  }

  Future<List<Tables>> getTables() async {
    List<Tables> tables = [];
    await _firestore.collection('seats').snapshots().forEach((element) {
      element.docs.forEach((item) {
        if (item.exists) {
          Map<String, dynamic> data = item.data();
          Tables table = Tables.fromJson(data);
          if (!tables.contains(table)) {
            tables.add(table);
          }
        }
      });
    });
    print('tables $tables');
    return tables;
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('seats');
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
