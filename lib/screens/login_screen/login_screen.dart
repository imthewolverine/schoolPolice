import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_police/screens/login_screen/login_bloc.dart';
import 'package:school_police/screens/signup_screen/signup_screen.dart';
import '../home_screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // Get the theme data from context
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: double.infinity, // Set width to full
                fit: BoxFit.contain, // Ensure the logo fits within the bounds
              ),
              const SizedBox(height: 96),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Имэйл эсвэл нэвтрэх нэр',
                  fillColor: null,
                  filled: false,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  // Determine the current state of `obscurePassword`
                  bool obscurePassword = true;
                  if (state is ObscurePasswordState) {
                    obscurePassword = state.obscurePassword;
                  }

                  return TextField(
                    controller: passwordController,
                    obscureText: obscurePassword, // Use the state value
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Нууц үг',
                      labelStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Dispatch the toggle event to the bloc
                          loginBloc.add(
                            TogglePasswordVisibility(
                                obscurePassword: obscurePassword),
                          );
                        },
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            loginBloc.add(Check(
                              username: emailController.text,
                              password: passwordController.text,
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Нэвтрэх'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'эсвэл',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add Facebook login logic
                            },
                            icon:
                                const Icon(Icons.facebook, color: Colors.blue),
                            label: const Text('Facebook'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add Google login logic
                            },
                            icon: const Icon(Icons.g_mobiledata,
                                color: Colors.red),
                            label: const Text('Google'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Forgot Password screen
                        },
                        child: const Text(
                          'Нууц үг мартсан?',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                          );
                        },
                        child: const Text(
                          'Бүртгэлгүй юу? Шинээр бүртгүүлэх',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
