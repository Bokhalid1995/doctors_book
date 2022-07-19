import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/views/main_screen.dart';


class SplashBody extends StatefulWidget  {
  const SplashBody({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashBodyState createState() => _SplashBodyState();

}
class _SplashBodyState extends State<SplashBody> with SingleTickerProviderStateMixin{
  AnimationController? animeCont;
  Animation<double>? anime;

  @override
  void initState() {
   
    super.initState();
    animeCont =  AnimationController(vsync: this ,duration: const Duration(milliseconds: 1600));
    anime = Tween<double>(begin: .2,end: 1).animate(animeCont!);
    animeCont?.repeat(reverse: true);

    goToNextView();
  }
  @override
  void dispose() {
    animeCont!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [

        const Spacer(),
       // Image.asset('assets/images/pic_3.png',height: 200.0,width: 200.0),
       const SizedBox(height: 10,),
        SizedBox(width: 170 , height: 170,child: Lottie.asset('assets/images/about_hospital.json'),),
        FadeTransition(
          opacity: anime! ,
          child:  const Center(
            child:  Text('احجز طبيبك'
              ,style: TextStyle(color: Colors.white ,fontSize: 15.0,letterSpacing: 0.0),
            ),
          ),
        ),

        const Spacer(),
        Container(
          width: SizeConfig.screenWidth!,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: const Text(
            'POWERED BY : BOKHALID2622012@GMAIL.COM',
            style:  TextStyle(
              color: PColor,
            ),
          ),
        ),
      ],
    );
  }

  void goToNextView() {
    Future.delayed(const Duration(seconds: 7) , () {
      Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
           builder: (BuildContext context) => const MainScreen()));

    });
  }


}
