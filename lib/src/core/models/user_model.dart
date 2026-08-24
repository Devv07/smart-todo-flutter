import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? profileImageUrl,
    String? bio,
    @Default(false) bool isDarkMode,
    @Default(0) int totalTasksCompleted,
    @Default(0) int totalProductiveMinutes,
    @Default([]) List<String> teams,
    @Default([]) List<String> collaborators,
    required DateTime createdAt,
    DateTime? lastActiveAt,
    @Default(true) bool notificationsEnabled,
    @Default('en') String language,
    String? timezone,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
