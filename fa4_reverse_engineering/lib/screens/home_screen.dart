import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/data/user_repository.dart';
import 'package:fa4_reverse_engineering/screens/login_screen.dart';
import 'package:fa4_reverse_engineering/screens/settings_screen.dart';
import 'package:fa4_reverse_engineering/screens/supply_screen.dart';
import 'package:fa4_reverse_engineering/widgets/dialogs.dart';
import 'package:fa4_reverse_engineering/widgets/firefly_logo.dart';
import 'package:fa4_reverse_engineering/widgets/theme_toggle_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Logout confirmation',
      message: 'Are you sure you want to logout?',
    );
    if (!confirmed || !context.mounted) return;

    UserRepository.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = UserRepository.currentUser;
    final headline = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      appBar: AppBar(
        leading: const ThemeToggleButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kScreenPadding),
          child: Column(
            children: [
              Text('Hello', style: headline, textAlign: TextAlign.center),
              Text(
                user?.fullName ?? '',
                style: headline,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'You are now one of the Fireflies',
                style: headline,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kSectionSpacing),
              const FireflyLogo(width: kLogoHome),
              const SizedBox(height: kSectionSpacing),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SupplyScreen()),
                  );
                },
                child: const Text('Check for Supplies'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
