part of 'pegawai_cubit.dart';

@immutable
abstract class PegawaiState {}

class PegawaiInitial extends PegawaiState {}

class PegawaiLoading extends PegawaiState {}

class PegawaiSuccess extends PegawaiState {
  final List<PegawaiResponseEntity> dataPegawai;

  PegawaiSuccess(this.dataPegawai);
}

class PegawaiError extends PegawaiState {
  final String errorMessage;
  PegawaiError(this.errorMessage);
}

class PegawaiCountInitial extends PegawaiState {}

class PegawaiCountLoading extends PegawaiState {}

class PegawaiCountSuccess extends PegawaiState {
  final PegawaiCountEntity totalPegawai;

  PegawaiCountSuccess(this.totalPegawai);
}

class PegawaiCountError extends PegawaiState {
  final String errorMessage;
  PegawaiCountError(this.errorMessage);
}
