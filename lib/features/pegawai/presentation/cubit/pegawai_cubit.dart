import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/usecase/pegawai_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pegawai_state.dart';

class PegawaiCubit extends Cubit<PegawaiState> {
  final PegawaiUsecase pegawaiUsecase;

  PegawaiCubit(this.pegawaiUsecase) : super(PegawaiInitial());

  Future<void> getDataPegawai() async {
    emit(PegawaiLoading());
    try {
      final result = await pegawaiUsecase.getDataPegawai();
      emit(PegawaiSuccess(result));
    } catch (e) {
      emit(PegawaiError(e.toString().replaceAll("Exception:", "")));
    }
  }

  Future<void> getTotalPegawai() async {
    emit(PegawaiCountLoading());
    try {
      final result = await pegawaiUsecase.getTotalPegawai();
      emit(PegawaiCountSuccess(result));
    } catch (e) {
      emit(PegawaiCountError(e.toString().replaceAll("Exception:", "")));
    }
  }
}
