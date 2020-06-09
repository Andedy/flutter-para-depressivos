import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        //ESSA AQUI QUE EXPANDE QUANDO CLICA NO BOTÃO A
        title: Text(
          "Calcular Frete",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: Icon(Icons.location_on, color: Colors.grey[700]),
        // trailing: Icon(Icons.add, color: Colors.grey[700]),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu CEP",
              ),
              initialValue: "",
              onFieldSubmitted: (text) {
              },
            ),
          )
        ],
      ),
    );
  }
}