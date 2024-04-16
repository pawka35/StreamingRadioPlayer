import 'package:final_project/generated/l10n.dart';
import 'package:final_project/screens/auth/blocs/auth/auth_bloc.dart';
import 'package:final_project/screens/auth/blocs/login/login_bloc.dart';
import 'package:final_project/theme/theme.dart';
import 'package:final_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              switch (state) {
                case LoginInitialState _:
                  return const _PhoneEnterWidget();
                case LoginNeedEnterOtpState _:
                  return _EnterOtpWidget();
                case LoginOtpErrorState _:
                  return _EnterOtpWidget(otpError: state.message);
                case LoginOtpSuccessState _:
                  context.read<AuthBloc>().add(AuthDoneEvent(state.user));
                default:
                  return const CircularProgressIndicator();
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class _TextInputFormWidget extends StatelessWidget {
  const _TextInputFormWidget({
    required this.ratio,
    required this.inputController,
    required this.hintText,
  });
  final ({double h, double w}) ratio;
  final TextEditingController inputController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53 * ratio.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: UIColors.red,
            blurRadius: 10,
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: inputController,
        style: Typogaphy.s16w500cWhite,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              left: 35 * ratio.w, top: 17 * ratio.h, bottom: 17 * ratio.h),
          hintText: hintText,
          hintStyle: Typogaphy.s16w300cBlack50,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: UIColors.red),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: UIColors.red,
  ));
}

class _PhoneEnterWidget extends StatefulWidget {
  const _PhoneEnterWidget({super.key});

  @override
  State<_PhoneEnterWidget> createState() => _PhoneEnterWidgetState();
}

class _PhoneEnterWidgetState extends State<_PhoneEnterWidget> {
  final TextEditingController _phoneContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loginBloc = context.read<LoginBloc>();
    var ratio = getRatioOfSizes(context);

    return Padding(
      padding: EdgeInsets.only(left: 43 * ratio.w),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              top: 104 * ratio.h,
              child: Image.asset('assets/images/triangle.png')),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 191 * ratio.h),
              Image.asset('assets/images/player_logo.png'),
              SizedBox(height: 34 * ratio.h),
              Text(
                S.of(context).signUp,
                style: Typogaphy.s50w400cWhite,
              ),
              Text(
                S.of(context).toStartPlay,
                style: Typogaphy.s25w400cWhite,
              ),
              SizedBox(height: 50 * ratio.h),
              Text(
                S.of(context).phoneNumber,
                style: Typogaphy.s16w500cWhite,
              ),
              SizedBox(height: 17 * ratio.h),
              Padding(
                padding: EdgeInsets.only(right: 33 * ratio.w),
                child: _TextInputFormWidget(
                  ratio: ratio,
                  inputController: _phoneContoller,
                  hintText: S.of(context).yourPhoneNumber,
                ),
              ),
              SizedBox(height: 75 * ratio.h),
              GestureDetector(
                onTap: () {
                  if (_phoneContoller.text.length == 11) {
                    loginBloc.add(LoginGetOtpSendEvent(_phoneContoller.text));
                  } else {
                    _showSnackBar(context, S.of(context).invalidPhoneNumber);
                  }
                },
                child: Container(
                  width: 153 * ratio.w,
                  height: 62 * ratio.h,
                  color: const Color(0xFF05D8E8),
                  child: Center(
                    child: Image.asset('assets/images/arrow_right.png'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EnterOtpWidget extends StatelessWidget {
  _EnterOtpWidget({this.otpError});
  final TextEditingController _otpContoller = TextEditingController();
  final String? otpError;
  @override
  Widget build(BuildContext context) {
    var loginBloc = context.read<LoginBloc>();
    var ratio = getRatioOfSizes(context);
    return Padding(
      padding: EdgeInsets.only(left: 43 * ratio.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 191 * ratio.h),
          Text(
            'Otp code',
            style: Typogaphy.s16w500cWhite,
          ),
          SizedBox(height: 17 * ratio.h),
          Padding(
            padding: EdgeInsets.only(right: 33 * ratio.w),
            child: _TextInputFormWidget(
              ratio: ratio,
              inputController: _otpContoller,
              hintText: S.of(context).enter6DigitOtp,
            ),
          ),
          SizedBox(height: 25 * ratio.h),
          otpError != null
              ? Center(child: Text(otpError!, style: Typogaphy.s20w500cRed))
              : SizedBox.shrink(),
          SizedBox(height: 50 * ratio.h),
          GestureDetector(
            onTap: () {
              if (_otpContoller.text.length == 6) {
                loginBloc.add(LoginOtpEnteredEvent(_otpContoller.text));
              } else {
                _showSnackBar(context, S.of(context).invalidOtp);
              }
            },
            child: Container(
              width: 153 * ratio.w,
              height: 62 * ratio.h,
              color: const Color(0xFF05D8E8),
              child: Center(
                child: Image.asset('assets/images/arrow_right.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
