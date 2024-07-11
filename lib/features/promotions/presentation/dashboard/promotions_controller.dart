import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/promotions/domain/models/contacts_model.dart';
import 'package:waterhero/features/promotions/presentation/dashboard/promotions_state.dart';

class PromotionsController extends StateNotifier<PromotionsState> {
  PromotionsController() : super(PromotionsState());

  dynamic setIsLoading(isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void loadContacts() {
    final List<ContactsModel> promotions;
    promotions = [
      ContactsModel(
        name: 'Tres Astronatuas',
        email: 'contacto@tresastronautas.com',
        phone: '1234567890',
        address: 'Colombia',
      ),
      ContactsModel(
        name: 'Agua potable y saneamiento',
        email: '',
        phone: '1234567890',
        address: 'Colombia',
      ),
      ContactsModel(
        name: 'Agua potable y saneamiento',
        email: '',
        phone: '1234567890',
        address: 'Colombia',
      ),
    ];

    state = state.copyWith(promotions: promotions, isLoading: false);
  }
}

final promotionsController =
    StateNotifierProvider<PromotionsController, PromotionsState>((ref) {
  return PromotionsController();
});
