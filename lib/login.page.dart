/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:project01_combustivel/widgets/text-form.widget.dart';
import 'package:project01_combustivel/widgets/logo.widget.dart';
import 'package:project01_combustivel/widgets/email-form.widget.dart';

import 'menu.page.dart';
import 'reset-password.page.dart';
import 'signup.page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var db = FirebaseFirestore.instance;

  var formKey = GlobalKey<FormState>();
  var controllerEmail = new TextEditingController();
  var controllerSenha = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 40, right: 40),
        color: Theme.of(context).primaryColor,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LogoWidget(),
              EmailFormWidget(
                controller: controllerEmail,
              ),
              TextFormWidget(
                text: "Senha",
                focus: false,
                controller: controllerSenha,
              ),
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text(
                    "Esqueci a Senha",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 22,
                      fontFamily: "Big Shoulders Display",
                    ),
                  ),
                  onPressed: () {
                    controllerEmail.clear();
                    controllerEmail.clear();
                    controllerSenha.clear();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPasswordPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                height: 60,
                width: double.infinity,
                child: SizedBox.expand(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        borderRadius: BorderRadius.circular(60)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontFamily: "Big Shoulders Display",
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: SizedBox(
                            child: Icon(
                              Icons.lock_open,
                              color: Colors.deepPurple.withOpacity(0.8),
                            ),
                            height: 28,
                            width: 28,
                          ),
                        )
                      ],
                    ),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        QuerySnapshot usr = await db
                            .collection("usuarios")
                            .where('email', isEqualTo: controllerEmail.text)
                            .where('senha', isEqualTo: controllerSenha.text)
                            .get();

                        if (usr.docs.isEmpty) {
                          showErrorFlushbar(context);
                          controllerEmail.clear();
                          controllerSenha.clear();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuPage(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              Container(
                height: 40,
                child: FlatButton(
                  child: Text(
                    "Cadastre-se",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: "Big Shoulders Display",
                    ),
                  ),
                  onPressed: () {
                    controllerEmail.clear();
                    controllerEmail.clear();
                    controllerSenha.clear();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showErrorFlushbar(BuildContext context) {
    Flushbar(
      title: 'Não Encontrado',
      message: 'Usuário não encontrado',
      icon: Icon(
        Icons.account_circle,
        size: 28,
        color: Colors.redAccent,
      ),
      leftBarIndicatorColor: Colors.red.shade300,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}*/
