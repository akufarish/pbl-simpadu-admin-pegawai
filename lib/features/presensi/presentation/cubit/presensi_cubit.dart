import 'package:admin_pegawai_bloc/features/presensi/domain/entities/presensi_entity.dart';
import 'package:admin_pegawai_bloc/features/presensi/domain/usecase/presensi_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'presensi_state.dart';

class PresensiCubit extends Cubit<PresensiState> {
  final PresensiUsecase presensiUsecase;

  PresensiCubit(this.presensiUsecase) : super(PresensiInitial());

  Future<void> getDataPresensi() async {
    emit(PresensiLoading());
    try {
      final result = await presensiUsecase.getDataPresensi();
      emit(PresensiSuccess(result));
    } catch (e) {
      emit(PresensiError(e.toString().replaceAll("Exception:", "")));
    }
  }
}
