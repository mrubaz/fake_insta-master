class FacebookModel {
  String? username, location, caption, faketime, friendname;
  bool? verifyUser, story;
  String? pickedfbProfile, pickedfbPost;
  double? fblike, fbcomments;
  FacebookModel({
    this.username,
    this.caption,
    this.faketime,
    this.pickedfbProfile,
    this.pickedfbPost,
    this.verifyUser,
    this.fblike,
    this.fbcomments,
    this.location,
    this.story,
    this.friendname,
  });

  static FacebookModel empty() => FacebookModel(
        username: '',
        caption: '',
        faketime: '',
        pickedfbProfile: '',
        pickedfbPost: '',
        verifyUser: false,
        fblike: 0,
        fbcomments: 0,
        location: '',
        story: false,
        friendname: '',
      );
}
