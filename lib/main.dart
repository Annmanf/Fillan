import 'dart:convert';
import 'dart:developer';
import 'package:fil_lan/logic/table_bloc.dart';

import 'package:fil_lan/screens/start/login_screen.dart';
import 'package:fil_lan/screens/start/opening_screen.dart';
import 'package:fil_lan/screens/start/register_screen.dart';
import 'package:fil_lan/screens/wrapper.dart';
import 'package:fil_lan/service/seat_service.dart';
import 'package:fil_lan/theme/fil_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'service/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

//void main() => runApp(SwishDemoApp());
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android) {
    // Some android/ios specific code
  } else if (defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows) {
    // Some desktop specific code there
  } else {
    // Some web specific code there
  }
  // set the publishable key for Stripe

  runApp(const MyApp());
  //FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<SeatService>(
          create: (_) => SeatService(),
        ),
        BlocProvider<TableBloc>(create: (context) => TableBloc())
      ],
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          theme: FilLanTheme.filLanTheme,
          title: "APP",
          initialRoute: '/',
          routes: {
            '/': (context) => const Wrapper(),
            '/login-screen': (context) => LoginScreen(),
            '/register-screen': (context) => RegisterScreen(),
            '/opening-screen': (context) => OpeningScreen(),
          },
        );
//Here to use rootContext is safe
//Provider.of<SomeModel>(rootContext, listen: false);
      }),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
/*
class PaymentDemo extends StatelessWidget {
  const PaymentDemo({Key? key}) : super(key: key);
  Future<void> initPayment(
      {required String email,
      required double amount,
      required BuildContext context}) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-fil-lan-f60bc.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': email,
            'amount': amount.toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());
      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['paymentIntent'],
        merchantDisplayName: 'Fil-lan anmälan',
        customerId: jsonResponse['customer'],
        customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        testEnv: true,
        merchantCountryCode: 'SG',
      ));
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment is successful'),
        ),
      );
    } catch (errorr) {
      if (errorr is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occured ${errorr.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occured $errorr'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: const Text('Pay 20\$'),
        onPressed: () async {
          await initPayment(
              amount: 50.0, context: context, email: 'email@test.com');
        },
      )),
    );
  }
}*/
