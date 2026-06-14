part of 'verifikasi_cubit.dart';

@immutable
abstract class VerifikasiState {}

class VerifikasiInitial extends VerifikasiState {}

class VerifikasiLoading extends VerifikasiState {}

class VerifikasiSuccess extends VerifikasiState {
  final List<VerifikasiEntity> dataVerifikasi;

  VerifikasiSuccess(this.dataVerifikasi);
}

class VerifikasiError extends VerifikasiState {
  final String errorMessage;
  VerifikasiError(this.errorMessage);
}

class UpdateVerifikasiInitial extends VerifikasiState {}

class UpdateVerifikasiLoading extends VerifikasiState {}

class UpdateVerifikasiSuccess extends VerifikasiState {
  final VerifikasiEntity dataVerifikasi;

  UpdateVerifikasiSuccess(this.dataVerifikasi);
}

class UpdateVerifikasiError extends VerifikasiState {
  final String errorMessage;
  UpdateVerifikasiError(this.errorMessage);
}
