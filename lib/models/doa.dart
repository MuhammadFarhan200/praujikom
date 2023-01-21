class ModelDoa {
  late final String id;
  late final String doa;
  late final String ayat;
  late final String latin;
  late final String artinya;

  ModelDoa({required this.id, required this.doa, required this.ayat, required this.latin, required this.artinya});

  factory ModelDoa.formJson(Map<String, dynamic> json) {
    return ModelDoa(
      id: json['id'] ?? '',
      doa: json['doa'] ?? '',
      ayat: json['ayat'] ?? '',
      latin: json['latin'] ?? '',
      artinya: json['artinya'] ?? '',
    );
  }
}
