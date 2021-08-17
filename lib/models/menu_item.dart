import 'dart:math';

class MenuItem {
  String key;
  String name;
  String description;
  String image;
  String kCal;
  late String group;
  double price;
  double? rating;

  MenuItem({required this.key, this.name = 'n/a', this.description = '', this.image = '', this.kCal = '0.0', this.price = 0, this.rating});

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'date': DateTime.now().millisecondsSinceEpoch,
        'kCal': kCal,
        'price': price,
        'rating': rating,
        'key': key,
        'image': image,
        'group': group,
      }..removeWhere((k, v) => (v == null || v.toString().isEmpty));

  MenuItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'] ??
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        image = json['image'],
        kCal = json['kCal'] ?? json['kcal'],
        price = double.tryParse('${json['price'] ?? ''}') ?? 0,
        rating = json['rating'],
        group = json['group'],
        key = json['key'];
}
