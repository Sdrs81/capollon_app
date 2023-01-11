import 'package:capollon_app/model/CryptoCoins.dart';
import 'package:flutter/material.dart';

class CoinDetailsPage extends StatefulWidget {

  CryptoCoins coin;
  CoinDetailsPage({required this.coin});

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin Details: ${widget.coin.name}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You are in details page")
          ],
        ),
      ),
    );
  }
}
