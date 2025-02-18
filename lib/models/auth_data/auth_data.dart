import 'package:json_annotation/json_annotation.dart';

part 'auth_data.g.dart';

@JsonSerializable()
class AuthData {
  final String id;
  final String username;
  final String email;
  final String password;
  @JsonKey(name: 'firebase_uid')
  final String firebaseUid;
  final String dob;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'facebook_id')
  final String? facebookId;
  @JsonKey(name: 'google_id')
  final String? googleId;
  @JsonKey(name: 'profile_pictures')
  final List<String> profilePictures;
  @JsonKey(name: 'cover_pictures')
  final List<String> coverPictures;
  final String? bio;
  @JsonKey(name: 'following_ids')
  final List<String> followingIds;
  @JsonKey(name: 'follower_ids')
  final List<String> followerIds;
  final List<String> roles;
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @JsonKey(name: 'donations_received_amount')
  final int donationsReceivedAmount;
  @JsonKey(name: 'donations_sent_amount')
  final int donationsSentAmount;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'last_active')
  final DateTime? lastActive;
  @JsonKey(name: 'followed_reading_list_ids')
  final List<String> followedReadingListIds;
  @JsonKey(name: 'oauth_providers')
  final List<dynamic>
      oauthProviders; // Changed from List<String> to List<dynamic>
  @JsonKey(name: 'profile_picture')
  final String profilePicture;
  @JsonKey(name: 'cover_picture')
  final String coverPicture;

  AuthData({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.firebaseUid,
    required this.dob,
    required this.firstName,
    required this.lastName,
    this.facebookId,
    this.googleId,
    required this.profilePictures,
    required this.coverPictures,
    this.bio,
    required this.followingIds,
    required this.followerIds,
    required this.roles,
    required this.isVerified,
    required this.donationsReceivedAmount,
    required this.donationsSentAmount,
    required this.createdAt,
    required this.updatedAt,
    this.lastActive,
    required this.followedReadingListIds,
    required this.oauthProviders,
    required this.profilePicture,
    required this.coverPicture,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}
