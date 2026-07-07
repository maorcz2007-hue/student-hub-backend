import 'package:flutter/material.dart';
import 'package:student_hub/core/l10n/translations/en.dart';
import 'package:student_hub/core/l10n/translations/he.dart';
import 'package:student_hub/core/l10n/translations/ar.dart';
import 'package:student_hub/core/l10n/translations/ru.dart';
import 'package:student_hub/core/l10n/translations/fr.dart';
import 'package:student_hub/core/l10n/translations/es.dart';
import 'package:student_hub/core/l10n/translations/de.dart';
import 'package:student_hub/core/l10n/translations/pt.dart';
import 'package:student_hub/core/l10n/translations/zh.dart';
import 'package:student_hub/core/l10n/translations/ja.dart';
import 'package:student_hub/core/l10n/translations/ko.dart';
import 'package:student_hub/core/l10n/translations/tr.dart';

/// Localized strings accessor.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': en,
    'he': he,
    'ar': ar,
    'ru': ru,
    'fr': fr,
    'es': es,
    'de': de,
    'pt': pt,
    'zh': zh,
    'ja': ja,
    'ko': ko,
    'tr': tr,
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }

  // ── Auth ──
  String get appName => translate('app_name');
  String get signIn => translate('sign_in');
  String get signUp => translate('sign_up');
  String get email => translate('email');
  String get password => translate('password');
  String get confirmPassword => translate('confirm_password');
  String get fullName => translate('full_name');
  String get enterEmail => translate('enter_email');
  String get enterPassword => translate('enter_password');
  String get enterFullName => translate('enter_full_name');
  String get rememberMe => translate('remember_me');
  String get forgotPassword => translate('forgot_password');
  String get orContinueWith => translate('or_continue_with');
  String get dontHaveAccount => translate('dont_have_account');
  String get alreadyHaveAccount => translate('already_have_account');
  String get signInToContinue => translate('sign_in_to_continue');
  String get createAccount => translate('create_account');
  String get agreeToTerms => translate('agree_to_terms');
  String get passwordRequired => translate('password_required');
  String get invalidEmail => translate('invalid_email');

  // ── Dashboard ──
  String get dashboard => translate('dashboard');
  String get goodMorning => translate('good_morning');
  String get goodAfternoon => translate('good_afternoon');
  String get goodEvening => translate('good_evening');
  String get academicStanding => translate('academic_standing');
  String get completed => translate('completed');
  String get thisSemester => translate('this_semester');
  String get pendingTasks => translate('pending_tasks');
  String get avgGrade => translate('avg_grade');
  String get activeCourses => translate('active_courses');
  String get studyTime => translate('study_time');
  String get todaysSchedule => translate('todays_schedule');
  String get upcomingDeadlines => translate('upcoming_deadlines');
  String get gradeTrend => translate('grade_trend');
  String get aiStudySuggestion => translate('ai_study_suggestion');
  String get seeAll => translate('see_all');

  // ── Navigation ──
  String get home => translate('home');
  String get assignments => translate('assignments');
  String get grades => translate('grades');
  String get calendar => translate('calendar');
  String get profile => translate('profile');
  String get settings => translate('settings');
  String get courses => translate('courses');
  String get messages => translate('messages');
  String get notifications => translate('notifications');
  String get files => translate('files');
  String get search => translate('search');
  String get feedback => translate('feedback');
  String get logout => translate('logout');

  // ── Settings ──
  String get language => translate('language');
  String get appearance => translate('appearance');
  String get darkMode => translate('dark_mode');
  String get lightMode => translate('light_mode');
  String get systemMode => translate('system_mode');

  // ── General ──
  String get loading => translate('loading');
  String get error => translate('error');
  String get retry => translate('retry');
  String get cancel => translate('cancel');
  String get save => translate('save');
  String get delete => translate('delete');
  String get edit => translate('edit');
  String get confirm => translate('confirm');
  String get noData => translate('no_data');
  String get complete => translate('complete_action');
  String get pageNotFound => translate('page_not_found');
  String get goHome => translate('go_home');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en', 'he', 'ar', 'ru', 'fr', 'es',
      'de', 'pt', 'zh', 'ja', 'ko', 'tr',
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
