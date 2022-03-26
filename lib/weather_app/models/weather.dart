class Weather {
  String? description;
  String? icon;

  Weather({this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}