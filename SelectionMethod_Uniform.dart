import 'dart:math';

import 'Individual.dart';
import 'SelectionMethod.dart';
import 'constant.dart';

class SelectionMethod_Uniform implements SelectionMethod {
  @override
  List<Individual> getBestIndividuals(List<Individual> population) {
    List<Individual> bestIndividuals = [];
    // An individu can be select 2 times;
    int numberOfBestIndividu = _selectNumberOfBestIndividu(population);
    for (int i = 0; i < numberOfBestIndividu; i += 1) {
      bestIndividuals.add(_pickRandomIndividu(population));
    }

    return population;
  }

  int _selectNumberOfBestIndividu(List<Individual> population) {
    if (population.length > maxBestIndividu) {
      return maxBestIndividu;
    }
    return (population.length / 2).floor();
  }

  Individual _pickRandomIndividu(List<Individual> population) {
    var max = population.length - 1;
    if (max < 0) {
      max = 0;
    }
    return population[Random().nextInt(max)];
  }
}
