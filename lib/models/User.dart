import 'dart:collection';

class AbstractUser {
  String id,
      email,
      fullName,
      gender,
      bio,
      username,
      profilePhotoUrl,
      instagramUsername,
      youtubeUsername;
  DateTime dateOfBirth, dateJoined;
  int numberOfFollowers, numberOfFollowing, numberOfLikes;
  List<dynamic> followingUIDs = [];
  List<dynamic> followerUIDs = [];

  AbstractUser({this.id,
    this.email,
    this.fullName,
    this.gender,
    this.bio,
    this.username,
    this.dateOfBirth,
    this.profilePhotoUrl = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    this.dateJoined,
    this.numberOfFollowers = 0,
    this.numberOfFollowing = 0,
    this.numberOfLikes = 0,
    this.instagramUsername,
    this.youtubeUsername,
    this.followingUIDs,
    this.followerUIDs});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'email': email,
      'fullName': fullName,
      'gender': gender,
      'bio': bio,
      'username': username,
      'dateofBirth': dateOfBirth,
      'dateJoined': dateJoined,
      'profilePhotoUrl': profilePhotoUrl,
      'numberOfFollowers': numberOfFollowers,
      'numberOfFollowing': numberOfFollowing,
      'numberOfLikes': numberOfLikes,
      'instagramUsername': instagramUsername,
      'youtubeUsername': youtubeUsername,
      'followerUIDs': followerUIDs,
      'followingUIDs': followingUIDs
    };
    return map;
  }

  AbstractUser fromJson(Map<String, dynamic> data) {
    return AbstractUser(
        id: data['id'],
        email: data['email'],
        fullName: data['fullName'],
        gender: data['gender'],
        bio: data['bio'],
        username: data['username'],
        dateOfBirth:
        data['dateofBirth'] == null ? null : data['dateofBirth'].toDate(),
        profilePhotoUrl: data['profilePhotoUrl'],
        numberOfFollowers: data['followerUIDs'] != null ? data['followerUIDs'].length : 0 ,
        numberOfFollowing: data['followingUIDs'] != null ? data['followingUIDs'].length : 0  ,
        numberOfLikes: data['numberOfLikes'],
        instagramUsername: data['instagramUsername'],
        youtubeUsername: data['youtubeUsername'],
        followerUIDs: data['followerUIDs'],
        followingUIDs: data['followingUIDs'],
        dateJoined:
        data['dateJoined'] == null ? null : data['dateJoined'].toDate());
  }
}
