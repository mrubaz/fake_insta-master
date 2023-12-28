class SettingsModel {
  String? pickedProfile;
  String? username;
  String? location;

  SettingsModel({this.pickedProfile, this.location, this.username});

  static SettingsModel empty() => SettingsModel(
        pickedProfile: '',
        username: '',
        location: '',
      );
}
