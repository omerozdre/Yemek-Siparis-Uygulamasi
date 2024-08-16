import 'package:bitirme_calismasi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_calismasi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SepetSayfa extends StatefulWidget {
  List<SepetYemekler> sepetYemekler;

  SepetSayfa({required this.sepetYemekler});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemeklerYukle("Ömer");
    kurulum();
  }

  double toplamFiyatHesapla(List<SepetYemekler> sepetlerListesi) {
    double toplamFiyat = 0;
    for (var sepet in sepetlerListesi) {
      toplamFiyat += int.parse(sepet.yemek_fiyat) ;
    }
    return toplamFiyat;
  }

  var flp = FlutterLocalNotificationsPlugin();

  Future<void> kurulum() async {
    var androidAyari = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosAyari = const DarwinInitializationSettings();
    var kurulumAyari = InitializationSettings (android: androidAyari, iOS: iosAyari);
    await flp.initialize(kurulumAyari, onDidReceiveNotificationResponse: bildirimSecilme);
  }
  Future<void> bildirimSecilme (NotificationResponse notificationResponse) async {
  var payload = notificationResponse.payload;
  if(payload != null){
  print("Bildirim seçildi : $payload");
  }
  }

  Future<void> bildirimGoster() async {
  var androidBildirimDetay = const AndroidNotificationDetails(
         "id",
         "name",
         channelDescription: "channelDescription",
         priority: Priority.high,
         importance: Importance.max);
         var iosBildirimDetay = const DarwinNotificationDetails();
         var bildirimDetay = NotificationDetails (android: androidBildirimDetay, iOS: iosBildirimDetay);
         await flp.show(0, "Yemek", "Siparişiniz Yola Çıktı", bildirimDetay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepet Sayfa", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
        builder: (context, sepetlerListesi) {
          if (sepetlerListesi.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sepetlerListesi.length,
                    itemBuilder: (context, indeks) {
                      var sepet = sepetlerListesi[indeks];
                      return GestureDetector(
                        onTap: () {
                          print("${sepet.yemek_adi} seçildi");
                        },
                        child: Card(
                          color: Colors.teal,
                          child: SizedBox(
                            height: 110,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                      "http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}"),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${sepet.yemek_adi}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Sipariş Adedi: ${sepet.yemek_siparis_adet}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Toplam tutar: ${sepet.yemek_fiyat} ₺",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "${sepet.yemek_adi} - silinsin mi?"),
                                          action: SnackBarAction(
                                            label: "EVET",
                                            onPressed: () {
                                              context.read<SepetSayfaCubit>().sil(int.parse(sepet.sepet_yemek_id),sepet.kullanici_adi);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("Sil", style: TextStyle(
                                        color: Colors.teal)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.teal,
                  child: Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Toplam Fiyat:", style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10,),
                      Text("${toplamFiyatHesapla(sepetlerListesi)} ₺", style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: Text("Sipariş Onayı",style: TextStyle(color: Colors.white)),
                                content: Text("Siparişinizi onaylamak istiyor musunuz?",style: TextStyle(color: Colors.white),),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // İlk dialog'u kapat
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.teal,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            title: Text("Sipariş Onayı",style: TextStyle(color: Colors.white),),
                                            content: Text("Siparişiniz onaylanmıştır",style: TextStyle(color: Colors.white),),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Sepeti boşalt
                                                  context.read<SepetSayfaCubit>().emit([]); // Sepeti boş hale getir
                                                  Navigator.of(context).pop(); // İkinci dialog'u kapat
                                                  bildirimGoster();
                                                },
                                                child: Text("Tamam",style: TextStyle(color: Colors.teal),),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text("Evet",style: TextStyle(color: Colors.teal),),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Dialog'u kapat, kullanıcı sepet sayfasında kalır
                                    },
                                    child: Text("Hayır",style: TextStyle(color: Colors.teal),),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "Onayla",
                          style: TextStyle(color: Colors.teal),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
