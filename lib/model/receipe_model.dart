class ReceipeModel {
  int? id;
  String? name, des;
  ReceipeModel({required this.id, required this.name, required this.des});
  factory ReceipeModel.mapToModel(Map<String, dynamic> m1) {
    return ReceipeModel(
      id: m1['res_id'],
      name: m1['res_name'],
      des: m1['res_des'],
    );
  }

  Map<String, dynamic> get toMap => {
        'res_id': id,
        'res_name': name,
        'res_des': des,
      };
}
