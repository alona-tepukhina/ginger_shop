import 'package:flutter/material.dart';
import 'package:ginger_shop/utilities/validators.dart';
import 'package:ginger_shop/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/db_operations/user_dao.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDao = Provider.of<UserDao>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        kSizedBoxHalfHeight,

                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text('Email address'),
                            //border: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            } else if (!value.isValidEmail()) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                        ),
                        kSizedBoxHalfHeight,
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text('Password'),
                            //border: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        kSizedBoxHalfHeight,
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final errorMessage = await userDao.login(
                                  _emailController.text,
                                  _passwordController.text);

                              if (errorMessage != null) {
                                await Future.delayed(
                                    const Duration(seconds: 1));

                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(errorMessage)));

                                return;
                              } else {
                                await Future.delayed(
                                    const Duration(seconds: 1));

                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Login Successful')));
                                Navigator.pushNamed(context, '/home');
                              }
                            }
                          },
                          child: const Text('Login'),
                        ),
                        // kSizedBoxFullHeight,
                        // kDivider,
                        // kSizedBoxFullHeight,
                        // const Text(
                        //   'Don\'t have an account?',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(fontSize: 20, color: Colors.black54),
                        // ),
                        // kSizedBoxHalfHeight,
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.pushNamed(context, '/registration');
                        //   },
                        //   child: const Text(
                        //     'Sign up',
                        //     style: TextStyle(fontSize: 18),
                        //   ),
                        // ),
                        // kSizedBoxHalfHeight,
                        // kDivider,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
