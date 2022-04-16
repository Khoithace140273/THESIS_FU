abstract class RegisterView {
  //update view
  void updateViewStatusValidation();
  void updateLoading();
  void updateProvince();
  void updateDistrict();
  void updateCWT();
  //event
  void onClickRegister(String username, String password, DateTime dayOfBirth, String identityCard, String email, String phoneNumber, int gender, String location, int cwtId, String fullname);
  void onChangeInput();
}
