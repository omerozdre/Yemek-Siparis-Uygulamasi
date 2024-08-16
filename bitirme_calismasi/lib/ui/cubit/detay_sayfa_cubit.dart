import 'package:bitirme_calismasi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_calismasi/data/repo/yemeklerdao_reporsitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit() :super(0);

  var yrepo = YemeklerdaoReporsitory();


  Future<void> siparisKaydet(String yemek_adi, String  yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet,String kullanici_adi) async{
    await yrepo.siparisKaydet(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }

}