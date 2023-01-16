class CryptoMarketDatas{

  String exchangeId;
  String quoteId;
  String priceUsd;


  CryptoMarketDatas(this.exchangeId, this.quoteId, this.priceUsd);

  factory CryptoMarketDatas.fromJson(Map<String, dynamic> json){
    return CryptoMarketDatas(json["exchangeId"] as String, json["quoteId"] as String, json["priceUsd"] as String);
  }

}