import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        //ESSA AQUI QUE EXPANDE QUANDO CLICA NO BOTÃO A
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: Icon(Icons.card_giftcard, color: Colors.grey[700]),
        trailing: Icon(Icons.add, color: Colors.grey[700]),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom",
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection("coupons")
                    .document(text)
                    .get()
                    .then((docSnap) {
                  if (docSnap.data != null) {
                    CartModel.of(context).setCoupon(text, docSnap.data["percent"]);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Desconto de ${docSnap.data["percent"]}% aplicado!"),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cupom não existente"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
