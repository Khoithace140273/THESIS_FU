import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:toss/Model/edit_user_profile_model.dart';
import 'package:toss/Presenter/edit_user_profile_presenter.dart';
import 'package:toss/View/edit_user_profile_view.dart';

import '../../Constants/global.dart';
import '../../Features/button_decoration.dart';
import '../../Features/color.dart';
import '../../Features/textbox_decoration.dart';
import '../../Model/Entity/cwt_model.dart';
import '../../Model/Entity/district_model.dart';
import '../../Model/Entity/province_model.dart';

class BodyEditUserProfile extends StatefulWidget {
  const BodyEditUserProfile({Key? key}) : super(key: key);

  @override
  State<BodyEditUserProfile> createState() => _BodyEditUserProfileState();
}

class _BodyEditUserProfileState extends State<BodyEditUserProfile> implements EditUserProfileView{
  late EditUserProfilePresenter editUserProfilePresenter;
  late EditUserProfileModel _model;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _identityController = TextEditingController();
  final _locationController = TextEditingController();

  String get _name => _nameController.text;

  String get _email => _emailController.text;

  String get _phone => _phoneController.text;

  String get _identity => _identityController.text;

  String get _location => _locationController.text;

  final String? _setName = Global.user?.fullname;
  final String? _setEmail = Global.user?.email;
  final String? _setPhone = Global.user?.phoneNumber;
  final String? _setIdentity = Global.user?.identityCard;
  final String? _setLocation = Global.user?.location;



  final _focusNodesName = FocusNode();
  final _focusNodesGender = FocusNode();
  final _focusNodesEmail = FocusNode();
  final _focusNodesPhone = FocusNode();
  final _focusNodesIdentity = FocusNode();
  final _focusNodesLocation = FocusNode();

  final List<DropdownMenuItem<String>> _valueGenderList = ['Nam', 'Nữ'].map((gender) {
    return DropdownMenuItem(
      child: Text(gender),
      value: gender,
    );
  }).toList();
  List<DropdownMenuItem<ProvinceModel>> _valueProvinceList =
  List<DropdownMenuItem<ProvinceModel>>.empty();
  List<DropdownMenuItem<DistrictModel>> _valueDistrictList =
  List<DropdownMenuItem<DistrictModel>>.empty();
  List<DropdownMenuItem<CWTModel>> _valueCWTList =
  List<DropdownMenuItem<CWTModel>>.empty();

  late String _valueGender = _valueGenderList[0].value.toString();
  DateTime _dOB = DateTime.now();

  final ProvinceModel _emptyProvince = ProvinceModel.empty();
  late ProvinceModel _valueProvince = ProvinceModel.empty();
  final DistrictModel _emptyDistrict = DistrictModel.empty();
  late DistrictModel _valueDistrict = DistrictModel.empty();
  final CWTModel _emptyCWT = CWTModel.empty();
  late CWTModel _valueCWT = CWTModel.empty();

