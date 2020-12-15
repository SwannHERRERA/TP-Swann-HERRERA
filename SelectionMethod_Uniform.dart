import 'dart:math';

import 'Individual.dart';
import 'SelectionMethod.dart';
import 'constant.dart';

class SelectionMethod_Uniform implements SelectionMethod {
  @override
  List<Individual> getBestIndividuals(List<Individual> population) {
    List<Individual> bestIndividuals = [];
    // An individu can be select 2 times;
    int numberOfBestIndividu;
    if (population.length > maxBestIndividu) {
      numberOfBestIndividu = maxBestIndividu;
    } else {
      numberOfBestIndividu = (population.length / 2).floor();
    }
    for (int i = 0; i < numberOfBestIndividu; i += 1) {
      bestIndividuals.add(pickRandomIndividu(population));
    }

    return population;
  }

  Individual pickRandomIndividu(List<Individual> population) {
    var max = population.length - 1;
    if (max < 0) {
      max = 0;
    }
    return population[Random().nextInt(max)];
  }
}
