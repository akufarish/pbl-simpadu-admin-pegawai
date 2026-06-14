part of 'verifikasi_count_cubit.dart';

@immutable
abstract class TotalVerifikasiState {}

class TotalVerifikasiInitial extends TotalVerifikasiState {}

class TotalVerifikasiLoading extends TotalVerifikasiState {}

class TotalVerifikasiSuccess extends TotalVerifikasiState {
  final int dataVerifikasi;

  TotalVerifikasiSuccess(this.dataVerifikasi);
}

class TotalVerifikasiError extends TotalVerifikasiState {
  final String errorMessage;
  TotalVerifikasiError(this.errorMessage);
}
