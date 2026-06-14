class DataManager {
  static final DataManager _instance = DataManager._internal();
  factory DataManager() => _instance;
  DataManager._internal();

  final List<Map<String, dynamic>> questionList = [
    {
      "question": "Flutter এ State Management কেন দরকার?",
      "options": [
        "UI design করার জন্য",
        "Data এবং UI update control করার জন্য",
        "App install করার জন্য",
        "Image load করার জন্য",
      ],
      "answer": 1,
    },
    {
      "question": "setState() কী করে?",
      "options": [
        "App বন্ধ করে",
        "UI rebuild করে",
        "Database delete করে",
        "API call করে",
      ],
      "answer": 1,
    },
    {
      "question": "StatefulWidget কখন ব্যবহার করা হয়?",
      "options": [
        "যখন UI change হয় না",
        "যখন UI dynamic/changeable হয়",
        "শুধু image দেখানোর জন্য",
        "শুধু text দেখানোর জন্য",
      ],
      "answer": 1,
    },
  ];
  List<Map<String, dynamic>> get questions_list =>
      List.unmodifiable(questionList);
  int finalMarks = 0;
  int testNumber = 0;
  List<Map<String, dynamic>> results = [];

  void addResult() {
    testNumber++;

    results.add({"test": testNumber, "marks": finalMarks});
  }
}
