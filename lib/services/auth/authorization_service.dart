import 'auth_errors.dart'; // Import centralized error handling.

class AuthorizationService {
  bool canAccess(String role, String resource) {
    final resourcesByRole = {
      'student': ['attendance', 'units', 'analytics'],
      'lecturer': ['sessions', 'attendance', 'analytics', 'units'],
      'admin': ['programs', 'units', 'users', 'analytics'],
    };

    if (!resourcesByRole.containsKey(role.toLowerCase())) {
      throw AuthErrors.invalidRole(); // Throw error for invalid role.
    }

    return resourcesByRole[role.toLowerCase()]?.contains(resource) ?? false;
  }

  bool hasPermission(String role, String action, String resource) {
    final accessMap = {
      'student': {
        'view': ['attendance', 'units', 'analytics'],
      },
      'lecturer': {
        'view': ['sessions', 'attendance', 'analytics', 'units'],
        'create': ['sessions', 'attendance'],
        'edit': ['attendance'],
      },
      'admin': {
        'view': ['programs', 'units', 'users', 'analytics'],
        'create': ['programs', 'units', 'users'],
        'edit': ['programs', 'units', 'users'],
        'delete': ['programs', 'units', 'users'],
      },
    };

    if (!accessMap.containsKey(role.toLowerCase())) {
      throw AuthErrors.invalidRole(); // Throw error for invalid role.
    }

    if (!accessMap[role.toLowerCase()]?.containsKey(action) ?? true) {
      throw AuthErrors.invalidAction(); // Throw error for invalid action.
    }

    return accessMap[role.toLowerCase()]?[action]?.contains(resource) ?? false;
  }
}
