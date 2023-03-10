import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../constants/common_size.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(microseconds: 300);

class _AuthPageState extends State<AuthPage> {
  final inputBorder =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  TextEditingController _phoneNumberController =
      TextEditingController(text: "010");

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constranints) {
      Size size = MediaQuery.of(context).size;

      return IgnorePointer(
        ignoring: _verificationStatus == VerificationStatus.verifying,
        child: Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text('전화번호 로그인'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(common_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      ExtendedImage.asset(
                        'assets/imgs/padlock.png',
                        width: size.width * 0.15,
                        height: size.width * 0.15,
                      ),
                      SizedBox(
                        width: common_small_padding,
                      ),
                      Text('''토마토마켓은 휴대폰 번호로 가입해요.
번호는 안전하게 보관 되며
어디에도 공개되지 않아요.''')
                    ],
                  ),
                  SizedBox(
                    height: common_padding,
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [MaskedInputFormatter("000 0000 0000")],
                    decoration: InputDecoration(
                      focusedBorder: inputBorder,
                      border: inputBorder,
                    ),
                    validator: (phoneNumber) {
                      if (phoneNumber != null && phoneNumber.length == 13) {
                        return null;
                      } else {
                        return '전화번호를 잘못 입력하였습니다.';
                      }
                    },
                  ),
                  SizedBox(
                    height: common_small_padding,
                  ),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          bool passed = _formKey.currentState!.validate();
                          if (passed)
                            setState(() {
                              _verificationStatus = VerificationStatus.codeSent;
                            });
                        }
                      },
                      child: Text('인증문자 발송')),
                  SizedBox(
                    height: common_padding,
                  ),
                  AnimatedOpacity(
                    curve: Curves.easeInOut,
                    duration: duration,
                    opacity: (_verificationStatus == VerificationStatus.none)
                        ? 0
                        : 1,
                    child: AnimatedContainer(
                      curve: Curves.easeInOut,
                      height: getVerificationHeight(_verificationStatus),
                      duration: duration,
                      child: TextFormField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [MaskedInputFormatter("000000")],
                        decoration: InputDecoration(
                          focusedBorder: inputBorder,
                          border: inputBorder,
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                      curve: Curves.easeInOut,
                      height: getVerificationButtonHeight(_verificationStatus),
                      duration: duration,
                      child: TextButton(
                          onPressed: () {
                            attemptVerify();
                          },
                          child: (_verificationStatus ==
                                  VerificationStatus.verifying
                              ? CircularProgressIndicator(color: Colors.white,)
                              : Text('인증')))),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  double getVerificationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        // TODO: Handle this case.
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 60 + common_small_padding;
    }
  }

  double getVerificationButtonHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        // TODO: Handle this case.
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 48;
    }
  }

  void attemptVerify() async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });
    await Future.delayed(Duration(seconds: 3));

    setState(() {

      _verificationStatus = VerificationStatus.verificationDone;
    });
  }
}

enum VerificationStatus { none, codeSent, verifying, verificationDone }
