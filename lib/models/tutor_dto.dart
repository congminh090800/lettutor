import 'package:lettutor/models/feedback_dto.dart';
import 'package:lettutor/models/schedule_dto.dart';

class TutorDTO {
  String? id;
  String? userId;
  String? avatar;
  String? bio;
  DateTime? birthDay;
  String? country;
  String? education;
  String? email;
  String? experience;
  String? facebook;
  List<FeedbackDTO> feedbacks = [];
  String? google;
  String? interests;
  bool? isActivated;
  bool? isNative;
  bool? isPhoneActivated;
  bool? isPhoneAuthActivated;
  String? language;
  String? languages;
  String? level;
  String? name;
  String? phone;
  String? phoneAuth;
  int? price;
  String? profession;
  bool? requestPassword;
  String? requireNote;
  String? resume;
  List<ScheduleDTO> schedules = [];
  String? specialties;
  String? targetStudent;
  int? timezone;
  String? video;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  TutorDTO(
      this.id,
      this.userId,
      this.avatar,
      this.bio,
      this.birthDay,
      this.country,
      this.education,
      this.email,
      this.experience,
      this.facebook,
      this.feedbacks,
      this.google,
      this.interests,
      this.isActivated,
      this.isNative,
      this.isPhoneActivated,
      this.isPhoneAuthActivated,
      this.language,
      this.languages,
      this.level,
      this.name,
      this.phone,
      this.phoneAuth,
      this.price,
      this.profession,
      this.requestPassword,
      this.requireNote,
      this.resume,
      this.schedules,
      this.specialties,
      this.targetStudent,
      this.timezone,
      this.video,
      this.createdAt,
      this.deletedAt,
      this.updatedAt);
}
