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

/// Forgot password screen with email input and reset instructions.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authStateProvider.notifier).forgotPassword(
      _emailController.text.trim(),
    );

    if (success && mounted) {
      setState(() => _emailSent = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0A0A1A), const Color(0xFF1A1A2E)]
                : [const Color(0xFFF0F0FF), const Color(0xFFF5F0FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
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
                        color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.80),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 18, color: theme.colorScheme.primary),
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                FadeInDown(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Icon(
                          _emailSent ? Iconsax.tick_circle : Iconsax.lock,
                          size: 40,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _emailSent ? 'Check your Email' : 'Reset Password',
                        style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _emailSent
                            ? 'We\'ve sent a password reset link to\n${_emailController.text.trim()}'
                            : 'Enter your email address and we\'ll send\nyou a link to reset your password.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.60),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                if (!_emailSent)
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.white.withValues(alpha: 0.72),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.10) : Colors.white.withValues(alpha: 0.50)),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email', style: theme.textTheme.titleSmall),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: Validators.email,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
                                    prefixIcon: Icon(Iconsax.sms, size: 20, color: theme.colorScheme.primary),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                PrimaryButton(
                                  text: 'Send Reset Link',
                                  onPressed: _handleSubmit,
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

                if (_emailSent) ...[
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: PrimaryButton(
                      text: 'Back to Login',
                      onPressed: () => context.go('/auth/login'),
                      useGradient: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => setState(() => _emailSent = false),
                    child: Text('Try a different email', style: TextStyle(color: theme.colorScheme.primary)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
