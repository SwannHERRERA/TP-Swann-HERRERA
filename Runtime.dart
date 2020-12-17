import 'Population.dart';
import 'SelectionMethod.dart';
import 'SelectionMethod_Rank.dart';
import 'SelectionMethod_Tournament.dart';
import 'SelectionMethod_Uniform.dart';

class Runtime {
  Population population = new Population();
  SelectionMethod selectionMethod = new SelectionMethod_Rank();
  int nbInfected = 1;
  int dayCounter = 0;

  Runtime() {
    while (nbInfected > 0 && population.individuals.isNotEmpty) {
      _newDay();
    }
    _printResult(population, dayCounter);
  }

  void _newDay() {
    dayCounter += 1;
    _printDailyReport();
    nbInfected = population.diffuseVirus(nbInfected);
    population.reproduction(selectionMethod);
    population.mutation();
    nbInfected = population.killContamined(nbInfected);
  }

  void _printDailyReport() {
    print(""" 
    Jour N°$dayCounter
    Nombre d'infecté $nbInfected
    Taille de la population: ${population.getSize()}
    """);
  }

  void _printResult(Population population, int dayCounter) {
    print(population.toString());
    print("La projection a durée $dayCounter jour(s)");
  }
}
