import 'package:bitirme_calismasi/data/entity/yemekler.dart';
import 'package:bitirme_calismasi/data/repo/yemeklerdao_reporsitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{
  AnasayfaCubit():super(<Yemekler>[]);

  var yrepo = YemeklerdaoReporsitory();


  Future<void> yemekleriYukle() async {
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {
    if (aramaKelimesi.isEmpty) {
      yemekleriYukle();
    }else {
      var liste = await yrepo.ara(aramaKelimesi);
      emit(liste);
    }
  }
}