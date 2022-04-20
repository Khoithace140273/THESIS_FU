import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Model/Entity/cwt_model.dart';
import '/Model/Entity/district_model.dart';
import '/Model/Entity/province_model.dart';
import '/Model/register_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '/Page/login_page.dart';
import '/Presenter/register_presenter.dart';
import '/View/register_view.dart';
import '/Features/color.dart';
import '/Features/display_toast.dart';
import '/Features/button_decoration.dart';
import '/Features/textbox_decoration.dart';
import 'package:intl/intl.dart';
import '/Model/Entity/register_user_model.dart';

class BodyRegister extends StatefulWidget {
  const BodyRegister({Key? key}) : super(key: key);

  @override
  _BodyRegisterState createState() => _BodyRegisterState();
}

class _BodyRegisterState extends State<BodyRegister> implements RegisterView {
  late RegisterPresenter registerPresenter;
  late RegisterModel _model;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _identityController = TextEditingController();
  final _locationController = TextEditingController();

  String get _username => _usernameController.text;

  String get _password => _passwordController.text;

  String get _confirmPassword => _passwordConfirmController.text;

  String get _name => _nameController.text;

  String get _email => _emailController.text;

  String get _phone => _phoneController.text;

  String get _identity => _identityController.text;

  String get _location => _locationController.text;

  final _focusNodesUserName = FocusNode();
  final _focusNodesPassword = FocusNode();
  final _focusNodesConfirmPassword = FocusNode();
  final _focusNodesName = FocusNode();
  final _focusNodesGender = FocusNode();
  final _focusNodesEmail = FocusNode();
  final _focusNodesPhone = FocusNode();
  final _focusNodesIdentity = FocusNode();
  final _focusNodesLocation = FocusNode();
  final List<FocusNode> _focusNodesVerifyList =
      List<FocusNode>.filled(6, FocusNode());

  // late FocusNode _focusNodesCity;

  bool _isObscure = true;
  bool _isObscureConfirm = true;
  bool _isVerifyVisibility = false;

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
    registerPresenter = RegisterPresenter();
    registerPresenter.setView(this);
    _model = registerPresenter.model;

    _model.provinceList = List<ProvinceModel>.empty();
    _model.districtList = List<DistrictModel>.empty();
    _model.cwtList = List<CWTModel>.empty();

