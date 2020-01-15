class Quiz {
  int id;
  String questionText;
  List<String> answerList;
  String correctAnswer;

  Quiz({this.id, this.questionText, this.answerList, this.correctAnswer});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionText = json['questionText'];
    answerList = json['answerList'].cast<String>();
    correctAnswer = json['correctAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['questionText'] = this.questionText;
    data['answerList'] = this.answerList;
    data['correctAnswer'] = this.correctAnswer;
    return data;
  }
}
