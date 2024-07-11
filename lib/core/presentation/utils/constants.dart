import 'package:waterhero/core/presentation/utils/icons_paths.dart';

/// This class will be contain all the [constantsValues] used by the application

class Constants {
  final List<Map<String, dynamic>> consumerOptions = [
    {
      'name': 'Consumo',
      'icon': iconsPaths.iconComsumption,
      'index': 0,
      'semanticLabel': 'opt_home',
    },
    {
      'name': 'Consejos',
      'icon': iconsPaths.iconTips,
      'index': 1,
      'semanticLabel': 'opt_offices',
    },
    {
      'name': 'Promociones',
      'icon': iconsPaths.iconPromotions,
      'index': 2,
      'semanticLabel': 'opt_advisors',
    },
  ];
}

/// Export the [constantsValues]
final Constants constants = Constants();
