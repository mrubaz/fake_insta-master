class TiktokModel {
  String? username, caption, faketime;
  bool? verifyUser, yourMusic;
  String? pickedProfile, pickedPost;
  double? commentCount, savedCount, likedCount;

  TiktokModel({
    this.username,
    this.caption,
    this.faketime,
    this.verifyUser,
    this.yourMusic,
    this.pickedProfile,
    this.pickedPost,
    this.commentCount,
    this.savedCount,
    this.likedCount,
  });

  static TiktokModel empty() => TiktokModel(
        username: '',
        caption: '',
        faketime: '',
        verifyUser: false,
        yourMusic: false,
        pickedProfile: '',
        pickedPost: '',
        commentCount: 0,
        savedCount: 0,
        likedCount: 0,
      );
}
