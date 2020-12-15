import 'Individual.dart';
import 'SelectionMethod.dart';

class SelectionMethod_Tournament implements SelectionMethod {
  @override
  List<Individual> getBestIndividuals(List<Individual> population) {
    List<Individual> bestIndividuals = [];
    for (int i = 0; i < population.length - 1; i += 2) {
      Individual combatant1 = population[i];
      Individual combatant2 = population[i + 1];
      if (combatant1.score > combatant2.score) {
        bestIndividuals.add(combatant1);
      } else {
        bestIndividuals.add(combatant2);
      }
    }
    return bestIndividuals;
  }
}
