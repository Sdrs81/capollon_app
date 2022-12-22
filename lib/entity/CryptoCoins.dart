class CryptoCoins{

  String id;
  String rank;
  String symbol;
  String name;
  String supply;
  String volumeUsd24Hr;
  String priceUsd;
  String changePercent24Hr;

  CryptoCoins(this.id, this.rank, this.symbol, this.name, this.supply,
      this.volumeUsd24Hr, this.priceUsd, this.changePercent24Hr);

  factory CryptoCoins.fromJson(Map<String, dynamic> json){
    return CryptoCoins(json["id"] as String, json["rank"] as String,
        json["symbol"] as String, json["name"] as String, json["supply"] as String,
        json["volumeUsd24Hr"] as String ,json["priceUsd"] as String, json["changePercent24Hr"] as String);
  }
}