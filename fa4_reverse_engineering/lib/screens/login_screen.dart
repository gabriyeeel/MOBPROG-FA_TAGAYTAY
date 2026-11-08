import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/constants/app_strings.dart';
import 'package:fa4_reverse_engineering/data/user_repository.dart';
import 'package:fa4_reverse_engineering/screens/home_screen.dart';
import 'package:fa4_reverse_engineering/screens/signup_screen.dart';
import 'package:fa4_reverse_engineering/utils/validators.dart';
import 'package:fa4_reverse_engineering/widgets/app_text_field.dart';
import 'package:fa4_reverse_engineering/widgets/dialogs.dart';
import 'package:fa4_reverse_engineering/widgets/firefly_logo_box.dart';
import 'package:fa4_reverse_engineering/widgets/password_field.dart';
import 'package:fa4_reverse_engineering/widgets/styled_button.dart';
import 'package:fa4_reverse_engineering/widgets/theme_toggle_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final user = UserRepository.login(
      _usernameController.text.trim(),
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (user == null) {
      showMessageDialog(
        context,
        title: kLoginFailedTitle,
        message: kLoginFailedMessage,
      );
      return;
    }

    UserRepository.currentUser = user;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _goToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const ThemeToggleButton()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kFormPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const FireflyLogoBox(height: kLoginLogoHeight),
              AppTextField(
                label: 'Username',
                controller: _usernameController,
                validator: requiredField(kEnterUsername),
              ),
              const SizedBox(height: kFieldSpacing),
              PasswordField(
                controller: _passwordController,
                validator: requiredField(kEnterPassword),
              ),
              const SizedBox(height: kFieldSpacing),
              StyledButton(
                label: 'Login',
                onPressed: _login,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _goToSignup,
                child: const Text('Does not have an account yet? Sign Up now!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}