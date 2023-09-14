import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';

class OtpTimer extends StatefulWidget {
  final VoidCallback onTimeComplete;
  final int duration;
  final String otpType;
  const OtpTimer({Key? key,required this.onTimeComplete,required this.otpType,this.duration = 12}) : super(key: key);

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {

  Timer? _timer;
  int _counter = 0;
  bool isTimeEnd = false;

  @override
  void initState() {
    super.initState();
    _counter = widget.duration;
    _startTimer();
  }




  _startTimer(){
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter == 0) {
       widget.onTimeComplete();
       isTimeEnd = true;
      } else {
        setState(() {
          _counter--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.12),
          child: Text(widget.otpType=='email'?MyStrings.sixDigitEmailOtpMsg.tr:MyStrings.sixDigitSMSOtpMsg.tr, maxLines: 2, textAlign: TextAlign.center,style: interRegularDefault.copyWith(fontWeight:FontWeight.w600,fontSize:Dimensions.fontLarge,color: MyColor.getGreyText1())),
        ),
        const SizedBox(height: Dimensions.space20),
        isTimeEnd?const Text(''):Text(MyStrings.otpExpiredMsg.tr, maxLines: 2, textAlign: TextAlign.center,style: interRegularDefault.copyWith(color: MyColor.redCancelTextColor)),
        const SizedBox(height: Dimensions.space20),
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: _counter/widget.duration,
                backgroundColor: MyColor.redCancelTextColor,
                strokeWidth: 8,
                valueColor: const AlwaysStoppedAnimation(MyColor.primaryColor900),
              ),
              Center(
                child: Text('${_counter.toString()}\n${MyStrings.sec.tr}',textAlign:TextAlign.center,style: interSemiBoldSmall.copyWith(color: Colors.black,fontSize: Dimensions.fontOverLarge),),
              )
            ],
          ),
        ),
        const SizedBox(height: Dimensions.space25),
      ],
    );
  }
}
