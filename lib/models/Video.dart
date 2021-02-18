import 'package:video_player/video_player.dart';

class Video {
  String url,
      caption,
      imageFileName,
      documentID,
      authorUID,
      authorEmail,
      authorProfilePictureUrl,
      authorName;
  DateTime datePosted;
  int numberOfLikes;
  List<dynamic> followingUIDs = [];

  Video(
      {this.url,
      this.caption,
      this.datePosted,
      this.imageFileName,
      this.documentID,
      this.authorEmail,
      this.authorUID,
      this.numberOfLikes = 0,
      this.authorProfilePictureUrl,
      this.authorName,
      this.followingUIDs});

  VideoPlayerController controller;

  Video fromJson(Map map, {documentID}) {
    return Video(
        documentID: documentID != null ? documentID : map['documentID'],
        imageFileName: map['imageFileName'],
        authorUID: map['authorUID'],
        authorEmail: map['authorEmail'],
        caption: map['caption'],
        url: map['url'],
        followingUIDs: map['followingUIDs'],
        numberOfLikes: (map['numberOfLikes']),
        authorProfilePictureUrl: (map['authorProfilePictureUrl']),
        authorName: (map['authorName']),
        datePosted: map['datePosted'].toDate());
  }

  Map<String, dynamic> toJson({String docID}) {
    return {
      'url': url,
      'caption': caption,
      'imageFileName': imageFileName,
      'authorUID': authorUID,
      'authorEmail': authorEmail,
      'datePosted': datePosted,
      'numberOfLikes': numberOfLikes,
      'documentID': docID,
      'authorProfilePictureUrl': authorProfilePictureUrl,
      'authorName': authorName,
      'followingUIDs': followingUIDs,
    };
  }
}
