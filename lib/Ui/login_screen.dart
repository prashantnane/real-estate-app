import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/data/cubits/auth/auth_cubit.dart';
import 'package:real_estate_app/data/cubits/auth/login_cubit.dart';

import '../app/routes.dart';
import '../data/helper/widgets.dart';
import '../utils/helper_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reraController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  int authScreen = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
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
            Navigator.of(context).pushReplacementNamed(AppRoutes.MAIN);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child:
                    authScreen == 0 ? buildLoginScreen() : buildRegisterScreen(),
              ),
              authScreen == 0
                  ? Row(
                      children: [
                        Text('Register'),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                authScreen = 1;
                              });
                            },
                            child: Text('Sign Up')),
                      ],
                    )
                  : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                        children: [
                          Text('Already have account? '),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  authScreen = 0;
                                });
                              },
                              child: Text('Sign In')),
                        ],
                      ),
                  )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              // Regular expression for validating an email address
              String pattern =
                  r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
              RegExp regex = RegExp(pattern);
              if (!regex.hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final email = _emailController.text;
              final password = _passwordController.text;

              context.read<LoginCubit>().login(
                    email: email,
                    password: password,
                  );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  Widget buildRegisterScreen() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                // Regular expression for validating an email address
                String pattern =
                    r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a mobile number';
                }
                if (value.length != 10) {
                  return 'Mobile number must be 10 digits';
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Mobile number must contain only digits';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _reraController,
              decoration: InputDecoration(labelText: 'RERA Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a RERA number';
                }
                // if (value.length != 10) {
                //   return 'Mobile number must be 10 digits';
                // }
                // if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                //   return 'Mobile number must contain only digits';
                // }
                return null;
              },
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a address';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value != _passwordController.text) {
                  return 'Password does not match';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                log('phone num: ${_phoneController.text} , password : ${_passwordController.text}');
                if (_formKey.currentState?.validate() ?? false) {
                  final name = _nameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final phone = _phoneController.text;
                  final rera = _reraController.text;
                  final address = _addressController.text;

                  // If the form is valid, proceed with the sign-in
                  context.read<LoginCubit>().signUp(
                      name: name,
                      email: email,
                      password: password,
                      phone: phone,
                      rera: rera,
                      address: address);
                }
              },
              child: Text('Sign Up'),
            ),
          ]),
    );
  }
}
