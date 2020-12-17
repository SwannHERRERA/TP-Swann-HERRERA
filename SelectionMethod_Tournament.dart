import 'Individual.dart';
import 'SelectionMethod.dart';

class SelectionMethod_Tournament implements SelectionMethod {
  @override
  List<Individual> getBestIndividuals(List<Individual> population) {
    List<Individual> bestIndividuals = [];
    for (int i = 0; i < population.length - 1; i += 2) {
      Individual challenger_1 = population[i];
      Individual challenger_2 = population[i + 1];
      _addBestChallenger(challenger_1, challenger_2, bestIndividuals);
    }
    return bestIndividuals;
  }

  void _addBestChallenger(Individual challenger_1, Individual challenger_2,
      List<Individual> bestIndividuals) {
    if (challenger_1.score > challenger_2.score) {
      bestIndividuals.add(challenger_1);
    } else {
      bestIndividuals.add(challenger_2);
    }
  }
}
