import 'dart:typed_data';

class RandomNums {
  String? date;
  Uint8List? nums; // List<int> 대신 Uint8List 사용
  int id = 0;

  RandomNums({this.date,this.nums});

  Map<String, dynamic> toMap(){
    return {
      'date' : date,
      'nums': nums,
    };
  }

  RandomNums.fromMap(Map<dynamic , dynamic> map){
    date = map?['date'];
    nums = Uint8List.fromList(List<int>.from(map?['nums']));
    id = map?['id'];
  }

  @override
  String toString() {
    return 'RandomNums{date: $date, nums: $nums}';
  }
}