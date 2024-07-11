import 'package:waterhero/core/presentation/utils/icons_paths.dart';

/// This class will be contain all the [constantsValues] used by the application

class Constants {
  final List<Map<String, dynamic>> consumerOptions = [
    {
      'name': 'Consumo',
      'icon': iconsPaths.iconFaucet,
      'index': 0,
      'semanticLabel': 'opt_consumption',
    },
    {
      'name': 'Consejos',
      'icon': iconsPaths.iconTips,
      'index': 1,
      'semanticLabel': 'opt_tips',
    },
    {
      'name': 'Promociones',
      'icon': iconsPaths.iconComsumption,
      'index': 2,
      'semanticLabel': 'opt_promotions',
    },
  ];
}

/// Export the [constantsValues]
final Constants constants = Constants();
