
import 'package:bitirme_calismasi/data/entity/yemekler.dart';
import 'package:bitirme_calismasi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_calismasi/ui/views/detay_sayfa.dart';
import 'package:bitirme_calismasi/ui/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "HOŞGELDİNİZ",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.fastfood_sharp,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              "Aklınızda kalmasın, midenizde kalsın.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.teal,
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ara...',
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (aramaSonucu) {
                      context.read<AnasayfaCubit>().ara(aramaSonucu);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 45,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(sepetYemekler: [],)),)
                        .then((value){
                          context.read<AnasayfaCubit>().yemekleriYukle;
                        });
                  },
                )
              ],
            ),
          ),
          Expanded( // Expanded widget ekleniyor
            child: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
              builder: (context, yemeklerListesi) {
                if (yemeklerListesi.isNotEmpty) {
                  return GridView.builder(
                    itemCount: yemeklerListesi.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:  1 / 1,
                    ),
                    itemBuilder: (context, indeks) {
                      var yemek = yemeklerListesi[indeks];
                      return Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text("${yemek.yemek_adi}", style: TextStyle(fontSize: 20,color: Colors.teal),),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                                  child: Container(
                                    height: 150,width:100,
                                      child: Image.network(
                                          "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(Icons.access_time,color: Colors.blueGrey,),
                                        Column(
                                          children: [
                                            Text("Hızlı", style: TextStyle(fontSize: 14,color: Colors.blueGrey,fontWeight: FontWeight.bold)),
                                            Text("Teslimat", style: TextStyle(fontSize: 14,color: Colors.blueGrey,fontWeight: FontWeight.bold)),
                                          ],
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Text("${yemek.yemek_fiyat} ₺", style: TextStyle(fontSize: 25,color: Colors.blueGrey)),
                                    ),
                                    SizedBox(height: 20,),
                                    SizedBox(width:85,height:30,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: ElevatedButton(onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek)))
                                          .then((value){
                                            context.read<AnasayfaCubit>().yemekleriYukle;
                                          });
                                          print("${yemek.yemek_adi} sepete eklendi");
                                        }, style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal, // Buton arka plan rengi
                                        ), child: Text("Detay",style: TextStyle(fontSize: 11,color: Colors.white),)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
