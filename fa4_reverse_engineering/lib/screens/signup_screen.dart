import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/constants/app_strings.dart';
import 'package:fa4_reverse_engineering/data/user_repository.dart';
import 'package:fa4_reverse_engineering/models/user.dart';
import 'package:fa4_reverse_engineering/utils/validators.dart';
import 'package:fa4_reverse_engineering/widgets/app_text_field.dart';
import 'package:fa4_reverse_engineering/widgets/dialogs.dart';
import 'package:fa4_reverse_engineering/widgets/firefly_logo_box.dart';
import 'package:fa4_reverse_engineering/widgets/password_field.dart';
import 'package:fa4_reverse_engineering/widgets/styled_button.dart';
import 'package:fa4_reverse_engineering/widgets/theme_toggle_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final username = _usernameController.text.trim();

    setState(() {
      _isLoading = false;
    });

    if (UserRepository.usernameTaken(username)) {
      showMessageDialog(
        context,
        title: kSignupFailedTitle,
        message: kUsernameTaken,
      );
      return;
    }

    UserRepository.register(
      User(
        username: username,
        password: _passwordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      ),
    );
    Navigator.of(context).pop();
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
              const FireflyLogoBox(height: kSignupLogoHeight),
              const SizedBox(height: 8),
              Text(
                'Become a Firefly',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: kFieldSpacing),
              AppTextField(
                label: 'Username',
                controller: _usernameController,
                maxLength: kMaxNameLength,
                validator: requiredField(kEnterUsername),
              ),
              PasswordField(
                controller: _passwordController,
                validator: requiredField(kEnterPassword),
              ),
              const SizedBox(height: kFieldSpacing),
              AppTextField(
                label: 'First Name',
                controller: _firstNameController,
                maxLength: kMaxNameLength,
                validator: requiredField(kEnterFirstName),
              ),
              AppTextField(
                label: 'Last Name',
                controller: _lastNameController,
                maxLength: kMaxNameLength,
                validator: requiredField(kEnterLastName),
              ),
              const SizedBox(height: 8),
              StyledButton(
                label: 'Signup',
                onPressed: _signup,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}