import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:student_hub/app/theme/color_schemes.dart';
import 'package:student_hub/core/utils/validators.dart';
import 'package:student_hub/core/widgets/animated_button.dart';
import 'package:student_hub/features/auth/presentation/providers/auth_provider.dart';
import 'package:student_hub/core/l10n/app_localizations.dart';
import 'package:student_hub/core/widgets/language_picker.dart';

/// Registration screen with step-by-step form and glassmorphism.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _studentIdController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms and conditions')),
      );
      return;
    }

    final success = await ref.read(authStateProvider.notifier).register(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      studentId: _studentIdController.text.trim().isEmpty
          ? null
          : _studentIdController.text.trim(),
    );

    if (success && mounted) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: isDark
                ? [const Color(0xFF0A0A1A), const Color(0xFF1A1A2E), const Color(0xFF0A0A1A)]
                : [const Color(0xFFF0F0FF), const Color(0xFFE0E8FF), const Color(0xFFF5F0FF)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.white.withValues(alpha: 0.80),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 18, color: theme.colorScheme.primary),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Title
                FadeInDown(
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          gradient: AppColorSchemes.primaryGradient(theme.colorScheme.primary),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(alpha: 0.30),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(Iconsax.user_add, size: 30, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(l10n.createAccount, style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(
                        'Join StudentHub today', // Optional: We could localize this later if needed, but for now we'll keep as is or just leave it. Or I'll use appName.
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.60),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Form
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.white.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.10)
                                : Colors.white.withValues(alpha: 0.50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: isDark ? 0.30 : 0.06),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (authState.error != null) ...[
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.error.withValues(alpha: 0.10),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.error_outline, color: theme.colorScheme.error, size: 20),
                                      const SizedBox(width: 8),
                                      Expanded(child: Text(authState.error!, style: TextStyle(color: theme.colorScheme.error, fontSize: 13))),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],

                              _buildField(theme, l10n.fullName, _nameController, Iconsax.user, l10n.enterFullName,
                                  validator: Validators.name, textInputAction: TextInputAction.next),
                              const SizedBox(height: 16),

                              _buildField(theme, l10n.email, _emailController, Iconsax.sms, l10n.enterEmail,
                                  validator: Validators.email, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next),
                              const SizedBox(height: 16),

                              _buildField(theme, 'Student ID (optional)', _studentIdController, Iconsax.card, 'Enter your student ID',
                                  textInputAction: TextInputAction.next),
                              const SizedBox(height: 16),

                              Text(l10n.password, style: theme.textTheme.titleSmall),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                textInputAction: TextInputAction.next,
                                validator: Validators.password,
                                decoration: InputDecoration(
                                  hintText: l10n.enterPassword,
                                  prefixIcon: Icon(Iconsax.lock_1, size: 20, color: theme.colorScheme.primary),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscurePassword ? Iconsax.eye_slash : Iconsax.eye, size: 20),
                                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              Text(l10n.confirmPassword, style: theme.textTheme.titleSmall),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirm,
                                textInputAction: TextInputAction.done,
                                validator: (v) => Validators.confirmPassword(v, _passwordController.text),
                                decoration: InputDecoration(
                                  hintText: l10n.confirmPassword,
                                  prefixIcon: Icon(Iconsax.lock_1, size: 20, color: theme.colorScheme.primary),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscureConfirm ? Iconsax.eye_slash : Iconsax.eye, size: 20),
                                    onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              Row(
                                children: [
                                  SizedBox(
                                    width: 22, height: 22,
                                    child: Checkbox(
                                      value: _agreeTerms,
                                      onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      l10n.agreeToTerms,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              PrimaryButton(
                                text: l10n.signUp,
                                onPressed: _handleRegister,
                                isLoading: authState.isLoading,
                                useGradient: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Login link
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.alreadyHaveAccount, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.60))),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Text(l10n.signIn, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
          const Positioned(
            top: 16,
            right: 16,
            child: LanguagePicker(),
          ),
        ],
      ),
    ),
  ),
);
  }

  Widget _buildField(ThemeData theme, String label, TextEditingController controller, IconData icon, String hint,
      {String? Function(String?)? validator, TextInputType? keyboardType, TextInputAction? textInputAction}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: theme.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
