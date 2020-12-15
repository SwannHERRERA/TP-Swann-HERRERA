import 'dart:math';
import 'SelectionMethod.dart';
import 'SelectionMethod_Rank.dart';
import 'SelectionMethod_Tournament.dart';
import 'SelectionMethod_Uniform.dart';
import 'helper.dart';
import 'Individual.dart';
import 'constant.dart';

void main() {
  var population = initPopulation();
  SelectionMethod selectionMethod = new SelectionMethod_Tournament();
  var nbInfected = 1;
  var dayCounter = 0;
  while (nbInfected > 0 && population.isNotEmpty) {
    dayCounter += 1;
    print("Jour N° " + dayCounter.toString());
    print("Nombre d'infecté " + nbInfected.toString());
    print("Taille de la population: " + population.length.toString());
    nbInfected = diffuseVirus(population, nbInfected);
    reproduction(population, selectionMethod);
    mutation(population);
    nbInfected = killContamined(population, nbInfected);
  }
  displayResult(population);
  print("La projection a durée $dayCounter jour(s)");
}

void mutation(List<Individual> population) {
  for (int i = 0; i < population.length; i += 1) {
    population[i].evolveGeneticCode();
  }
}

List<Individual> initPopulation() {
  var numberOfIndividu = Random().nextInt(maxInitialMaxNumberOfIndividu);
  List<Individual> population = [];
  for (int i = 0; i < numberOfIndividu; i += 1) {
    population.add(new Individual(false, generateRandomString(30)));
  }
  addCondamined(population);
  return population;
}

void reproduction(
    List<Individual> population, SelectionMethod selectionMethod) {
  List<Individual> bestIndividuals =
      selectionMethod.getBestIndividuals(population);
  if (bestIndividuals.length > maxPopulation) {
    return;
  }
  for (int i = 0; i < bestIndividuals.length - 1; i += 2) {
    Individual mother = bestIndividuals[i];
    Individual father = bestIndividuals[i + 1];
    var childGeneticCode = constructGeneticCode(mother, father);
    population.add(new Individual(false, childGeneticCode));
  }
}

String constructGeneticCode(Individual mother, Individual father) {
  var geneticCode = mother.geneticCode.substring(0, 10) +
      generateRandomString(10) +
      father.geneticCode.substring(20, 30);
  geneticCode.split('').shuffle();
  return geneticCode;
}

int killContamined(List<Individual> population, nbInfected) {
  for (int i = 0; i < population.length; i += 1) {
    if (population[i].contaminatedSince >= contaminatedDayLimit) {
      population.remove(population[i]);
      nbInfected -= 1;
    }
  }
  return nbInfected;
}

int diffuseVirus(List<Individual> population, int nbInfected) {
  for (int i = 0; i < population.length; i += 1) {
    if (diffuseVirusByIndividu(population[i])) {
      nbInfected += 1;
    }
  }
  return nbInfected;
}

bool diffuseVirusByIndividu(Individual individual) {
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

void addCondamined(List<Individual> population) {
  var maxInt = population.length - 1;
  if (maxInt < 0) {
    maxInt = 0;
  }
  var infectedIndividualId = Random().nextInt(population.length);

  population[infectedIndividualId].contamined = true;
}

void displayResult(List<Individual> population) {
  for (int i = 0; i < population.length; i += 1) {
    print(population[i].toString());
  }
}
