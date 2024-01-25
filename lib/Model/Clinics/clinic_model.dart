class Clincs {
  int? id;
  String? hospitalName;
  String? startingTime;
  String? endingTime;
  String? address;
  String? location;

  Clincs(
      {this.id,
      this.hospitalName,
      this.startingTime,
      this.endingTime,
      this.address,
      this.location});

  Clincs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalName = json['hospital_Name'];
    startingTime = json['startingTime'];
    endingTime = json['endingTime'];
    address = json['address'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospital_Name'] = hospitalName;
    data['startingTime'] = startingTime;
    data['endingTime'] = endingTime;
    data['address'] = address;
    data['location'] = location;
    return data;
  }
}