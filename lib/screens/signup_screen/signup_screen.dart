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
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
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
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) => context
                        .read<SignupBloc>()
                        .add(SignupUsernameChanged(value)),
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    onChanged: (value) => context
                        .read<SignupBloc>()
                        .add(SignupFirstNameChanged(value)),
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    onChanged: (value) => context
                        .read<SignupBloc>()
                        .add(SignupLastNameChanged(value)),
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  TextField(
                    onChanged: (value) => context
                        .read<SignupBloc>()
                        .add(SignupEmailChanged(value)),
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      final int? phoneNumber = int.tryParse(value);
                      if (phoneNumber != null) {
                        context
                            .read<SignupBloc>()
                            .add(SignupPhoneNumberChanged(phoneNumber));
                      }
                    },
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) => context
                        .read<SignupBloc>()
                        .add(SignupPasswordChanged(value)),
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) => context
                        .read<SignupBloc>()
                        .add(SignupPasswordAgainChanged(value)),
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SignupBloc>().add(SignupSubmitted());
                    },
                    child: state.isSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Signup'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