  @override
  void initState() {
    super.initState();
    editUserProfilePresenter = EditUserProfilePresenter();
    editUserProfilePresenter.setView(this);
    _model = editUserProfilePresenter.model;

    loadAllData();

    _nameController.text = _setName!;
    _emailController.text = _setEmail!;
    _phoneController.text = _setPhone!;
    _identityController.text = _setIdentity!;
    _locationController.text = _setLocation!;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Center(
        child: SingleChildScrollView(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: TextFormField(

                      focusNode: _focusNodesName,
                      controller: _nameController,
                      decoration: buildInputDecoration(
                          Icons.person,
                          'Họ và tên',
                          _focusNodesName.hasFocus
                              ? ThemeColor()
                              : IconColorUnFocus(),
                          'Họ và tên'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Vui lòng điền đầy đủ thông tin';
                        } else if (val.length < 2) {
                          return 'Họ và tên phải gồm 2 ký tự trở lên';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        //username = val!;
                      },
                    ),
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            elevation: 10,
                            style: TextStyle(color: ThemeColor()),
                            onChanged: (String? selectedGender) {
                              setState(() {
                                _valueGender = selectedGender!;
                              });
                            },
                            items: _valueGenderList,
                            value: _valueGender,
                            decoration: buildInputDecoration(
                                _valueGender == 'Nam'
                                    ? Icons.male
                                    : Icons.female,
                                _valueGender,
                                _focusNodesGender.hasFocus
                                    ? ThemeColor()
                                    : IconColorUnFocus(),
                                'Giới tính'),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 1, 1),
                                  maxTime: DateTime.now(),
                                  onChanged: (date) {}, onConfirm: (date) {
                                    setState(() {
                                      _dOB = date;
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: BackgroundTextFormField(),
                              padding: EdgeInsets.all(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cake,
                                  color: IconColorUnFocus(),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(_dOB),
                                  style: TextStyle(
                                      fontSize: 16, color: ThemeColor()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: TextFormField(
                      focusNode: _focusNodesEmail,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: buildInputDecoration(
                          Icons.email,
                          'Email',
                          _focusNodesEmail.hasFocus
                              ? ThemeColor()
                              : IconColorUnFocus(),
                          'Email'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Vui lòng điền đầy đủ thông tin';
                        } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                            .hasMatch(val)) {
                          return 'Vui lòng điền đúng địa chỉ email';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        //username = val!;
                      },
                    ),
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: TextFormField(
                      focusNode: _focusNodesPhone,
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      decoration: buildInputDecoration(
                          Icons.phone,
                          'Số điện thoại',
                          _focusNodesPhone.hasFocus
                              ? ThemeColor()
                              : IconColorUnFocus(),
                          'Số điện thoại'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Vui lòng điền đầy đủ thông tin';
                        } else if (val.length > 12) {
                          return 'Số Điện Thoại phải nhập bé hơn 12 ký tự';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        //username = val!;
                      },
                    ),
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: TextFormField(
                      enabled: false,
                      focusNode: _focusNodesIdentity,
                      keyboardType: TextInputType.number,
                      controller: _identityController,
                      decoration: buildInputDecoration(
                          Icons.account_box_rounded,
                          'Căn cước công dân/Chứng minh thư',
                          _focusNodesIdentity.hasFocus
                              ? ThemeColor()
                              : IconColorUnFocus(),
                          'Căn cước công dân/Chứng minh thư'),
                    ),
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: DropdownButtonFormField<ProvinceModel>(
                      elevation: 10,
                      style: TextStyle(color: ThemeColor()),
                      isDense: true,
                      menuMaxHeight: 300,
                      dropdownColor: MenuDropDownColor(),
                      items: _valueProvinceList.isNotEmpty
                          ? _valueProvinceList
                          : null,
                      value: _valueProvince != _emptyProvince ||
                          _valueProvinceList.isNotEmpty
                          ? _valueProvince
                          : null,
                      onChanged: (ProvinceModel? selectedProvince) {
                        if (selectedProvince != _valueProvince) {
                          _valueProvince = selectedProvince!;
                          provinceChanged();
                        }
                      },
                      decoration: buildInputDecoration(
                          Icons.location_city,
                          _valueProvince.name!,
                          // _focusNodesCity.hasFocus
                          //     ? ThemeColor():
                          IconColorUnFocus(),
                          'Tỉnh/Thành phố'),
                    ),
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: DropdownButtonFormField<DistrictModel>(
                      elevation: 10,
                      style: TextStyle(color: ThemeColor()),
                      menuMaxHeight: 300,
                      items: _model.districtList.isNotEmpty
                          ? _valueDistrictList
                          : null,
                      value: _valueDistrict != _emptyDistrict ||
                          _valueDistrictList.isNotEmpty
                          ? _valueDistrict
                          : null,
                      onChanged: (DistrictModel? selectedDistrict) {
                        if (selectedDistrict != _valueDistrict) {
                          _valueDistrict = selectedDistrict!;
                          updateCWT();
                        }
                      },
                      decoration: buildInputDecoration(
                          Icons.location_city,
                          _valueDistrict.name!,
                          // _focusNodesCity.hasFocus
                          //     ? ThemeColor():
                          IconColorUnFocus(),
                          'Quận/Huyện'),
                    ),
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: DropdownButtonFormField<CWTModel>(
                      elevation: 10,
                      style: TextStyle(color: ThemeColor()),
                      menuMaxHeight: 300,
                      items: _valueCWTList.isNotEmpty ? _valueCWTList : null,
                      value: _valueCWT != _emptyCWT || _valueCWTList.isNotEmpty
                          ? _valueCWT
                          : null,
                      onChanged: (CWTModel? selectedCWT) {
                        setState(() {
                          if (selectedCWT != _valueCWT) {
                            _valueCWT = selectedCWT!;
                          }
                        });
                      },
                      decoration: buildInputDecoration(
                          Icons.location_city,
                          _valueCWT.name!,
                          // _focusNodesCity.hasFocus
                          //     ? ThemeColor():
                          IconColorUnFocus(),
                          'Phường/Xã/Thị Trấn'),
                    ),
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: TextFormField(
                      focusNode: _focusNodesLocation,
                      keyboardType: TextInputType.text,
                      controller: _locationController,
                      decoration: buildInputDecoration(
                          Icons.location_on_rounded,
                          'Số nhà, (toà nhà, số tầng), tên đường',
                          _focusNodesLocation.hasFocus
                              ? ThemeColor()
                              : IconColorUnFocus(),
                          'Số nhà, (toà nhà, số tầng), tên đường'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Vui lòng điền đầy đủ thông tin';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        //username = val!;
                      },
                    ),
                  ),
                  Container(
                    padding: buildItemsOnScreenPadding(),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onClickEditProfile(
                              _dOB,
                              _identity,
                              _email,
                              _phone,
                              _valueGender == 'Nam' ? 1 : 0,
                              _location,
                              _valueCWT.cwtId!,
                              _name);
                        }
                      },
                      style: buttonStyleDecoration(),
                      child: textInButton('Lưu'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onChangeInput() {
    // TODO: implement onChangeInput
  }

  @override
  void onClickEditProfile(DateTime dayOfBirth, String identityCard, String email, String phoneNumber, int gender, String location, int cwtId, String fullname) {
    // TODO: implement onClickEditProfile
  }

  @override
  Future<void> updateCWT() async {
    try {
      if (_valueDistrict != _emptyDistrict) {
        _model.cwtList = await editUserProfilePresenter
            .handleCWTGettingByDistrictId(_valueDistrict.districtId.toString());
        _valueCWTList = _model.cwtList
            .map((cwt) => DropdownMenuItem<CWTModel>(
          child: Text(cwt.name!),
          value: cwt,
        ))
            .toList();
        if (_model.cwtList.isNotEmpty) {
          if (_model.cwtList.first != _valueCWT) {
            _valueCWT = _model.cwtList.first;
          }
        }
      }
      Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw Exception('Không thể lấy thông tin Phường/Xã/Thị trấn 1');
    }
  }

  @override
  Future<void> updateDistrict() async {
    try {
      if (_valueProvince != _emptyProvince) {
        _model.districtList =
            await editUserProfilePresenter.handleDistrictGettingByProvinceId(
            _valueProvince.provinceId.toString());
        _valueDistrictList = _model.districtList
            .map((d) => DropdownMenuItem<DistrictModel>(
          child: Text(d.name!),
          value: d,
        ))
            .toList();
        if (_model.districtList.isNotEmpty) {
          if (_model.districtList.first != _valueDistrict) {
            _valueDistrict = _model.districtList.first;
          }
        }
      }
      Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw Exception('Không thể lấy thông tin Quận/Huyện 1');
    }
  }

  @override
  void updateLoading() {
    // TODO: implement updateLoading
  }

  @override
  Future<void> updateProvince() async {
    try {
      _model.provinceList = await editUserProfilePresenter.handleProvinceGetting();
      _valueProvinceList = _model.provinceList.isNotEmpty
          ? _model.provinceList
          .map((p) => DropdownMenuItem<ProvinceModel>(
        child: Text(p.name!),
        value: p,
      ))
          .toList()
          : List<DropdownMenuItem<ProvinceModel>>.empty();
      if (_model.provinceList.isNotEmpty) {
        if (_model.provinceList.first != _valueProvince) {
          _valueProvince = _model.provinceList.first;
        }
      }
      Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw Exception('Không thể lấy Tỉnh/Thành phố 1');
    }
  }

  loadAllData() async {
    await updateProvince();
    await updateDistrict();
    await updateCWT();
  }

  provinceChanged() async {
    await updateDistrict();
    await updateCWT();
  }

  @override
  void updateViewStatusValidation() {
    // TODO: implement updateViewStatusValidation
  }
}
