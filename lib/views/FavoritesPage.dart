import 'package:capollon_app/model/CryptoCoins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stateManagement/ProviderCryptoCoinList.dart';
import '../stateManagement/ProviderForFavoriteCoins.dart';


class FavoritesPage extends StatefulWidget {

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  // Getting coin list from provider
  Future<List<CryptoCoins>> getCurrentCryptoCoinListFromProvider() async{
    return Future.value(Provider.of<ProviderCryptoCoinList>(context, listen: false).getListOfAllCoins());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: FutureBuilder<List<CryptoCoins>>(
        future: getCurrentCryptoCoinListFromProvider(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var coinList = snapshot.data;
            // Initializing Provider class to check favorite attribute for coins
            var favoriteCoinListProvider = Provider.of<ProviderForFavoriteCoins>(context);
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: coinList!.length,
              itemBuilder: (context, indeks){
                var coin = coinList[indeks];
                // Checking that coin is favorite or not to list
                if(favoriteCoinListProvider.containsCoin(coin.id)){
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: Colors.primaries[indeks % Colors.primaries.length],
                    child: SizedBox(
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("Rank# ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                                    Text(coin.rank, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    readyText(coin.name,Colors.white, FontWeight.bold, 22),
                                    Text(" (${coin.symbol})", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                                  ],
                                ),
                                favoriteCoinListProvider.containsCoin(coin.id) ?
                                Consumer<ProviderForFavoriteCoins>(
                                  builder: (context, ProviderObject, child){
                                    return IconButton(
                                      icon: Icon(Icons.favorite, color: Colors.white,),
                                      onPressed: (){
                                        ProviderObject.remove(coin.id);
                                      },
                                    );
                                  },
                                ):
                                Consumer<ProviderForFavoriteCoins>(
                                  builder: (context, ProviderObject, child){
                                    return IconButton(
                                      icon: Icon(Icons.favorite_border, color: Colors.white,),
                                      onPressed: (){
                                        ProviderObject.add(coin.id);
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              color: Colors.white,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text("Current Price: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                                    Text("${coin.priceUsd} \$", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text("Change(24Hr): ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                                    Text("${coin.changePercent24Hr}%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }else{
                  // Adding invisible widget to list just favorite coins
                  return Container(
                    width: 0,
                    height: 0,
                  );
                }
              },
            );
          }else{
            return const Center();
          }
        },
      ),
    );
  }
}

// Ready to go widgets for more clear code

// Ready Text
class readyText extends StatelessWidget{

  late final String text;
  late final Color color;
  late final FontWeight fontWeight;
  late final double fontSize;

  readyText(this.text, this.color, this.fontWeight, this.fontSize);

  @override
  Widget build(BuildContext context){
    return Text(text, style: TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize));
  }
}
