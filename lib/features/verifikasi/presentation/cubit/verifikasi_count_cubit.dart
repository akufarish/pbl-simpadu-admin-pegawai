import 'package:admin_pegawai_bloc/features/verifikasi/domain/usecase/verifikasi_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verifikasi_count_state.dart';

class VerifikasiCountCubit extends Cubit<TotalVerifikasiState> {
  final VerifikasiUsecase verifikasiUsecase;

  VerifikasiCountCubit(this.verifikasiUsecase)
    : super(TotalVerifikasiInitial());

  Future<void> getTotalPresensiPegawai() async {
    emit(TotalVerifikasiLoading());
    try {
      final result = await verifikasiUsecase.getTotalVerifikasiPending();
      emit(TotalVerifikasiSuccess(result.totalPending));
    } catch (e) {
      emit(TotalVerifikasiError(e.toString().replaceAll("Exception:", "")));
    }
  }
}
