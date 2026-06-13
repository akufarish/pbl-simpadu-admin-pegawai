part of 'presensi_cubit.dart';

@immutable
abstract class PresensiState {}

class Presensi extends PresensiState {}

class PresensiInitial extends PresensiState {}

class PresensiLoading extends PresensiState {}

class PresensiSuccess extends PresensiState {
  final PresensiResponseEntity dataPresensi;

  PresensiSuccess(this.dataPresensi);
}

class PresensiError extends PresensiState {
  final String errorMessage;
  PresensiError(this.errorMessage);
}
