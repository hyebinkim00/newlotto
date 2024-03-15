import 'package:cp949_codec/cp949_codec.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:newlotto/model/loto.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../db/dbhelper.dart';
import '../../push/firebase_message.dart';
import '../../retrofit/retrofit_client.dart';


class HomeController extends GetxController{

  // 최근 회차번호
  RxInt lastSerial = 0.obs;
  RxInt days = 0.obs;
  RxList<String> lists = ['0', '0', '0', '0', '0', '0', '+', '0'].obs;


  @override
  void onInit() {
    super.onInit();
    // 1.  웹페이지에서 최근회차 가져오기  2. 해당회차에 대한 당첨번호 보여주기 3. 당첨번호 리스트 업데이트
    getLastNo();
  }

  String getDate() {
    DateTime dateTime = DateTime.now();

    int currentDayOfWeek = dateTime.weekday;
    // 토요일의 인덱스를 계산합니다 (토요일: 6)
    int saturdayIndex = DateTime.saturday;

    // 토요일까지 남은 일수를 계산합니다.
    int daysRemaining = (saturdayIndex - currentDayOfWeek) % 7;

    days.value = daysRemaining;

    print('GETDATE_${daysRemaining}');


    DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
    var today = dateFormat.format(dateTime);
    return today;
  }

  void getLastNo() async {
    await Permission.notification.request();

    // 웹페이지 크롤링 해서 마지막 회차 가져오기

    final response = await http
        .get(Uri.parse('https://dhlottery.co.kr/gameResult.do?method=byWin'));

    if (response.bodyBytes.isEmpty) {
      print('응답이 비어 있습니다.');
      return;
    }
    // 응답이 euc-kr 로 와서 한글이 깨짐 -> cp949 디코딩
    final document = htmlParser.parse(cp949.decodeString(response.body));
    final element = document.querySelector('.win_result strong');

    String windResult = element!.text;
    String numText = windResult.replaceAll('회', '');
    int seral = int.parse(numText);
    print('lateee${lastSerial}');
    if (lastSerial.value != seral){
      lastSerial.value = seral;
      retro(seral);
      updateList(seral);
    }

  }

  Future<void> retro(int dd) async {
    List<String> list = [];
    final logger = PrettyDioLogger(request: true, responseBody: true);

    try {
      final dio = Dio(BaseOptions(
        responseType: ResponseType.plain, // 이 부분을 수정
      ));
      dio.interceptors.add(logger);

      final client = RestClient(dio);
      Loto response = await client.getTasks('getLottoNumber', dd);
      for (var i in response.getIntValues()) {
        if (i == -1) {
          list.add('+');
        } else {
          list.add(i.toString());
        }
      }
      lists.value = list;
    } catch (e) {
      print('Retrofit____Error: $e');
      if (e is DioError) {
        if (e.response?.data is String) {
          // 응답 데이터가 String인 경우에 대한 처리
          print('Server response (String): ${e.response?.data}');
        } else {
          print('DioError: ${e.response?.statusCode}, ${e.message}');
          print('Server response: ${e.response?.data}');
        }
      }
    }
  }

  // DB 에 저장
  Future<void> updateList(int serial) async {
    List<Loto> list = [];
    // 저장되어 있는 값 확인
    list = await DBHelper().getLoto();

    if (list.isEmpty) {
      for (int i = 0; i <= 40; i++) {
        // 20개 저장 (마지막 회차가 변경되어서 db 추가할때 id 순서를 바꿀수 없으니 내림차순으로 저장)

        await listDbsave(serial - i);
      }
    } else {
      print('LLLL${list[0].drwNo}');

      if(list[0].drwNo!=serial){
        // 최신 번호 바귀면 한개 저장
        await listDbsave(serial);
      }

    }
  }

  // 한개씩 DB에 저장
  Future<void> listDbsave(int serial) async {
    final dio = Dio(BaseOptions(
      responseType: ResponseType.plain, // 이 부분을 수정
    ));

    final client = RestClient(dio);
    Loto response = await client.getTasks('getLottoNumber', serial);
    await DBHelper().addLoto(response);
  }

}