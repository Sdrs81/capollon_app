import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.info,size: 100,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Capollon",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Container(height: 25,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text("This app has been developed to track Crypto Coins. App is simple to understand."
                      " You can observe all known coins from Homepage, add them to favorite with button on the top right."
                      " You can track your favorite coins from Favorites Page. Also you can click on the coin and see details about that coin."
                      " Datas is refreshed when you restart the app. So, you are ready to go!",textAlign: TextAlign.center,),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
