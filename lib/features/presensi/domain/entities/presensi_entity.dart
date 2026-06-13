class PresensiPegawaiEntity {
  final String detailId;
  final String name;
  final String email;
  final String status;

  PresensiPegawaiEntity({
    required this.detailId,
    required this.name,
    required this.email,
    required this.status,
  });
}

class PresensiEntity {
  final String sesiId;
  final List<PresensiPegawaiEntity>? pegawai;
  final String createdAt;

  PresensiEntity({required this.sesiId, this.pegawai, required this.createdAt});
}

class PresensiResponseEntity {
  List<PresensiEntity> items;

  PresensiResponseEntity(this.items);
}
