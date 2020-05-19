import 'package:flutter/material.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar conta",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          ///scopped adicionado para poder "atualizar todo o app quando um usuario estiver logado, por exemplo"
          builder: (context, child, model) {
            //adicionado junto com scopped - criamos uma forma de acessar o nosso model
            if (model.isLoading)
              return Center(child: CircularProgressIndicator());

            return Form(
              key: _formKey, //faz meu validator funcionar
              child: ListView(
                padding: EdgeInsets.all(36.0),
                children: <Widget>[
                  Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor),
                  ),
                  // SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Insira seu email",
                      hintStyle: TextStyle(
                          //fontWeight: FontWeight.bold
                          ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail inválido!";
                    },
                  ),

                  SizedBox(
                    height: 16.0,
                  ),

                  Text(
                    "Senha",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor),
                  ),
                  TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(
                        hintText: "Insira sua senha",
                        hintStyle: TextStyle(
                            //fontWeight: FontWeight.bold
                            ),
                      ),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6)
                          return "Senha inválida!";
                      }),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty)
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content:
                                Text("Insira e-mail para recuperar senha."),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        else {
                          model.recoverPass(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Confira seu e-mail!"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: Text(
                        "Esqueceu a senha?",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      padding: EdgeInsets
                          .zero, //faz meu botão ficar bem colado a direita (máximo do scaffold)
                    ),
                  ),
                  SizedBox(height: 8.0),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      //side: BorderSide(color: Colors.red),
                    ),
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}

                      model.signIn(
                          email: _emailController.text,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail);
                    },
                  )
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
