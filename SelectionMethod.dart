import 'Individual.dart';

mixin SelectionMethod {
  // Methode par defaut
  List<Individual> getBestIndividuals(List<Individual> population) {
    return [new Individual.empty()];
  }
}
