import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:simple_chat/mobx/authentication.dart';

// //Instancia utilizada para la autenticacion de usuarios
// final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  //final AuthenticationStore _authenticationStore = AuthenticationStore();
  final _form = GlobalKey<FormState>();

  //Variables auxiliares para el inicio de sesion y registro
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPass = '';
  var _enteredUserName = '';

  //Verificacion de la valides del formulario
  void _submit() async {
    String? result;
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    // _form.currentState!.save();
    // if (_isLogin) {
    //   //Iniciar sesion de usuario
    //   result = await _authenticationStore.login(_enteredEmail, _enteredPass);
    // } else {
    //   //Se crea un usuario si se desea
    //   result = await _authenticationStore.signin(
    //       _enteredEmail, _enteredPass, _enteredUserName);
    // }
    //En caso de errores se muestra el mensaje obtenido de la operacion
    if (result != null) {
      ScaffoldMessenger.of(context).clearSnackBars;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ?? 'Autenticación fallida'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/logo.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Username'),
                              enableSuggestions: false,
                              //Comprobaciones de campos
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Por favor, ingrese un nombre de al menos 4 caracteres';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _enteredUserName = value!;
                              },
                            ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            //Comprobaciones decampo
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Por favor, ingrese un correo válido';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Contraseña'),
                            //Oscurece el texto que se ingresa ya que es una contraseña
                            obscureText: true,
                            //Comprobaciones de campos
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPass = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              child: Text(
                                  //Cambia la funcionalidad segun se elija
                                  _isLogin ? 'Ingresar' : 'Sign up')),
                          // TextButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       _isLogin = !_isLogin;
                          //     });
                          //   },
                          //   child: Text(_isLogin
                          //       ? 'Create account'
                          //       : '¿Already have an account?'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
