extension RoleExtension on String {
  RoleType toRoleEnum() {
    switch (this) {
      case 'user':
        return RoleType.consumer;

      default:
        return RoleType.noRole;
    }
  }

  String toLiteralValue() {
    switch (this) {
      case 'consumer':
        return 'Consumidor';

      default:
        return 'Sin rol asignado';
    }
  }
}

enum RoleType {
  consumer,
  noRole,
}
