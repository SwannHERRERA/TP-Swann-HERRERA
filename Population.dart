import 'dart:math';

import 'Individual.dart';
import 'SelectionMethod.dart';
import 'constant.dart';
import 'helper.dart';

class Population {
  List<Individual> individuals = [];

  Population() {
    var numberOfIndividu = Random().nextInt(maxInitialMaxNumberOfIndividu);
    List<Individual> individuals = [];
    for (int i = 0; i < numberOfIndividu; i += 1) {
      individuals.add(new Individual(false, generateRandomString(30)));
    }
    this.individuals = individuals;

    _addCondamined();
  }

  void mutation() {
    for (int i = 0; i < individuals.length; i += 1) {
      individuals[i].evolveGeneticCode();
    }
  }

  void reproduction(SelectionMethod selectionMethod) {
    List<Individual> bestIndividuals =
        selectionMethod.getBestIndividuals(individuals);
    if (bestIndividuals.length > maxPopulation) {
      return;
    }
    for (int i = 0; i < bestIndividuals.length - 1; i += 2) {
      Individual mother = bestIndividuals[i];
      Individual father = bestIndividuals[i + 1];

      var individu = new Individual(false, '');
      individu.setGeneticCode(mother, father);
      individuals.add(individu);
    }
  }

  int killContamined(nbInfected) {
    for (int i = 0; i < individuals.length; i += 1) {
      if (individuals[i].contaminatedSince >= contaminatedDayLimit) {
        individuals.remove(individuals[i]);
        nbInfected -= 1;
      }
    }
    return nbInfected;
  }

  int diffuseVirus(int nbInfected) {
    for (int i = 0; i < individuals.length; i += 1) {
      if (_diffuseVirusByIndividu(individuals[i])) {
        nbInfected += 1;
      }
    }
    return nbInfected;
  }

  bool _diffuseVirusByIndividu(Individual individual) {
    if (individual.contamined) {
      individual.contaminatedSince += 1;
      return false;
    }
    // un individu est imunisé si son score est inférieur a limitImunity
    if (Random().nextInt(limitImunity) > individual.score) {
      individual.contamined = true;
      return true;
    }
    return false;
  }

  void _addCondamined() {
    var maxInt = individuals.length - 1;
    if (maxInt < 0) {
      maxInt = 0;
    }
    var infectedIndividualId = Random().nextInt(individuals.length);

    individuals[infectedIndividualId].contamined = true;
  }

  int getSize() {
    return individuals.length;
  }

  @override
  String toString() {
    String result = '';
    for (int i = 0; i < individuals.length; i += 1) {
      result += '\n' + individuals[i].toString();
    }
    return result;
  }
}
