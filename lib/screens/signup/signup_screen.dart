import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/repositories/auth/auth_repository.dart';
import 'package:social_media/widgets/widgets.dart';

import 'cubit/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = "/signup";

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignupCubit>(
        create: (_) =>
            SignupCubit(authRepository: context.read<AuthRepository>()),
        child: SignupScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status == SignupStatus.error) {
              showDialog(context: context, 
                builder: (context) => ErrorDialog(
                  content: state.failure.message
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Socialite",
                              style: TextStyle(
                                  fontSize: 28.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Username",
                              ),
                              onChanged: (value) => context.read<SignupCubit>().usernameChanged(value),
                              validator: (value) => value.trim().isEmpty
                                  ? "Please enter a valid username!"
                                  : null,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Email",
                              ),
                              onChanged: (value) => context.read<SignupCubit>().emailChanged(value),
                              validator: (value) => !value.contains("@")
                                  ? "Please enter a valid email address!"
                                  : null,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Password",
                              ),
                              obscureText: true,
                              onChanged: (value) => context.read<SignupCubit>().passwordChanged(value),
                              validator: (value) => value.length < 6
                                  ? "Password must be at least 6 characters long!"
                                  : null,
                            ),
                            const SizedBox(
                              height: 28.0,
                            ),
                            ElevatedButton(
                              onPressed: () => _submitForm(
                                context, 
                                state.status == SignupStatus.submitting
                              ),
                              child: const Text("Sign Up"),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            ElevatedButton(
                              //elevation: 1.0,
                              //color: Colors.grey[200],
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[200],
                              ),
                              onPressed: () =>
                                  Navigator.of(context).pop(),
                              child: const Text(
                                "Have an account? Log In",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<SignupCubit>().signUpWithCredentials();
    }
  }
}
