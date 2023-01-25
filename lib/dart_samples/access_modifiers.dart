import 'package:flutter/foundation.dart';

void accessModifiers() {
  final awardTvShow = AwardTvShow();
  final awardNominees = awardTvShow.getAwardNominees();
  if (kDebugMode) {
    print("Award nominees: $awardNominees");
  }
}

class AwardTvShow {
  @protected
  List<String> getAwardNominees() {
    return [
      "Faça a Coisa Certa",
      "Cidade de Deus",
      "Racionais MC's: Das Ruas de São Paulo para o Mundo",
      "Marte Um",
      //...
    ];
  }

  String getWining() => _getRanking()[0];

  List<String> _getRanking() => [
        "Cidade de Deus",
        //...
      ];
}
