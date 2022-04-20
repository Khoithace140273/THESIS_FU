abstract class EditUserProfileView {
  //update view
  void updateViewStatusValidation();
  void updateLoading();
  void updateProvince();
  void updateDistrict();
  void updateCWT();
  //event
  void onClickEditProfile(DateTime dayOfBirth, String identityCard, String email, String phoneNumber, int gender, String location, int cwtId, String fullname);
  void onChangeInput();
}
