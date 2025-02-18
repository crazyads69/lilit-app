// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      firebaseUid: json['firebase_uid'] as String,
      dob: json['dob'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      facebookId: json['facebook_id'] as String?,
      googleId: json['google_id'] as String?,
      profilePictures: (json['profile_pictures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      coverPictures: (json['cover_pictures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      bio: json['bio'] as String?,
      followingIds: (json['following_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      followerIds: (json['follower_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      isVerified: json['is_verified'] as bool,
      donationsReceivedAmount:
          (json['donations_received_amount'] as num).toInt(),
      donationsSentAmount: (json['donations_sent_amount'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      lastActive: json['last_active'] == null
          ? null
          : DateTime.parse(json['last_active'] as String),
      followedReadingListIds:
          (json['followed_reading_list_ids'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      oauthProviders: json['oauth_providers'] as List<dynamic>,
      profilePicture: json['profile_picture'] as String,
      coverPicture: json['cover_picture'] as String,
    );

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'firebase_uid': instance.firebaseUid,
      'dob': instance.dob,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'facebook_id': instance.facebookId,
      'google_id': instance.googleId,
      'profile_pictures': instance.profilePictures,
      'cover_pictures': instance.coverPictures,
      'bio': instance.bio,
      'following_ids': instance.followingIds,
      'follower_ids': instance.followerIds,
      'roles': instance.roles,
      'is_verified': instance.isVerified,
      'donations_received_amount': instance.donationsReceivedAmount,
      'donations_sent_amount': instance.donationsSentAmount,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'last_active': instance.lastActive?.toIso8601String(),
      'followed_reading_list_ids': instance.followedReadingListIds,
      'oauth_providers': instance.oauthProviders,
      'profile_picture': instance.profilePicture,
      'cover_picture': instance.coverPicture,
    };
