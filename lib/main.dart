import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_police/screens/home_screen/home_bloc.dart';
import 'package:school_police/screens/home_screen/home_event.dart';
import 'package:school_police/screens/login_screen/login_bloc.dart';
import 'package:school_police/screens/login_screen/login_screen.dart';
import 'package:school_police/services/auth_service.dart';
import 'package:school_police/themes/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Create an instance of AuthService
  final authService = AuthService();

  runApp(MyApp(
    authService: authService,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({Key? key, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LoginBloc(authService)),
        BlocProvider(create: (_) => HomeBloc()..add(LoadAds())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'School Police',
            theme: theme,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}

/*import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_police/screens/home_screen/home_bloc.dart';
import 'package:school_police/screens/home_screen/home_event.dart';
import 'package:school_police/screens/login_screen/login_bloc.dart';
import 'package:school_police/screens/login_screen/login_screen.dart';
import 'package:school_police/services/auth_service.dart';
import 'package:school_police/services/fcm_service.dart';
import 'package:school_police/themes/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // Initialize FCM service and retrieve token
  final fcmService = FCMService();
  String? token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    print("FCM Token: $token");
    // Send the FCM token to the backend
    await fcmService.sendTokenToBackend(token);
  }

  // Handle token refresh
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    print("FCM Token refreshed: $newToken");
    await fcmService.sendTokenToBackend(newToken);
  });

  final authService = AuthService();

  runApp(MyApp(
    authService: authService,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({Key? key, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LoginBloc(authService)),
        BlocProvider(create: (_) => HomeBloc()..add(LoadAds())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'School Police',
            theme: theme,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}*/
