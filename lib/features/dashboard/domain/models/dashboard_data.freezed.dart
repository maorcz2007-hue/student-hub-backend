// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) {
  return _DashboardData.fromJson(json);
}

/// @nodoc
mixin _$DashboardData {
  double get gpa => throw _privateConstructorUsedError;
  String get academicStanding => throw _privateConstructorUsedError;
  int get completedCredits => throw _privateConstructorUsedError;
  int get totalCredits => throw _privateConstructorUsedError;
  int get semesterCreditsCompleted => throw _privateConstructorUsedError;
  int get semesterCreditsTotal => throw _privateConstructorUsedError;
  int get pendingTasks => throw _privateConstructorUsedError;
  double get avgGrade => throw _privateConstructorUsedError;
  int get activeCourses => throw _privateConstructorUsedError;
  int get studyTimeHours => throw _privateConstructorUsedError;
  List<ScheduleItem> get todaySchedule => throw _privateConstructorUsedError;
  List<DeadlineItem> get upcomingDeadlines =>
      throw _privateConstructorUsedError;
  List<GradeTrendSpot> get gradeTrend => throw _privateConstructorUsedError;
  String get aiSuggestion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardDataCopyWith<DashboardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardDataCopyWith<$Res> {
  factory $DashboardDataCopyWith(
          DashboardData value, $Res Function(DashboardData) then) =
      _$DashboardDataCopyWithImpl<$Res, DashboardData>;
  @useResult
  $Res call(
      {double gpa,
      String academicStanding,
      int completedCredits,
      int totalCredits,
      int semesterCreditsCompleted,
      int semesterCreditsTotal,
      int pendingTasks,
      double avgGrade,
      int activeCourses,
      int studyTimeHours,
      List<ScheduleItem> todaySchedule,
      List<DeadlineItem> upcomingDeadlines,
      List<GradeTrendSpot> gradeTrend,
      String aiSuggestion});
}

/// @nodoc
class _$DashboardDataCopyWithImpl<$Res, $Val extends DashboardData>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpa = null,
    Object? academicStanding = null,
    Object? completedCredits = null,
    Object? totalCredits = null,
    Object? semesterCreditsCompleted = null,
    Object? semesterCreditsTotal = null,
    Object? pendingTasks = null,
    Object? avgGrade = null,
    Object? activeCourses = null,
    Object? studyTimeHours = null,
    Object? todaySchedule = null,
    Object? upcomingDeadlines = null,
    Object? gradeTrend = null,
    Object? aiSuggestion = null,
  }) {
    return _then(_value.copyWith(
      gpa: null == gpa
          ? _value.gpa
          : gpa // ignore: cast_nullable_to_non_nullable
              as double,
      academicStanding: null == academicStanding
          ? _value.academicStanding
          : academicStanding // ignore: cast_nullable_to_non_nullable
              as String,
      completedCredits: null == completedCredits
          ? _value.completedCredits
          : completedCredits // ignore: cast_nullable_to_non_nullable
              as int,
      totalCredits: null == totalCredits
          ? _value.totalCredits
          : totalCredits // ignore: cast_nullable_to_non_nullable
              as int,
      semesterCreditsCompleted: null == semesterCreditsCompleted
          ? _value.semesterCreditsCompleted
          : semesterCreditsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      semesterCreditsTotal: null == semesterCreditsTotal
          ? _value.semesterCreditsTotal
          : semesterCreditsTotal // ignore: cast_nullable_to_non_nullable
              as int,
      pendingTasks: null == pendingTasks
          ? _value.pendingTasks
          : pendingTasks // ignore: cast_nullable_to_non_nullable
              as int,
      avgGrade: null == avgGrade
          ? _value.avgGrade
          : avgGrade // ignore: cast_nullable_to_non_nullable
              as double,
      activeCourses: null == activeCourses
          ? _value.activeCourses
          : activeCourses // ignore: cast_nullable_to_non_nullable
              as int,
      studyTimeHours: null == studyTimeHours
          ? _value.studyTimeHours
          : studyTimeHours // ignore: cast_nullable_to_non_nullable
              as int,
      todaySchedule: null == todaySchedule
          ? _value.todaySchedule
          : todaySchedule // ignore: cast_nullable_to_non_nullable
              as List<ScheduleItem>,
      upcomingDeadlines: null == upcomingDeadlines
          ? _value.upcomingDeadlines
          : upcomingDeadlines // ignore: cast_nullable_to_non_nullable
              as List<DeadlineItem>,
      gradeTrend: null == gradeTrend
          ? _value.gradeTrend
          : gradeTrend // ignore: cast_nullable_to_non_nullable
              as List<GradeTrendSpot>,
      aiSuggestion: null == aiSuggestion
          ? _value.aiSuggestion
          : aiSuggestion // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardDataImplCopyWith<$Res>
    implements $DashboardDataCopyWith<$Res> {
  factory _$$DashboardDataImplCopyWith(
          _$DashboardDataImpl value, $Res Function(_$DashboardDataImpl) then) =
      __$$DashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double gpa,
      String academicStanding,
      int completedCredits,
      int totalCredits,
      int semesterCreditsCompleted,
      int semesterCreditsTotal,
      int pendingTasks,
      double avgGrade,
      int activeCourses,
      int studyTimeHours,
      List<ScheduleItem> todaySchedule,
      List<DeadlineItem> upcomingDeadlines,
      List<GradeTrendSpot> gradeTrend,
      String aiSuggestion});
}

/// @nodoc
class __$$DashboardDataImplCopyWithImpl<$Res>
    extends _$DashboardDataCopyWithImpl<$Res, _$DashboardDataImpl>
    implements _$$DashboardDataImplCopyWith<$Res> {
  __$$DashboardDataImplCopyWithImpl(
      _$DashboardDataImpl _value, $Res Function(_$DashboardDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpa = null,
    Object? academicStanding = null,
    Object? completedCredits = null,
    Object? totalCredits = null,
    Object? semesterCreditsCompleted = null,
    Object? semesterCreditsTotal = null,
    Object? pendingTasks = null,
    Object? avgGrade = null,
    Object? activeCourses = null,
    Object? studyTimeHours = null,
    Object? todaySchedule = null,
    Object? upcomingDeadlines = null,
    Object? gradeTrend = null,
    Object? aiSuggestion = null,
  }) {
    return _then(_$DashboardDataImpl(
      gpa: null == gpa
          ? _value.gpa
          : gpa // ignore: cast_nullable_to_non_nullable
              as double,
      academicStanding: null == academicStanding
          ? _value.academicStanding
          : academicStanding // ignore: cast_nullable_to_non_nullable
              as String,
      completedCredits: null == completedCredits
          ? _value.completedCredits
          : completedCredits // ignore: cast_nullable_to_non_nullable
              as int,
      totalCredits: null == totalCredits
          ? _value.totalCredits
          : totalCredits // ignore: cast_nullable_to_non_nullable
              as int,
      semesterCreditsCompleted: null == semesterCreditsCompleted
          ? _value.semesterCreditsCompleted
          : semesterCreditsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      semesterCreditsTotal: null == semesterCreditsTotal
          ? _value.semesterCreditsTotal
          : semesterCreditsTotal // ignore: cast_nullable_to_non_nullable
              as int,
      pendingTasks: null == pendingTasks
          ? _value.pendingTasks
          : pendingTasks // ignore: cast_nullable_to_non_nullable
              as int,
      avgGrade: null == avgGrade
          ? _value.avgGrade
          : avgGrade // ignore: cast_nullable_to_non_nullable
              as double,
      activeCourses: null == activeCourses
          ? _value.activeCourses
          : activeCourses // ignore: cast_nullable_to_non_nullable
              as int,
      studyTimeHours: null == studyTimeHours
          ? _value.studyTimeHours
          : studyTimeHours // ignore: cast_nullable_to_non_nullable
              as int,
      todaySchedule: null == todaySchedule
          ? _value._todaySchedule
          : todaySchedule // ignore: cast_nullable_to_non_nullable
              as List<ScheduleItem>,
      upcomingDeadlines: null == upcomingDeadlines
          ? _value._upcomingDeadlines
          : upcomingDeadlines // ignore: cast_nullable_to_non_nullable
              as List<DeadlineItem>,
      gradeTrend: null == gradeTrend
          ? _value._gradeTrend
          : gradeTrend // ignore: cast_nullable_to_non_nullable
              as List<GradeTrendSpot>,
      aiSuggestion: null == aiSuggestion
          ? _value.aiSuggestion
          : aiSuggestion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardDataImpl implements _DashboardData {
  const _$DashboardDataImpl(
      {required this.gpa,
      required this.academicStanding,
      required this.completedCredits,
      required this.totalCredits,
      required this.semesterCreditsCompleted,
      required this.semesterCreditsTotal,
      required this.pendingTasks,
      required this.avgGrade,
      required this.activeCourses,
      required this.studyTimeHours,
      required final List<ScheduleItem> todaySchedule,
      required final List<DeadlineItem> upcomingDeadlines,
      required final List<GradeTrendSpot> gradeTrend,
      required this.aiSuggestion})
      : _todaySchedule = todaySchedule,
        _upcomingDeadlines = upcomingDeadlines,
        _gradeTrend = gradeTrend;

  factory _$DashboardDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardDataImplFromJson(json);

  @override
  final double gpa;
  @override
  final String academicStanding;
  @override
  final int completedCredits;
  @override
  final int totalCredits;
  @override
  final int semesterCreditsCompleted;
  @override
  final int semesterCreditsTotal;
  @override
  final int pendingTasks;
  @override
  final double avgGrade;
  @override
  final int activeCourses;
  @override
  final int studyTimeHours;
  final List<ScheduleItem> _todaySchedule;
  @override
  List<ScheduleItem> get todaySchedule {
    if (_todaySchedule is EqualUnmodifiableListView) return _todaySchedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todaySchedule);
  }

  final List<DeadlineItem> _upcomingDeadlines;
  @override
  List<DeadlineItem> get upcomingDeadlines {
    if (_upcomingDeadlines is EqualUnmodifiableListView)
      return _upcomingDeadlines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingDeadlines);
  }

  final List<GradeTrendSpot> _gradeTrend;
  @override
  List<GradeTrendSpot> get gradeTrend {
    if (_gradeTrend is EqualUnmodifiableListView) return _gradeTrend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gradeTrend);
  }

  @override
  final String aiSuggestion;

  @override
  String toString() {
    return 'DashboardData(gpa: $gpa, academicStanding: $academicStanding, completedCredits: $completedCredits, totalCredits: $totalCredits, semesterCreditsCompleted: $semesterCreditsCompleted, semesterCreditsTotal: $semesterCreditsTotal, pendingTasks: $pendingTasks, avgGrade: $avgGrade, activeCourses: $activeCourses, studyTimeHours: $studyTimeHours, todaySchedule: $todaySchedule, upcomingDeadlines: $upcomingDeadlines, gradeTrend: $gradeTrend, aiSuggestion: $aiSuggestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardDataImpl &&
            (identical(other.gpa, gpa) || other.gpa == gpa) &&
            (identical(other.academicStanding, academicStanding) ||
                other.academicStanding == academicStanding) &&
            (identical(other.completedCredits, completedCredits) ||
                other.completedCredits == completedCredits) &&
            (identical(other.totalCredits, totalCredits) ||
                other.totalCredits == totalCredits) &&
            (identical(
                    other.semesterCreditsCompleted, semesterCreditsCompleted) ||
                other.semesterCreditsCompleted == semesterCreditsCompleted) &&
            (identical(other.semesterCreditsTotal, semesterCreditsTotal) ||
                other.semesterCreditsTotal == semesterCreditsTotal) &&
            (identical(other.pendingTasks, pendingTasks) ||
                other.pendingTasks == pendingTasks) &&
            (identical(other.avgGrade, avgGrade) ||
                other.avgGrade == avgGrade) &&
            (identical(other.activeCourses, activeCourses) ||
                other.activeCourses == activeCourses) &&
            (identical(other.studyTimeHours, studyTimeHours) ||
                other.studyTimeHours == studyTimeHours) &&
            const DeepCollectionEquality()
                .equals(other._todaySchedule, _todaySchedule) &&
            const DeepCollectionEquality()
                .equals(other._upcomingDeadlines, _upcomingDeadlines) &&
            const DeepCollectionEquality()
                .equals(other._gradeTrend, _gradeTrend) &&
            (identical(other.aiSuggestion, aiSuggestion) ||
                other.aiSuggestion == aiSuggestion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      gpa,
      academicStanding,
      completedCredits,
      totalCredits,
      semesterCreditsCompleted,
      semesterCreditsTotal,
      pendingTasks,
      avgGrade,
      activeCourses,
      studyTimeHours,
      const DeepCollectionEquality().hash(_todaySchedule),
      const DeepCollectionEquality().hash(_upcomingDeadlines),
      const DeepCollectionEquality().hash(_gradeTrend),
      aiSuggestion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardDataImplCopyWith<_$DashboardDataImpl> get copyWith =>
      __$$DashboardDataImplCopyWithImpl<_$DashboardDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardDataImplToJson(
      this,
    );
  }
}

abstract class _DashboardData implements DashboardData {
  const factory _DashboardData(
      {required final double gpa,
      required final String academicStanding,
      required final int completedCredits,
      required final int totalCredits,
      required final int semesterCreditsCompleted,
      required final int semesterCreditsTotal,
      required final int pendingTasks,
      required final double avgGrade,
      required final int activeCourses,
      required final int studyTimeHours,
      required final List<ScheduleItem> todaySchedule,
      required final List<DeadlineItem> upcomingDeadlines,
      required final List<GradeTrendSpot> gradeTrend,
      required final String aiSuggestion}) = _$DashboardDataImpl;

  factory _DashboardData.fromJson(Map<String, dynamic> json) =
      _$DashboardDataImpl.fromJson;

  @override
  double get gpa;
  @override
  String get academicStanding;
  @override
  int get completedCredits;
  @override
  int get totalCredits;
  @override
  int get semesterCreditsCompleted;
  @override
  int get semesterCreditsTotal;
  @override
  int get pendingTasks;
  @override
  double get avgGrade;
  @override
  int get activeCourses;
  @override
  int get studyTimeHours;
  @override
  List<ScheduleItem> get todaySchedule;
  @override
  List<DeadlineItem> get upcomingDeadlines;
  @override
  List<GradeTrendSpot> get gradeTrend;
  @override
  String get aiSuggestion;
  @override
  @JsonKey(ignore: true)
  _$$DashboardDataImplCopyWith<_$DashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScheduleItem _$ScheduleItemFromJson(Map<String, dynamic> json) {
  return _ScheduleItem.fromJson(json);
}

/// @nodoc
mixin _$ScheduleItem {
  String get name => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  int get colorValue =>
      throw _privateConstructorUsedError; // To store color cleanly
  bool get isNow => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleItemCopyWith<ScheduleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleItemCopyWith<$Res> {
  factory $ScheduleItemCopyWith(
          ScheduleItem value, $Res Function(ScheduleItem) then) =
      _$ScheduleItemCopyWithImpl<$Res, ScheduleItem>;
  @useResult
  $Res call(
      {String name, String time, String location, int colorValue, bool isNow});
}

/// @nodoc
class _$ScheduleItemCopyWithImpl<$Res, $Val extends ScheduleItem>
    implements $ScheduleItemCopyWith<$Res> {
  _$ScheduleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? time = null,
    Object? location = null,
    Object? colorValue = null,
    Object? isNow = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      isNow: null == isNow
          ? _value.isNow
          : isNow // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduleItemImplCopyWith<$Res>
    implements $ScheduleItemCopyWith<$Res> {
  factory _$$ScheduleItemImplCopyWith(
          _$ScheduleItemImpl value, $Res Function(_$ScheduleItemImpl) then) =
      __$$ScheduleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String time, String location, int colorValue, bool isNow});
}

/// @nodoc
class __$$ScheduleItemImplCopyWithImpl<$Res>
    extends _$ScheduleItemCopyWithImpl<$Res, _$ScheduleItemImpl>
    implements _$$ScheduleItemImplCopyWith<$Res> {
  __$$ScheduleItemImplCopyWithImpl(
      _$ScheduleItemImpl _value, $Res Function(_$ScheduleItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? time = null,
    Object? location = null,
    Object? colorValue = null,
    Object? isNow = null,
  }) {
    return _then(_$ScheduleItemImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      isNow: null == isNow
          ? _value.isNow
          : isNow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleItemImpl implements _ScheduleItem {
  const _$ScheduleItemImpl(
      {required this.name,
      required this.time,
      required this.location,
      required this.colorValue,
      required this.isNow});

  factory _$ScheduleItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleItemImplFromJson(json);

  @override
  final String name;
  @override
  final String time;
  @override
  final String location;
  @override
  final int colorValue;
// To store color cleanly
  @override
  final bool isNow;

  @override
  String toString() {
    return 'ScheduleItem(name: $name, time: $time, location: $location, colorValue: $colorValue, isNow: $isNow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.colorValue, colorValue) ||
                other.colorValue == colorValue) &&
            (identical(other.isNow, isNow) || other.isNow == isNow));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, time, location, colorValue, isNow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleItemImplCopyWith<_$ScheduleItemImpl> get copyWith =>
      __$$ScheduleItemImplCopyWithImpl<_$ScheduleItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleItemImplToJson(
      this,
    );
  }
}

abstract class _ScheduleItem implements ScheduleItem {
  const factory _ScheduleItem(
      {required final String name,
      required final String time,
      required final String location,
      required final int colorValue,
      required final bool isNow}) = _$ScheduleItemImpl;

  factory _ScheduleItem.fromJson(Map<String, dynamic> json) =
      _$ScheduleItemImpl.fromJson;

  @override
  String get name;
  @override
  String get time;
  @override
  String get location;
  @override
  int get colorValue;
  @override // To store color cleanly
  bool get isNow;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleItemImplCopyWith<_$ScheduleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeadlineItem _$DeadlineItemFromJson(Map<String, dynamic> json) {
  return _DeadlineItem.fromJson(json);
}

/// @nodoc
mixin _$DeadlineItem {
  String get title => throw _privateConstructorUsedError;
  String get due => throw _privateConstructorUsedError;
  int get colorValue => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeadlineItemCopyWith<DeadlineItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeadlineItemCopyWith<$Res> {
  factory $DeadlineItemCopyWith(
          DeadlineItem value, $Res Function(DeadlineItem) then) =
      _$DeadlineItemCopyWithImpl<$Res, DeadlineItem>;
  @useResult
  $Res call({String title, String due, int colorValue, double progress});
}

/// @nodoc
class _$DeadlineItemCopyWithImpl<$Res, $Val extends DeadlineItem>
    implements $DeadlineItemCopyWith<$Res> {
  _$DeadlineItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? due = null,
    Object? colorValue = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      due: null == due
          ? _value.due
          : due // ignore: cast_nullable_to_non_nullable
              as String,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeadlineItemImplCopyWith<$Res>
    implements $DeadlineItemCopyWith<$Res> {
  factory _$$DeadlineItemImplCopyWith(
          _$DeadlineItemImpl value, $Res Function(_$DeadlineItemImpl) then) =
      __$$DeadlineItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String due, int colorValue, double progress});
}

/// @nodoc
class __$$DeadlineItemImplCopyWithImpl<$Res>
    extends _$DeadlineItemCopyWithImpl<$Res, _$DeadlineItemImpl>
    implements _$$DeadlineItemImplCopyWith<$Res> {
  __$$DeadlineItemImplCopyWithImpl(
      _$DeadlineItemImpl _value, $Res Function(_$DeadlineItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? due = null,
    Object? colorValue = null,
    Object? progress = null,
  }) {
    return _then(_$DeadlineItemImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      due: null == due
          ? _value.due
          : due // ignore: cast_nullable_to_non_nullable
              as String,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeadlineItemImpl implements _DeadlineItem {
  const _$DeadlineItemImpl(
      {required this.title,
      required this.due,
      required this.colorValue,
      required this.progress});

  factory _$DeadlineItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeadlineItemImplFromJson(json);

  @override
  final String title;
  @override
  final String due;
  @override
  final int colorValue;
  @override
  final double progress;

  @override
  String toString() {
    return 'DeadlineItem(title: $title, due: $due, colorValue: $colorValue, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeadlineItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.due, due) || other.due == due) &&
            (identical(other.colorValue, colorValue) ||
                other.colorValue == colorValue) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, due, colorValue, progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeadlineItemImplCopyWith<_$DeadlineItemImpl> get copyWith =>
      __$$DeadlineItemImplCopyWithImpl<_$DeadlineItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeadlineItemImplToJson(
      this,
    );
  }
}

abstract class _DeadlineItem implements DeadlineItem {
  const factory _DeadlineItem(
      {required final String title,
      required final String due,
      required final int colorValue,
      required final double progress}) = _$DeadlineItemImpl;

  factory _DeadlineItem.fromJson(Map<String, dynamic> json) =
      _$DeadlineItemImpl.fromJson;

  @override
  String get title;
  @override
  String get due;
  @override
  int get colorValue;
  @override
  double get progress;
  @override
  @JsonKey(ignore: true)
  _$$DeadlineItemImplCopyWith<_$DeadlineItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GradeTrendSpot _$GradeTrendSpotFromJson(Map<String, dynamic> json) {
  return _GradeTrendSpot.fromJson(json);
}

/// @nodoc
mixin _$GradeTrendSpot {
  double get monthIndex => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GradeTrendSpotCopyWith<GradeTrendSpot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GradeTrendSpotCopyWith<$Res> {
  factory $GradeTrendSpotCopyWith(
          GradeTrendSpot value, $Res Function(GradeTrendSpot) then) =
      _$GradeTrendSpotCopyWithImpl<$Res, GradeTrendSpot>;
  @useResult
  $Res call({double monthIndex, double score});
}

/// @nodoc
class _$GradeTrendSpotCopyWithImpl<$Res, $Val extends GradeTrendSpot>
    implements $GradeTrendSpotCopyWith<$Res> {
  _$GradeTrendSpotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthIndex = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      monthIndex: null == monthIndex
          ? _value.monthIndex
          : monthIndex // ignore: cast_nullable_to_non_nullable
              as double,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GradeTrendSpotImplCopyWith<$Res>
    implements $GradeTrendSpotCopyWith<$Res> {
  factory _$$GradeTrendSpotImplCopyWith(_$GradeTrendSpotImpl value,
          $Res Function(_$GradeTrendSpotImpl) then) =
      __$$GradeTrendSpotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double monthIndex, double score});
}

/// @nodoc
class __$$GradeTrendSpotImplCopyWithImpl<$Res>
    extends _$GradeTrendSpotCopyWithImpl<$Res, _$GradeTrendSpotImpl>
    implements _$$GradeTrendSpotImplCopyWith<$Res> {
  __$$GradeTrendSpotImplCopyWithImpl(
      _$GradeTrendSpotImpl _value, $Res Function(_$GradeTrendSpotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthIndex = null,
    Object? score = null,
  }) {
    return _then(_$GradeTrendSpotImpl(
      monthIndex: null == monthIndex
          ? _value.monthIndex
          : monthIndex // ignore: cast_nullable_to_non_nullable
              as double,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GradeTrendSpotImpl implements _GradeTrendSpot {
  const _$GradeTrendSpotImpl({required this.monthIndex, required this.score});

  factory _$GradeTrendSpotImpl.fromJson(Map<String, dynamic> json) =>
      _$$GradeTrendSpotImplFromJson(json);

  @override
  final double monthIndex;
  @override
  final double score;

  @override
  String toString() {
    return 'GradeTrendSpot(monthIndex: $monthIndex, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GradeTrendSpotImpl &&
            (identical(other.monthIndex, monthIndex) ||
                other.monthIndex == monthIndex) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, monthIndex, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GradeTrendSpotImplCopyWith<_$GradeTrendSpotImpl> get copyWith =>
      __$$GradeTrendSpotImplCopyWithImpl<_$GradeTrendSpotImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GradeTrendSpotImplToJson(
      this,
    );
  }
}

abstract class _GradeTrendSpot implements GradeTrendSpot {
  const factory _GradeTrendSpot(
      {required final double monthIndex,
      required final double score}) = _$GradeTrendSpotImpl;

  factory _GradeTrendSpot.fromJson(Map<String, dynamic> json) =
      _$GradeTrendSpotImpl.fromJson;

  @override
  double get monthIndex;
  @override
  double get score;
  @override
  @JsonKey(ignore: true)
  _$$GradeTrendSpotImplCopyWith<_$GradeTrendSpotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
