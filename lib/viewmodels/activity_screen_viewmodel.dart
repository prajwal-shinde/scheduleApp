import 'package:schedule_app/utils/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ActivityScreenViewModel extends BaseViewModel implements Initialisable {
  final navigationService = NavigationService();
  Map<String, double> dataMap = {"new_facts": 12};
  Map<String, double> useful_skills = {"new_facts": 15};
  Map<String, double> mindfulness = {"new_facts": 13};
  Map<String, double> exercise = {"new_facts": 16};
  bool? animateNewFact = false;
  List<String> cardTitles = ['Mind', 'Body', 'Money', 'Tribe', 'World'];

  animateCard() async {
    print(animateNewFact);

    await Future.delayed(Duration(seconds: 2), () {
      animateNewFact = !animateNewFact!;
    });
    notifyListeners();
  }

  @override
  void initialise() {
    animateCard();
    // TODO: implement initialise
  }
}
