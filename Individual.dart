import 'helper.dart';

class Individual {
  bool contamined = false;
  String geneticCode = "";
  int score = 0;
  int contaminatedSince = 0;

  Individual(bool contamined, String geneticCode) {
    this.contamined = contamined;
    this.geneticCode = geneticCode;
    this.contaminatedSince = 0;

    _calcScore();
  }

  Individual.empty() {} // 2gd constructor for empty item

  void evolveGeneticCode() {
    var randomChar = generateRandomString(1);
    this.geneticCode.replaceAll(this.geneticCode[0], randomChar);
    _calcScore();
  }

  void _calcScore() {
    // Score is based on number of alphabetic char
    var regExp = RegExp("\\w+");
    this.score = regExp.allMatches(this.geneticCode).length;
  }

  Individual setGeneticCode(Individual mother, Individual father) {
    var geneticCode = mother.geneticCode.substring(0, 10) +
        generateRandomString(10) +
        father.geneticCode.substring(20, 30);
    geneticCode.split('').shuffle();
    this.geneticCode = geneticCode;
    return this;
  }

  @override
  String toString() {
    return 'Individual(contamined: $contamined, geneticCode: $geneticCode, score: $score)';
  }
}
