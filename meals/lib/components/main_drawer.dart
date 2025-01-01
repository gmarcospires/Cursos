import 'package:flutter/material.dart';
import 'package:meals/utils/app_routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _createItem(IconData icon, String label, void Function() onTap,
      BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  void onTapNavigate(BuildContext context, String route,
      [bool replace = false]) {
    if (replace) {
      Navigator.of(context).pushReplacementNamed(route);
    } else {
      Navigator.of(context).pushNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            // padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              // padding: const EdgeInsets.only(right: 10, top: 20),
              margin: MediaQuery.of(context).viewInsets +
                  const EdgeInsets.only(top: 20),
              child: Text(
                'Lets Cook?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _createItem(
            Icons.restaurant,
            'Refeições',
            () => onTapNavigate(context, AppRoutes.home, true),
            context,
          ),
          _createItem(
            Icons.settings,
            'Configurações',
            () => onTapNavigate(context, AppRoutes.settings, true),
            context,
          ),
        ],
      ),
    );
  }
}
