import 'package:bus_reservation/models/app_user.dart';
import 'package:bus_reservation/providers/app_data_provider.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Login"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  textAlign: TextAlign.center,
                  "Admin Login",
                  style: TextStyle(fontSize: 28),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      labelText: "Username"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field must not be empty";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      filled: true,
                      labelText: "Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: isObscure
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off))),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: _login, child: const Text("Login")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final userName = _nameController.text;
      final password = _passwordController.text;
      final response =
          await Provider.of<AppDataProvider>(context, listen: false)
              .login(AppUser(userName: userName, password: password));
      if (response != null) {
        showMsg(context, response.message);
        Navigator.pop(context);
      } else {
        showMsg(context, "Login Failed");
      }
    }
  }
}
