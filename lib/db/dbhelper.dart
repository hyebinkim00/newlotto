import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/loto.dart';
import '../model/qrInfo.dart';
import '../model/selfnum.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._(); // DBHelper의 싱글톤 객체 생성
  static Database? _database; // 데이터베이스 인스턴스를 저장하는 변수

  DBHelper._(); // DBHelper 생성자(private)

  factory DBHelper() => _instance; // DBHelper 인스턴스 반환 메소드

  // 데이터베이스 인스턴스를 가져오는 메소드
  Future<Database> get database async {
    if (_database != null) {
      // 인스턴스가 이미 존재한다면
      return _database!; // 저장된 데이터베이스 인스턴스를 반환
    }
    _database = await _initDB(); // 데이터베이스 초기화
    return _database!; // 초기화된 데이터베이스 인스턴스 반환
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath(); // 데이터베이스 경로 가져오기
    final path = join(dbPath, 'example.db'); // 데이터베이스 파일 경로 생성
    return await openDatabase(
      path, // 데이터베이스 파일 경로
      version: 1, // 데이터베이스 버전
      onCreate: (db, version) async {
        // onCreate 처음 만들어질때만 호출됨

        // MainController에서 회차 별 당첨 번호 저장 (처음에 20개 , 한주 마다 한개씩 추가)
        await db.execute(
          "CREATE TABLE Lotos(id INTEGER PRIMARY KEY, drwNoDate TEXT, drwNo INTEGER, drwtNo1 INTEGER, drwtNo2 INTEGER, drwtNo3 INTEGER, drwtNo4 INTEGER, drwtNo5 INTEGER, drwtNo6 INTEGER, bnusNo INTEGER)",
        );

        // SelfPage 에서 입력한 번호 6개 리스트 + 회차 선택 넣어야 됨
        await db.execute(
          'CREATE TABLE selfNum(id INTEGER PRIMARY KEY, serial INTEGER, num1 INTEGER, num2 INTEGER, num3 INTEGER, num4 INTEGER, num5 INTEGER, num6 INTEGER)',
        );

        await db.execute(
          'CREATE TABLE qrInfo(id INTEGER PRIMARY KEY, serial TEXT, myNum TEXT)',
        );

      },
    );
  }

  Future<void> insertDataList(selfNum list) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    await db.insert(
      'selfNum',
      list.toMap(), // 추가할 데이터
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복 데이터 처리 방법 설정
    );
  }

  // SelfController 저장된 리스트 가져오는 버전 2
  Future<List<selfNum>> getselfList() async {
    List<selfNum> lists = [];
    final db = await database; // 데이터베이스 인스턴스 가져오기
    List<Map<String, dynamic>> maps = await db.query('selfNum');
    for (var map in maps) {
      lists.add(selfNum.fromMap(map));
      print('hbs'+lists[0].toString());
    }
    return lists;
  }

// self 저장 리스트중 제일 큰 회차수 가져오기
 Future<List<selfNum>> getselfLastserial() async {
    List<selfNum> lists = [];
    final db = await database; // 데이터베이스 인스턴스 가져오기
    List<Map<String, dynamic>> maps = await db.query('selfNum',orderBy: 'serial DESC');
    for (var map in maps) {
      lists.add(selfNum.fromMap(map));
      print('hbs'+lists[0].toString());
    }
    return lists;
  }

  //MainController에서 회차별 정보 저장
  Future addLoto(Loto loto) async {
    final db = await database;
    print('dbdb${loto.drwNo}');
    int s = await db.insert('Lotos', loto.toMap());
  }

  //MainController에서 회차별 정보 저장한 리스트 가져오기
  // SelfConto
  Future<List<Loto>> getLoto() async {
    List<Loto> lists = [];
    final db = await database; // 데이터베이스 인스턴스 가져오기
    List<Map<String, dynamic>> maps =
        await db.query('Lotos', orderBy: 'drwNo DESC');
    for (var map in maps) {
      lists.add(Loto.fromMap(map));
    }
    return lists;
  }

  Future<List<selfNum>> queryByColumnSelf(int? targetSerial) async {
    List<selfNum> lists = [];
    Database dbClient = await database;
    final List<Map<String, dynamic>> maps  =  await dbClient.query(
      'selfNum',
      where: 'serial = ?',
      whereArgs: [targetSerial],
    );
    for (var map in maps) {
      lists.add(selfNum.fromMap(map));
    }
    return lists;
  }

  // MyPageController 에서 회차 번호 별
  Future<List<int>> queryByColumnDrwno(int? targetValue) async {
    List<int> list = [];
    Database dbClient = await database;
    final List<Map<String, dynamic>> maps  =  await dbClient.query(
      'Lotos',
      where: 'drwNo = ?',
      whereArgs: [targetValue],
    );

    for (int i = 1; i <= 6; i++) {
      String columnName = 'drwtNo$i';
      list.add(maps[0][columnName]);
    }
    return list;
  }


  Future<void> insertData(qrInfo qrInfo) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    await db.insert(
      'qrInfo', // 데이터를 추가할 테이블 이름
      qrInfo.toMap(), // 추가할 데이터
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복 데이터 처리 방법 설정
    );
  }


  Future<List<qrInfo>> getAllNumLists() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('qrInfo');
    return List.generate(maps.length, (index) {
      return qrInfo.fromMap(maps[index]);
    });
  }

}
