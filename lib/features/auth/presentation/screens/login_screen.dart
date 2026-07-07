import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/foundation.dart';
import 'package:animate_do/animate_do.dart';
import 'package:student_hub/app/theme/color_schemes.dart';
import 'package:student_hub/core/utils/validators.dart';
import 'package:student_hub/core/widgets/animated_button.dart';
import 'package:student_hub/features/auth/presentation/providers/auth_provider.dart';
import 'package:student_hub/core/l10n/app_localizations.dart';
import 'package:student_hub/core/widgets/language_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Beautiful Apple-inspired login screen with glassmorphism.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authStateProvider.notifier).login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success && mounted) {
      ref.read(authNotifierProvider.notifier).clearError();
    }
  }

  Future<void> _handleGoogleLogin() async {
    try {
      final googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        clientId: kIsWeb ? const String.fromEnvironment('GOOGLE_CLIENT_ID', defaultValue: '142452229743-j1uln2j5e8ntdbgq2b7frubfl1mm66hr.apps.googleusercontent.com') : null,
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // User canceled the sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Failed to get Google ID token');
      }

      final success = await ref.read(authNotifierProvider.notifier).socialLogin(
        provider: 'google',
        token: idToken,
        email: googleUser.email,
        fullName: googleUser.displayName,
      );

      if (success && mounted) {
        context.goNamed('dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In failed: $e')),
        );
      }
    }
  }

  Future<void> _handleAppleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final idToken = credential.identityToken;
      if (idToken == null) {
        throw Exception('Failed to get Apple ID token');
      }

      final fullName = [credential.givenName, credential.familyName]
          .where((n) => n != null && n.isNotEmpty)
          .join(' ');

      final success = await ref.read(authNotifierProvider.notifier).socialLogin(
        provider: 'apple',
        token: idToken,
        email: credential.email,
        fullName: fullName.isEmpty ? null : fullName,
      );

      if (success && mounted) {
        context.goNamed('dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Apple Sign-In failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authStateProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });

    final authState = ref.watch(authStateProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0A0A1A),
                    const Color(0xFF1A1A2E),
                    const Color(0xFF0A0A1A),
                  ]
                : [
                    const Color(0xFFF0F0FF),
                    const Color(0xFFE8E0FF),
                    const Color(0xFFF5F0FF),
                  ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height - MediaQuery.of(context).padding.vertical,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                  // ── Logo & Welcome ──
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: _buildLogo(theme, isDark, l10n),
                  ),

                  const SizedBox(height: 40),

                  // ── Login Form Card ──
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    child: _buildFormCard(theme, isDark, authState, l10n),
                  ),

                  const SizedBox(height: 24),

                  // ── Social Login ──
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 400),
                    child: _buildSocialLogin(theme, isDark, l10n),
                  ),

                  const SizedBox(height: 24),

                  // ── Register Link ──
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 500),
                    child: _buildRegisterLink(theme, l10n),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
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

  Widget _buildLogo(ThemeData theme, bool isDark, AppLocalizations l10n) {
    return Column(
      children: [
        // Animated gradient icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppColorSchemes.primaryGradient(theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Iconsax.teacher,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.appName,
          style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.signInToContinue,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.60),
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(ThemeData theme, bool isDark, AuthState authState, AppLocalizations l10n) {
    return ClipRRect(
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
              width: 0.5,
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
                // Error message
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
                        Expanded(
                          child: Text(
                            authState.error!,
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Email field
                Text(l10n.email, style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validators.email,
                  decoration: InputDecoration(
                    hintText: l10n.enterEmail,
                    prefixIcon: Icon(Iconsax.sms, size: 20, color: theme.colorScheme.primary),
                  ),
                ),

                const SizedBox(height: 20),

                // Password field
                Text(l10n.password, style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(),
                  validator: (v) => v == null || v.isEmpty ? l10n.passwordRequired : null,
                  decoration: InputDecoration(
                    hintText: l10n.enterPassword,
                    prefixIcon: Icon(Iconsax.lock_1, size: 20, color: theme.colorScheme.primary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                        size: 20,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.50),
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (v) => setState(() => _rememberMe = v ?? false),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(l10n.rememberMe, style: theme.textTheme.bodySmall),
                      ],
                    ),
                    TextButton(
                      onPressed: () => context.pushNamed('forgot-password'),
                      child: Text(
                        l10n.forgotPassword,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Login Button
                PrimaryButton(
                  text: l10n.signIn,
                  onPressed: _handleLogin,
                  isLoading: authState.isLoading,
                  useGradient: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLogin(ThemeData theme, bool isDark, AppLocalizations l10n) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: theme.colorScheme.outline.withValues(alpha: 0.30))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                l10n.orContinueWith,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.50),
                ),
              ),
            ),
            Expanded(child: Divider(color: theme.colorScheme.outline.withValues(alpha: 0.30))),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _SocialButton(
                icon: Icons.g_mobiledata_rounded,
                label: 'Google',
                onTap: _handleGoogleLogin,
                isDark: isDark,
              ),
            ),
            if (!kIsWeb) ...[
              const SizedBox(width: 12),
              Expanded(
                child: _SocialButton(
                  icon: Icons.apple,
                  label: 'Apple',
                  onTap: _handleAppleLogin,
                  isDark: isDark,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterLink(ThemeData theme, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.dontHaveAccount,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.60),
          ),
        ),
        GestureDetector(
          onTap: () => context.pushNamed('register'),
          child: Text(
            l10n.signUp,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.white.withValues(alpha: 0.80),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.10)
                : Colors.black.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
