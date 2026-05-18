class PegawaiResponse {
  final String id;
  final String nip;
  final String nik;
  final String employeeName;
  final String? address;
  final String? birthPlace;
  final String? birthDate;
  final String? gender;
  final String? phoneNumber;
  final String? villageCode;
  final String? districtCode;
  final String? cityCode;
  final String? provinceCode;
  final Domisili? village;
  final Domisili? district;
  final Domisili? city;
  final Domisili? province;

  PegawaiResponse({
    required this.id,
    required this.nip,
    required this.nik,
    required this.employeeName,
    required this.address,
    required this.birthDate,
    required this.birthPlace,
    required this.gender,
    required this.phoneNumber,
    required this.village,
    required this.villageCode,
    required this.district,
    required this.districtCode,
    required this.city,
    required this.cityCode,
    required this.province,
    required this.provinceCode,
  });

  factory PegawaiResponse.fromJson(Map<String, dynamic> json) {
    return PegawaiResponse(
      id: json["id"],
      nip: json["nip"],
      address: json["address"],
      birthDate: json["birth_date"],
      birthPlace: json["birth_place"],
      cityCode: json["city_code"],
      gender: json["gender"],
      nik: json["nik"],
      districtCode: json["district_code"],
      employeeName: json["employee_name"],
      phoneNumber: json["phone_number"],
      provinceCode: json["province_code"],
      villageCode: json["village_code"],
      city: json["city"] != null ? Domisili.fromJson(json["city"]) : null,
      district: json["district"] != null
          ? Domisili.fromJson(json["district"])
          : null,
      province: json["province"] != null
          ? Domisili.fromJson(json["province"])
          : null,
      village: json["village"] != null
          ? Domisili.fromJson(json["village"])
          : null,
    );
  }
}

class PegawaiRequest {
  final String nip;
  final String nik;
  final String employeeName;
  final String citizenCode;

  PegawaiRequest({
    required this.nip,
    required this.nik,
    required this.employeeName,
    required this.citizenCode,
  });

  factory PegawaiRequest.fromJson(Map<String, dynamic> json) {
    return PegawaiRequest(
      nik: json["nik"],
      nip: json["nip"],
      citizenCode: json["citizen_code"],
      employeeName: json["employee_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "nik": nik,
    "nip": nip,
    "citizen_code": citizenCode,
    "employee_name": employeeName,
  };
}

class Domisili {
  final String id;
  final String code;
  final String name;

  Domisili({required this.id, required this.code, required this.name});

  factory Domisili.fromJson(Map<String, dynamic> json) {
    return Domisili(id: json["id"], code: json["code"], name: json["name"]);
  }
}
