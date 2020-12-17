import 'Individual.dart';
import 'SelectionMethod.dart';
import 'constant.dart';

class SelectionMethod_Rank implements SelectionMethod {
  @override
  List<Individual> getBestIndividuals(List<Individual> population) {
    List<Individual> bestIndividu = [];

    int i = 0;
    while (bestIndividu.length < maxBestIndividu && i < population.length) {
      if (isGoodIndividual(population[i])) {
        bestIndividu.add(population[i]);
      }
      i += 1;
    }
    return bestIndividu;
  }

  bool isGoodIndividual(Individual individual) {
    // 5 is an "high score"
    return individual.score > 5;
  }
}
