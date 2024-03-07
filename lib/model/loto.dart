class Loto {
  int? totSellamnt;
  String? returnValue;
  String? drwNoDate;
  int? firstWinamnt;
  int? drwtNo6;
  int? drwtNo4;
  int? firstPrzwnerCo;
  int? drwtNo5;
  int? bnusNo;
  int? firstAccumamnt;
  int? drwNo; // 회차
  int? drwtNo2;
  int? drwtNo3;
  int? drwtNo1;

  Loto(
      {this.totSellamnt,
        this.returnValue,
        this.drwNoDate,
        this.firstWinamnt,
        this.drwtNo6,
        this.drwtNo4,
        this.firstPrzwnerCo,
        this.drwtNo5,
        this.bnusNo,
        this.firstAccumamnt,
        this.drwNo,
        this.drwtNo2,
        this.drwtNo3,
        this.drwtNo1});

  @override
  String toString() {
    return '추첨일 :$drwNoDate, drwtNo6: $drwtNo6, drwtNo4: $drwtNo4, drwtNo5: $drwtNo5, bnusNo: $bnusNo, drwtNo2: $drwtNo2, drwtNo3: $drwtNo3, drwtNo1: $drwtNo1}';
  }

  List<int> getIntValues() {
    return [drwtNo1??0,drwtNo2??0,drwtNo3??0,drwtNo4??0,drwtNo5??0,drwtNo6??0,-1,bnusNo??0];
  }

  Loto.fromJson(Map<String, dynamic> json) {
    totSellamnt = json['totSellamnt'];
    returnValue = json['returnValue'];
    drwNoDate = json['drwNoDate'];
    firstWinamnt = json['firstWinamnt'];
    drwtNo6 = json['drwtNo6'];
    drwtNo4 = json['drwtNo4'];
    firstPrzwnerCo = json['firstPrzwnerCo'];
    drwtNo5 = json['drwtNo5'];
    bnusNo = json['bnusNo'];
    firstAccumamnt = json['firstAccumamnt'];
    drwNo = json['drwNo'];
    drwtNo2 = json['drwtNo2'];
    drwtNo3 = json['drwtNo3'];
    drwtNo1 = json['drwtNo1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totSellamnt'] = this.totSellamnt;
    data['returnValue'] = this.returnValue;
    data['drwNoDate'] = this.drwNoDate;
    data['firstWinamnt'] = this.firstWinamnt;
    data['drwtNo6'] = this.drwtNo6;
    data['drwtNo4'] = this.drwtNo4;
    data['firstPrzwnerCo'] = this.firstPrzwnerCo;
    data['drwtNo5'] = this.drwtNo5;
    data['bnusNo'] = this.bnusNo;
    data['firstAccumamnt'] = this.firstAccumamnt;
    data['drwNo'] = this.drwNo;
    data['drwtNo2'] = this.drwtNo2;
    data['drwtNo3'] = this.drwtNo3;
    data['drwtNo1'] = this.drwtNo1;
    return data;
  }

  //DB 저장
  Map<String, dynamic> toMap(){
    return {
      'drwNoDate' : drwNoDate,
      'drwNo': drwNo,
      'drwtNo1' : drwtNo1,
      'drwtNo2' : drwtNo2,
      'drwtNo3' : drwtNo3,
      'drwtNo4' : drwtNo4,
      'drwtNo5' : drwtNo5,
      'drwtNo6' : drwtNo6,
      'bnusNo' : bnusNo
    };
  }

  Loto.fromMap(Map<dynamic , dynamic> map){
    drwNoDate = map?['drwNoDate'];
    drwNo = map?['drwNo'];
    drwtNo1 = map?['drwtNo1'];
    drwtNo2 = map?['drwtNo2'];
    drwtNo3 = map?['drwtNo3'];
    drwtNo4 = map?['drwtNo4'];
    drwtNo5 = map?['drwtNo5'];
    drwtNo6 = map?['drwtNo6'];
    bnusNo = map?['bnusNo'];
  }

}