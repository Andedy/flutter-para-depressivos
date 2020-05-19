import 'package:flutter/material.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Form(
            key: _formKey, //faz meu validator funcionar
            child: ListView(
              padding: EdgeInsets.all(36.0),
              children: <Widget>[
                Text(
                  "Nome Completo",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Insira seu nome completo",
                    hintStyle: TextStyle(
                        //fontWeight: FontWeight.bold
                        ),
                  ),
                  validator: (text) {
                    if (text.isEmpty) return "Nome inválido!";
                  },
                ),

                SizedBox(height: 16.0),

                Text(
                  "Endereço",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: "Insira seu Endereço",
                    hintStyle: TextStyle(
                        //fontWeight: FontWeight.bold
                        ),
                  ),
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido!";
                  },
                ),

                SizedBox(height: 16.0),

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
                    onPressed: () {},
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
                    "Criar Conta",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        "name": _nameController
                            .text, //ADICIONE .TEXT NO FIM DESSE INFERNO
                        "address": _addressController.text,
                        "email": _emailController.text,
                        //não armazenar a senha junto das infos do user por segurança
                      };

                      model.signUp(
                        userData: userData,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail,
                      );
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
