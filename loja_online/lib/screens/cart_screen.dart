import 'package:flutter/material.dart';
import 'package:loja_online/models/cart_model.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/order_screen.dart';
import 'package:loja_online/tiles/cart_tile.dart';
import 'package:loja_online/widgets/cart_price.dart';
import 'package:loja_online/widgets/discount_card.dart';
import 'package:loja_online/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
              int p = model.products.length;
              return Text(
                "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                //mostra numero de itens no cart e se P>1 = ITENS
                style: TextStyle(fontSize: 16),
              );
            }),
          ),
        ],
      ),


      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Faça o Login para adicionar itens ao carrinho! :-)",
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
          } else if (model.products == null || model.products.length == 0) {
            return Center(
              child: Text(
                "Nenhum produto no carrinho!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map(
                    (product){
                      return CartTile(product);
                    }
                  ).toList(),
                ),
                DiscountCard(),
                ShipCard(),
                CartPrice(() async{
                  String orderId = await model.finishOder();
                  if(orderId != null) 
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                    );
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
