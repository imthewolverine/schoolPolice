import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_police/screens/signup_screen/signup_bloc.dart';
import 'package:school_police/screens/signup_screen/signup_event.dart';
import 'package:school_police/screens/signup_screen/signup_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Бүртгүүлэх'),
        ),
        body: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Signup Successful!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            }
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/images/logo.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),

                    // Email or Phone Field
                    TextField(
                      onChanged: (value) => context
                          .read<SignupBloc>()
                          .add(SignupEmailChanged(value)),
                      decoration: const InputDecoration(
                        labelText: 'Имэйл эсвэл утас',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Username Field
                    TextField(
                      onChanged: (value) => context
                          .read<SignupBloc>()
                          .add(SignupUsernameChanged(value)),
                      decoration: const InputDecoration(
                        labelText: 'Нэвтрэх нэр',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password Field with Visibility Toggle
                    BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        return TextField(
                          obscureText: state.password.isEmpty,
                          onChanged: (value) => context
                              .read<SignupBloc>()
                              .add(SignupPasswordChanged(value)),
                          decoration: InputDecoration(
                            labelText: 'Нууц үг',
                            labelStyle: const TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Toggle password visibility
                                // Handle visibility toggle here if needed
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

                    // Confirm Password Field with Visibility Toggle
                    BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        return TextField(
                          obscureText: state.confirmPassword.isEmpty,
                          onChanged: (value) => context
                              .read<SignupBloc>()
                              .add(SignupPasswordAgainChanged(value)),
                          decoration: InputDecoration(
                            labelText: 'Нууц үг давтах',
                            labelStyle: const TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Toggle password visibility
                                // Handle visibility toggle here if needed
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

                    // Checkbox for agreement
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {
                            // Handle agreement checkbox
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Би School police application ашиглах шаардлагатай танилцсан',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                        ),
                        onPressed: () {
                          context.read<SignupBloc>().add(SignupSubmitted());
                        },
                        child: state.isSubmitting
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text('Бүртгүүлэх',
                                style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Social Buttons
                    const Text(
                      'эсвэл',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Handle Facebook sign-up
                          },
                          icon: const Icon(Icons.facebook, color: Colors.blue),
                          label: const Text('Facebook'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Handle Google sign-up
                          },
                          icon:
                              const Icon(Icons.g_mobiledata, color: Colors.red),
                          label: const Text('Google'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Existing Account Link
                    GestureDetector(
                      onTap: () {
                        // Handle navigate to login screen
                      },
                      child: const Text(
                        'Бүртгэлтэй юу? Нэвтрэх',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
