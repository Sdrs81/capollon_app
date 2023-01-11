import 'package:capollon_app/model/CryptoCoins.dart';
import 'package:flutter/material.dart';

class CoinDetailsPage extends StatefulWidget {

  CryptoCoins coin;
  int index;

  CoinDetailsPage({required this.coin,required this.index});

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin Details: ${widget.coin.name}", style: TextStyle(color: Colors.primaries[widget.index % Colors.primaries.length]),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(

            ),
          ],
        ),
      ),
    );
  }
}
