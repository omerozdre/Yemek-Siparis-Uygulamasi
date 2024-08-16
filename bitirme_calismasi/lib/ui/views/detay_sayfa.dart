import 'package:bitirme_calismasi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_calismasi/data/entity/yemekler.dart';
import 'package:bitirme_calismasi/ui/cubit/detay_sayfa_cubit.dart';
import 'package:bitirme_calismasi/ui/views/sepet_sayfa.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfa extends StatefulWidget {

  Yemekler yemek;
  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int yemek_siparis_adet = 0;



  @override
  Widget build(BuildContext context) {
    int toplamUcret = yemek_siparis_adet * int.parse(widget.yemek.yemek_fiyat);

    return Scaffold(
      appBar: AppBar(title: const Text("Ürün Detayı",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(width: 400,height: 550,
          child: Card(
            color: Colors.teal,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${widget.yemek.yemek_adi}", style: const TextStyle(fontSize: 40,color: Colors.white),),
                Image.network(
                    "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),

                Text("${widget.yemek.yemek_fiyat} ₺", style: const TextStyle(fontSize: 40,color: Colors.white)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove,color: Colors.white,),
                      onPressed: () {
                        setState(() {
                          if (yemek_siparis_adet > 0)
                            yemek_siparis_adet--; // Miktarı azalt
                        },);
                      },
                    ),
                    Text(
                      '$yemek_siparis_adet',
                      style: const TextStyle(fontSize: 25),
                    ),
                    IconButton(
                      icon: Icon(Icons.add,color: Colors.white,),
                      onPressed: () {
                        setState(() {
                          yemek_siparis_adet++;//miktari artır
                        }
                          );
                      },
                    ),
                  ],
                ),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.money_off,color: Colors.white,),
                      Text("Ücretsiz Telimat",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                  ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time,color: Colors.white,),
                      Text("Hızlı Teslimat",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star,color: Colors.white,),
                      Text("En sevilen",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${toplamUcret.toStringAsFixed(2)} ₺", // Fiyatı 2 ondalık basamakla göster
                        style: const TextStyle(fontSize: 30, color: Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(onPressed: () {
                        /*if (yemek_siparis_adet > 0) {
                          var sepetYemek = SepetYemekler(
                            sepet_yemek_id: widget.yemek.yemek_id,
                            yemek_adi: widget.yemek.yemek_ad,
                            yemek_resim_adi: widget.yemek.yemek_resim_ad,
                            yemek_fiyat: yemek_siparis_adet * widget.yemek.yemek_fiyat,
                            yemek_siparis_adet: yemek_siparis_adet,
                            kullanici_adi: "Ömer",
                          );
/*
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SepetSayfa(sepetYemekler: [sepetYemek],
                              ),
                            ),
                          );*/
                          
                         // print("${sepetYemek.yemek_adi} - ${sepetYemek.yemek_siparis_adet} adet - ${sepetYemek.yemek_fiyat} ₺ sepete eklendi");
                        }*/
                        context.read<DetaySayfaCubit>().siparisKaydet(
                            widget.yemek.yemek_adi,
                            widget.yemek.yemek_resim_adi,
                            yemek_siparis_adet * int.parse(widget.yemek.yemek_fiyat),
                            yemek_siparis_adet, "Ömer");
                        //siparisKaydet(widget.yemek.yemek_ad, widget.yemek.yemek_resim_ad, yemek_siparis_adet * widget.yemek.yemek_fiyat, yemek_siparis_adet, "Ömer");
                      }, child: const Text("Sepete Ekle",style: TextStyle(color: Colors.teal),),),
                    ),
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

