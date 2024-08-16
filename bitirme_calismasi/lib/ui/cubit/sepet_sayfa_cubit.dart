import 'package:bitirme_calismasi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_calismasi/data/entity/yemekler.dart';
import 'package:bitirme_calismasi/data/repo/yemeklerdao_reporsitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{

  SepetSayfaCubit():super(<SepetYemekler>[]);

  var yrepo = YemeklerdaoReporsitory();

  Future<void> sepetYemeklerYukle(String kullanici_adi) async{
    var liste=await yrepo.sepetYemekleriGetir(kullanici_adi);

    if (liste.isEmpty) {
      emit([]); // Liste boş ise boş liste emit et
    } else {
      emit(liste);
    }
  }

  Future<void> sil(int sepet_yemek_id,String kullanici_adi) async {
    await yrepo.sil(sepet_yemek_id,kullanici_adi);
    await sepetYemeklerYukle(kullanici_adi);
    if (state.length == 0) { // Liste boş mu kontrol et
      emit([]); // Liste boş ise boş liste emit et
    }
  }



}