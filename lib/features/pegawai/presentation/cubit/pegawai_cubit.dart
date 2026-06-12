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
      emit(PegawaiSuccess(dataPegawai: result, foundPegawai: result));
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

  void searchPegawai(String query) {
    if (state is PegawaiSuccess) {
      final currentState = state as PegawaiSuccess;

      if (query.isEmpty) {
        emit(currentState.copyWith(foundPegawai: currentState.dataPegawai));
      } else {
        final filteredList = currentState.dataPegawai.where((p) {
          return p.employeeName.toLowerCase().contains(query.toLowerCase());
        }).toList();

        emit(currentState.copyWith(foundPegawai: filteredList));
      }
    }
  }
}
