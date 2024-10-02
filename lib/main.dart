import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_police/screens/home_screen/home_bloc.dart';
import 'package:school_police/screens/home_screen/home_event.dart';
import 'package:school_police/screens/login_screen/login_bloc.dart';
import 'package:school_police/screens/login_screen/login_screen.dart';
import 'package:school_police/services/auth_service.dart';
import 'package:school_police/themes/theme_cubit.dart';

void main() {
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
            title: 'Flutter Theme Toggle',
            theme: theme,
            home: LoginScreen(
              title: 'Login',
            ),
          );
        },
      ),
    );
  }
}
