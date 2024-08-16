import 'dart:convert';

import 'package:bitirme_calismasi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_calismasi/data/entity/sepet_yemekler_cevap.dart';
import 'package:bitirme_calismasi/data/entity/yemekler.dart';
import 'package:bitirme_calismasi/data/entity/yemekler_cevap.dart';
import 'package:dio/dio.dart';

class YemeklerdaoReporsitory {


  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  List<SepetYemekler> parseSepetYemekler(String cevap){
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async {
   var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
   var cevap = await Dio().get(url);
   return parseYemekler(cevap.data.toString());
  }

  Future<void> siparisKaydet(String yemek_adi, String yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {

    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi":yemek_adi,
      "yemek_resim_adi":yemek_resim_adi,
      "yemek_fiyat":yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,
      "kullanici_adi":kullanici_adi};

    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Yemek Kaydet : ${cevap.data.toString()}");
  }

  Future<List<Yemekler>> ara(String aramaKelimesi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    var yemekListe = parseYemekler(cevap.data.toString());
    // Küçük harf - büyük harf duyarlılığını kaldırmak için hem arama kelimesini hem de yemek adını küçük harfe çeviriyoruz
    Iterable<Yemekler> filtreleme = yemekListe.where(
            (yemekNesnesi) => yemekNesnesi.yemek_adi.toLowerCase().contains(aramaKelimesi.toLowerCase()));
    var liste2 = filtreleme.toList();
    return liste2;
  }

  Future<void> sil(int sepet_yemek_id,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id":sepet_yemek_id ,"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    return print("Yemek Sil : ${cevap.data.toString()}");
  }


  Future<List<SepetYemekler>> sepetYemekleriGetir(String kullanici_adi) async{//burası yanlış

    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    if (cevap.data.toString() == "") {
      return []; // Boş bir liste döndür
    } else {
      try {
        return parseSepetYemekler(cevap.data.toString());
      } catch (e) {
        return []; // Hata oluşursa boş bir liste döndür
      }
    }
  }
}