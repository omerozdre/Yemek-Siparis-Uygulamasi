import 'package:bitirme_calismasi/data/entity/yemekler.dart';

class YemeklerCevap{
  List<Yemekler> yemekler;
  int success;

  YemeklerCevap({required this.yemekler, required this.success});

  factory YemeklerCevap.fromJson(Map<String,dynamic>json){
    var JsonArray = json["yemekler"] as List;
    var success = json["success"] as int;

    var yemekler = JsonArray.map((yemeklerJsonArrayNesnesi) => Yemekler.fromJson(yemeklerJsonArrayNesnesi)).toList();

    return YemeklerCevap(yemekler: yemekler, success: success);
  }
}