import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';
import '../../widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: size.width < 600 ? double.infinity : 400,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Create Account", style: AppStyles.heading),
                const SizedBox(height: 8),
                Text("Register to continue", style: AppStyles.subheading),
                const SizedBox(height: 32),

                CustomTextField(
                  label: 'Full Name',
                  icon: const Icon(Icons.person_outline),
                  controller: nameController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Email',
                  icon: const Icon(Icons.email_outlined),
                  controller: emailController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Password',
                  icon: const Icon(Icons.lock_outline),
                  controller: passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Confirm Password',
                  icon: const Icon(Icons.lock_person_outlined),
                  controller: confirmPasswordController,
                  isPassword: true,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Connect to Dio or Bloc registration
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Register', style: AppStyles.buttonText),
                  ),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: AppStyles.linkText,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
