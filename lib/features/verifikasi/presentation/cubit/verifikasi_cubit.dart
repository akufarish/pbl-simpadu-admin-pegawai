import 'package:admin_pegawai_bloc/features/verifikasi/domain/entities/verifikasi_entity.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/domain/usecase/verifikasi_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verifikasi_state.dart';

class VerifikasiCubit extends Cubit<VerifikasiState> {
  final VerifikasiUsecase verifikasiUsecase;

  VerifikasiCubit(this.verifikasiUsecase) : super(VerifikasiInitial());

  Future<void> getDataVerifikasi() async {
    emit(VerifikasiLoading());
    try {
      final result = await verifikasiUsecase.getDataVerifikasi();
      emit(VerifikasiSuccess(result));
    } catch (e) {
      emit(VerifikasiError(e.toString().replaceAll("Exception:", "")));
    }
  }
}
