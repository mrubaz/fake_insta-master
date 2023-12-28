class InstagramModel {
  String? username,
      location,
      caption,
      likedby,
      faketime,
      customUID,
      customComment;
  bool? verifyUser;
  String? pickedProfile, pickedPost;
  double? num, comments;

  InstagramModel({
    this.username,
    this.location,
    this.caption,
    this.likedby,
    this.faketime,
    this.comments,
    this.customUID,
    this.customComment,
    this.verifyUser,
    this.pickedProfile,
    this.pickedPost,
    this.num,
  });

  static InstagramModel empty() => InstagramModel(
        username: '',
        num: 0,
        location: '',
        caption: '',
        likedby: '',
        faketime: '',
        comments: 0,
        customUID: '',
        customComment: '',
        pickedPost: '',
        pickedProfile: '',
        verifyUser: false,
      );
}
