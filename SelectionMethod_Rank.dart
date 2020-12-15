import 'Individual.dart';
import 'SelectionMethod.dart';
import 'constant.dart';

class SelectionMethod_Rank implements SelectionMethod {
  @override
  List<Individual> getBestIndividuals(List<Individual> population) {
    List<Individual> bestIndividu = [];
    for (int i = 0; i < population.length; i += 1) {
      if (bestIndividu.length > maxBestIndividu) {
        break;
      }
      if (isGoodIndividual(population[i])) {
        bestIndividu.add(population[i]);
      }
    }
    return bestIndividu;
  }

  bool isGoodIndividual(Individual individual) {
    // 5 is an "high score"
    return individual.score > 5;
  }
}