    _focusNodesUserName.addListener(() => setState(() {}));
    _focusNodesPassword.addListener(() => setState(() {}));
    _focusNodesConfirmPassword.addListener(() => setState(() {}));
    _focusNodesName.addListener(() => setState(() {}));
    _focusNodesGender.addListener(() => setState(() {}));
    _focusNodesEmail.addListener(() => setState(() {}));
    _focusNodesPhone.addListener(() => setState(() {}));
    _focusNodesIdentity.addListener(() => setState(() {}));
    _focusNodesLocation.addListener(() => setState(() {}));
    for (FocusNode f in _focusNodesVerifyList) {
      f.addListener(() => setState(() {}));
    }
    loadAllData();
  }

  @override
  void dispose() {
    _focusNodesUserName.dispose();
    _focusNodesPassword.dispose();
    _focusNodesConfirmPassword.dispose();
    _focusNodesName.dispose();
    _focusNodesEmail.dispose();
    _focusNodesPhone.dispose();
    _focusNodesIdentity.dispose();
    _focusNodesLocation.dispose();
    for (FocusNode f in _focusNodesVerifyList) {
      f.dispose();
    }
    super.dispose();
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
  void onChangeInput() {
    registerPresenter.handleOnChangeInput();
  }

  @override
  Future<void> onClickRegister(
      String username,
      String password,
      DateTime dBO,
      String identityCard,
      String email,
      String phoneNumber,
      int gender,
      String location,
      int cwtId,
      String fullname) async {
    _model.user = RegisterUserModel(
        username: username,
        password: password,
        dateofbirth: dBO,
        identityCard: identityCard,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
        location: location,
        cwtId: cwtId,
        fullname: fullname,
        photoUrl: '',
        lastActive: '',
        token: '');
    try {
      final result = await registerPresenter.handleRegister(_model.user);
      if (result) {
        DisplayToast.DisplaySuccessToast(context, 'Đăng ký thành công');
        Timer(const Duration(seconds: 3), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const LoginPage()));
        });
      } else {
        DisplayToast.DisplayErrorToast(context, 'Đăng ký thất bại');
      }
    } catch (e) {
      DisplayToast.DisplayErrorToast(context, 'Đăng ký thất bại');
    }
  }

  @override
  void updateLoading() {
    if (mounted) {
      setState(() {
        _model.isLoading = !_model.isLoading;
      });
    }
  }

  @override
  void updateViewStatusValidation() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  Container(
                    height: size.width * 0.3,
                    width: size.width * 0.3,
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/register_page_image.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: TextFormField(
                      focusNode: _focusNodesUserName,
                      controller: _usernameController,
                      decoration: buildInputDecoration(
                          Icons.person,
                          'Tên Đăng Nhập',
                          _focusNodesUserName.hasFocus
                              ? ThemeColor()
                              : IconColorUnFocus(),
                          'Tên Đăng Nhập'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Vui lòng điền đầy đủ thông tin';
                        } else if (val.length < 6) {
                          return 'Tên đăng nhập phải lớn hơn 6 ký tự';
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
                      focusNode: _focusNodesPassword,
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: buildInputDecoration(
                              Icons.lock,
                              'Mật khẩu',
                              _focusNodesPassword.hasFocus
                                  ? ThemeColor()
                                  : IconColorUnFocus(),
                              'Mật khẩu')
                          .copyWith(
                        suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _focusNodesPassword.hasFocus
                                  ? ThemeColor()
                                  : IconColorUnFocus(),
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                      ),
                      validator: (val) {
                        String errMs = '';
                        if (val!.isEmpty) {
                          return 'Vui lòng điền đầy đủ mật khẩu';
                        } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(val)) {
                          errMs.isEmpty? errMs+='':errMs+='\n';
                          errMs+='Mật khẩu cần ít nhất 1 chữ in hoa';
                        } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(val)) {
                          errMs.isEmpty? errMs+='':errMs+='\n';
                          errMs+= 'Mật khẩu cần ít nhất 1 chữ thường';
                        } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(val)) {
                          errMs.isEmpty? errMs+='':errMs+='\n';
                          errMs+= 'Mật khẩu cần ít nhất 1 chữ số';
                        } else if (!RegExp(r'^(?=.*?[!@#\$&*.~])')
                            .hasMatch(val)) {
                          errMs.isEmpty? errMs+='':errMs+='\n';
                          errMs+= 'Password contain at least 1 Special character';
                        } else if (!RegExp(r'^.{8,}').hasMatch(val)) {
                          errMs.isEmpty? errMs+='':errMs+='\n';
                          errMs+= 'Password contain at least 8 characters in length';
                        } else {
                        }
                        return errMs.isNotEmpty?errMs:null;
                      },
                      onSaved: (val) {
                        // password = val!;
                      },
                    ),
                    //Text Button
                  ),
                  Padding(
                    padding: buildItemsOnScreenPadding(),
                    child: TextFormField(
                      focusNode: _focusNodesConfirmPassword,
                      controller: _passwordConfirmController,
                      obscureText: _isObscureConfirm,
                      decoration: buildInputDecoration(
                              Icons.lock,
                              'Nhập lại',
                              _focusNodesConfirmPassword.hasFocus
                                  ? ThemeColor()
                                  : IconColorUnFocus(),
                              'Nhập lại')
                          .copyWith(
                        suffixIcon: IconButton(
                            icon: Icon(
                              _isObscureConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _focusNodesConfirmPassword.hasFocus
                                  ? ThemeColor()
                                  : IconColorUnFocus(),
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscureConfirm = !_isObscureConfirm;
                              });
                            }),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Vui lòng điền đầy đủ nhập lại mật khẩu';
                        } else if (_password !=
                            _confirmPassword) {
                          return "Password does not match";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
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
                      onChanged: (email) {
                        setState(() {
                          if (email.isNotEmpty) {
                            if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                                .hasMatch(email)) {
                              _isVerifyVisibility = true;
                            } else {
                              _isVerifyVisibility = false;
                            }
                          } else {
                            _isVerifyVisibility = false;
                          }
                        });
                      },
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
                  Visibility(
                    visible: _isVerifyVisibility,
                    child: Padding(
                      padding: buildItemsOnScreenPadding(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: buildVerifiedTextFormField(
                                      _focusNodesVerifyList[0]))),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: buildVerifiedTextFormField(
                                      _focusNodesVerifyList[1]))),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: buildVerifiedTextFormField(
                                      _focusNodesVerifyList[2]))),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: buildVerifiedTextFormField(
                                      _focusNodesVerifyList[3]))),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: buildVerifiedTextFormField(
                                      _focusNodesVerifyList[4]))),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: buildVerifiedTextFormField(
                                      _focusNodesVerifyList[5]))),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) => const LoginPage()));
                                  setState(() {
                                    //_isLoading = true;
                                  });
                                },
                                style: buttonStyleDecoration(),
                                child: const Text(
                                  'Xác Nhận',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Vui lòng điền đầy đủ thông tin';
                        } else if (val.length != 12) {
                          return 'Căn cước công dân/Chứng minh thư phải nhập bé hơn 12 ký tự\n'
                              'Nếu chứng minh thư không đủ 12 số,\nVui lòng nhập thêm các số 0 ở đầu';
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
                          onClickRegister(
                              _username,
                              _password,
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
                      child: textInButton('Đăng Ký'),
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

  TextFormField buildVerifiedTextFormField(FocusNode f) {
    return TextFormField(
        textAlign: TextAlign.center,
        style: buildVerifiedTextStyle(),
        focusNode: f,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1)
        ],
        decoration: buildVerifyInputDecoration(
          f.hasFocus ? ThemeColor() : IconColorUnFocus(),
        ));
  }

  onChangedGenderSelected(String selectedGender) {
    setState(() {
      _valueGender = selectedGender;
    });
  }

  @override
  Future<void> updateCWT() async {
    try {
      if (_valueDistrict != _emptyDistrict) {
        _model.cwtList = await registerPresenter
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
            await registerPresenter.handleDistrictGettingByProvinceId(
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
  Future<void> updateProvince() async {
    try {
      _model.provinceList = await registerPresenter.handleProvinceGetting();
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
}
