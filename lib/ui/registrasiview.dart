import 'package:flutter/material.dart';
import 'package:tokoumb/bloc/registrasi_bloc.dart';
import 'package:tokoumb/widget/success_dialog.dart';
import 'package:tokoumb/widget/warning_dialog.dart';

class RegistrasiView extends StatefulWidget {
  const RegistrasiView({Key? key}) : super(key: key);

  @override
  _RegistrasiViewState createState() => _RegistrasiViewState();
}

class _RegistrasiViewState extends State<RegistrasiView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextbboxControoller = TextEditingController();
  final _emailTextbboxControoller = TextEditingController();
  final _passwordTextbboxControoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrasi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextField(
                    labelText: "Nama",
                    keyboardType: TextInputType.text,
                    isSecure: false,
                    controller: _namaTextbboxControoller,
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'Nama harus diisi dan minimal 3 karakter';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    labelText: "Email",
                    keyboardType: TextInputType.text,
                    isSecure: false,
                    controller: _emailTextbboxControoller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email harus diisi';
                      }

                      RegExp emailRegex = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

                      if (!emailRegex.hasMatch(value)) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    labelText: "Password",
                    keyboardType: TextInputType.text,
                    controller: _passwordTextbboxControoller,
                    isSecure: true,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Password harus diisi dan minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    labelText: "Konfirmasi Password",
                    keyboardType: TextInputType.text,
                    isSecure: true,
                    validator: (value) {
                      if (value != _passwordTextbboxControoller.text) {
                        return 'Konfirmasi Password Tidak Sama';
                      }
                      return null;
                    },
                  ),
                  _buildRegistrasiButton(),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String labelText,
      required TextInputType keyboardType,
      TextEditingController? controller,
      FormFieldValidator<String>? validator,
      required bool isSecure}) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: isSecure,
    );
  }

  Widget _buildRegistrasiButton() {
    return ElevatedButton(
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            _submit();
          }
        }
      },
      child: const Text("Registrasi"),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    print({
      "nama": _namaTextbboxControoller.text,
      "email": _emailTextbboxControoller.text,
      "password": _passwordTextbboxControoller.text
    });

    RegistrasiBloc.registrasi(
            nama: _namaTextbboxControoller.text,
            email: _emailTextbboxControoller.text,
            password: _passwordTextbboxControoller.text)
        .then(
            (value) => {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => SuccessDialog(
                            description: "Registrasi Berhasil",
                            okClick: () {
                              Navigator.pop(context);
                            },
                          ))
                }, onError: (error) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Registrasi Gagal",
              ));
    });

    setState(() {
      _isLoading = false;
    });
  }
}
