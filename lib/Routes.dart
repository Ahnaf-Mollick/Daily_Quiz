import 'package:get/get.dart';
import 'package:quiz_app/Screens/QustionScreen.dart';
import 'package:quiz_app/Screens/ResultScreen.dart';

class Routes {
  static const String QUESTIONSCREEN = '/questionscreen';
  static const String RESULTSCREEN = '/resultscreen';

  static List<GetPage> routes = [
    GetPage(name: QUESTIONSCREEN, page: () => QuestionScreen()),
    GetPage(name: RESULTSCREEN, page: () => ResultScreen()),
  ];
}
