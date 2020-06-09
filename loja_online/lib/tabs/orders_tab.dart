import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/login_screen.dart';
import 'package:loja_online/tiles/order_tile.dart';


class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(UserModel.of(context).isLoggedIn()){
      // return Container();
      String uid = UserModel.of(context).firebaseUser.uid;

      //querysnapshot = obtem TODOS os docs de uma collection
      //documentsnapshot = obtem apena UM doc da collection
      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("users").document(uid)
          .collection("orders").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else {
            return ListView(
              //pegando cada um dos la do firebase e transfdormando em um OrderTile depois transformando em uma lista
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList().reversed.toList(),
            );
            
          }
        },
      );

    } else {
      return Container(
              padding: EdgeInsets.all(34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.view_carousel,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Faça o Login para comprar!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              ),
            );
    }


  }
}