import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/data/cubits/auth/auth_cubit.dart';
import 'package:real_estate_app/data/cubits/auth/login_cubit.dart';

import '../data/helper/widgets.dart';
import '../utils/helper_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {

          if (state is LoginInProgress) {
            Center(child: CircularProgressIndicator());
          }
          if (state is LoginFailure) {
            log("ASKdmlasdm lk${state.errorMessage}");
            HelperUtils.showSnackBarMessage(context, state.errorMessage,
                type: MessageType.error);
          }
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  context.read<LoginCubit>().login(
                    email: email, password: password,
                  );
                },
                child: Text('Login'),
              ),
            ],
          ),
        )
      ),
    );
  }
}
