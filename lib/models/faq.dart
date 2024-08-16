class FAQ {
  String pertanyaan;
  String jawaban;
  bool isExpanded = false;

  FAQ({required this.pertanyaan, required this.jawaban});

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      pertanyaan: json['pertanyaan'],
      jawaban: json['jawaban'],
    );
  }
}
