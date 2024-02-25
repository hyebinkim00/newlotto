import 'dart:convert';

class newNum {
  String? num1;
  String? num2;
  String? num3;
  String? num4;
  String? num5;
  String? num6;

  newNum({
    this.num1,
    this.num2,
    this.num3,
    this.num4,
    this.num5,
    this.num6,
  });

  Map<String, dynamic> toMap() {
    return {
      'num1': num1,
      'num2': num2,
      'num3': num3,
      'num4': num4,
      'num5': num5,
      'num6': num6,
    };
  }

  factory newNum.fromMap(Map<String, dynamic> map) {
    return newNum(
      num1: map['num1'],
      num2: map['num2'],
      num3: map['num3'],
      num4: map['num4'],
      num5: map['num5'],
      num6: map['num6'],
    );
  }

  String toJson() => jsonEncode(toMap());
  factory newNum.fromJson(String source) => newNum.fromMap(jsonDecode(source));

}