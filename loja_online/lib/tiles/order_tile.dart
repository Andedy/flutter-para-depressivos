import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          //STREAMBUILDER fica mostrando tudo em TEMPO REAL
          stream: Firestore.instance
              .collection("orders")
              .document(orderId)
              .snapshots(),

          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else {

              int status = snapshot.data["status"]; //pega meu status do pedido no firebase

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Código do Pedido: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6), 
                  Text(
                    _buildProductsText(snapshot.data)
                  ),
                  SizedBox(height: 12), 
                  Text(
                    "Status do Pedido:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12), 
                  Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle("1", "Preparação", status, 1),
                      Container(
                        //ESSA É MINHA LINHA
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle("2", "Transporte", status, 2),
                      Container(
                        //ESSA É MINHA LINHA
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle("3", "Entrega", status, 3),
                    ],
                  )
                ],
              );
            }
          },
        ),

        //documentsnapshot pega UM pedido
      ),
    );
  }
  String _buildProductsText (DocumentSnapshot snapshot){
    String text = "Descrição: \n";
    for(LinkedHashMap p in snapshot.data["products"]){
    text += "${p["quantity"]} x ${p["product"]["title"]} (R\$ ${p["product"]["price"].toStringAsFixed(2)})\n";
    }
    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";

    return text;
  }

  Widget _buildCircle(String title, String subtitle, int status, int thisStatus){
    Color backColor;
    Widget child;

    if(status < thisStatus){ //uma bolinha 
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white));
    } else if(status == thisStatus){ //duas bolinhas
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )

        ],
      );
    } else { //tres bolinhas ok
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle),
      ],
    );

  }


}
