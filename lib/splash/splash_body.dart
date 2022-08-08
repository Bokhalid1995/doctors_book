import 'package:doctors_book/views/admin/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/views/main_screen.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animeCont;
  Animation<double>? anime;
  var isVisisble = false;

  @override
  void initState() {
    super.initState();
    animeCont = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600));
    anime = Tween<double>(begin: .2, end: 1).animate(animeCont!);
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
      children: [
        const Spacer(),
        // Image.asset('assets/images/pic_3.png',height: 200.0,width: 200.0),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 170,
          height: 170,
          child: Lottie.asset('assets/images/about_hospital.json'),
        ),
        const SizedBox(
          height: 20,
        ),
        FadeTransition(
          opacity: anime!,
          child: const Center(
            child: Text(
              'احجز طبيبك',
              style: TextStyle(
                  color: Colors.white, fontSize: 28.0, letterSpacing: 0.0),
            ),
          ),
        ),

        const Spacer(),
        Visibility(
          visible: isVisisble,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const MainScreen()));
                },
                child: Container(
                  width: SizeConfig.screenWidth! / 1.2,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     offset: Offset(0, 0),
                    //     blurRadius: 5,
                    //     color: PColor,
                    //   )
                    // ],
                  ),
                  child: const Text(
                    'ابدأ الان',
                    style: TextStyle(
                      color: PColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const AdminDashboard()));
                },
                child: Container(
                  width: SizeConfig.screenWidth! / 1.2,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     offset: Offset(0, 0),
                    //     blurRadius: 5,
                    //     color: PColor,
                    //   )
                    // ],
                  ),
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      color: PColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void goToNextView() {
    Future.delayed(const Duration(seconds: 7), () {
      setState(() {
        isVisisble = true;
      });
    });
  }
}
