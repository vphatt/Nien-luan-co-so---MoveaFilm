import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http_exception.dart';
import '../shared/dialog_utils.dart';

import 'auth_manager.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await context.read<AuthManager>().login(
              _authData['email']!,
              _authData['password']!,
            );
      } else {
        // Sign user up
        await context.read<AuthManager>().signup(
              _authData['email']!,
              _authData['password']!,
            );
      }
    } catch (error) {
      showErrorDialog(context,
          (error is HttpException) ? error.toString() : 'Xác thực thất bại!');
    }

    _isSubmitting.value = false;
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildBanner(),
                _buildEmailField(),
                _buildPasswordField(),
                if (_authMode == AuthMode.signup) _buildPasswordConfirmField(),
                const SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isSubmitting,
                  builder: (context, isSubmitting, child) {
                    if (isSubmitting) {
                      return const CircularProgressIndicator();
                    }
                    return _buildSubmitButton();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  child: Text(
                    'HOẶC',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildAuthModeSwitchButton(),
              ],
            ),
          ),
        ));
  }

  Widget _buildAuthModeSwitchButton() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.7,
      height: height * 0.05,
      decoration: BoxDecoration(
        color: const Color.fromARGB(153, 58, 192, 38),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: _switchAuthMode,
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          '${_authMode == AuthMode.login ? 'ĐĂNG KÝ' : 'ĐĂNG NHẬP'} ',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.7,
      height: height * 0.05,
      child: ElevatedButton(
        onPressed: _submit,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          primary: const Color.fromARGB(197, 219, 103, 103),
          textStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        child: Text(_authMode == AuthMode.login ? 'ĐĂNG NHẬP' : 'ĐĂNG KÝ'),
      ),
    );
  }

  Widget _buildPasswordConfirmField() {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.15,
      child: Column(
        children: [
          const Text(
            'Xác nhận mật khẩu:',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 217, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          TextFormField(
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            decoration: InputDecoration(
                errorStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 251, 144), width: 2)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 251, 144), width: 2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 25, 25), width: 2))),
            enabled: _authMode == AuthMode.signup,
            obscureText: true,
            validator: _authMode == AuthMode.signup
                ? (value) {
                    if (value != _passwordController.text) {
                      return 'Mật khẩu xác nhận không khớp!';
                    }
                    return null;
                  }
                : null,
          )
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
        height: height * 0.15,
        child: Column(
          children: [
            const Text(
              'Mật khẩu:',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 217, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            TextFormField(
              obscureText: true,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 251, 144), width: 2)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 251, 144), width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 25, 25), width: 2))),
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.length < 5) {
                  return 'Mật khẩu quá ngắn!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['password'] = value!;
              },
            )
          ],
        ));
  }

  Widget _buildEmailField() {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
        height: height * 0.15,
        child: Column(
          children: [
            const Text(
              'E-Mail:',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 217, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            TextFormField(
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 251, 144), width: 2)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 251, 144), width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 25, 25), width: 2))),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'E-Mail không hợp lệ!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value!;
              },
            )
          ],
        ));
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: const [
          Text(
            'MoveaFilm',
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 60,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Xin chào!',
            style: TextStyle(
                color: Color.fromARGB(255, 246, 246, 246),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
