import 'package:e_commerce/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('✅ Login successful!')),
            );
            Navigator.pushReplacementNamed(context, Routes.homeScreen);
          } else if (state is LoginFailState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('❌ Login failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    FlutterLogo(size: 100),
                    SizedBox(height: 20),
                    Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? "Enter username" : null,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? "Enter password" : null,
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: state is LoginLoadingState
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).login(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                      child: state is LoginLoadingState
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
