import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/shared/models/specialize.dart';
import 'package:doctors_book/shared/services_specialize.dart';
import 'package:doctors_book/views/Booking.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class StaffDetailsBody extends StatefulWidget {
  StaffDetailsBody(this.HospitalName, this.HospitalId, this.DoctorName,
      this.DoctorId, this.Specialize, this.Day, this.From, this.To,
      {Key? key});

  final String HospitalName;
  final int HospitalId;
  final String DoctorName;
  final int DoctorId;
  final String? Specialize;
  final String Day;
  final int From;
  final int To;

  final String imagePath = "assets/images/767676.jpg";

  @override
  State<StaffDetailsBody> createState() => _StaffDetailsBodyState();
}

class _StaffDetailsBodyState extends State<StaffDetailsBody> {
  bool toggleShow = false;
  double raduis = 17;
  @override
  Widget build(BuildContext context) {
    var fromFormat = widget.From < 12 ? 'ص' : 'م';
    var fromTo = widget.To < 12 ? 'ص' : 'م';
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggleShow = !toggleShow;
                    });
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(widget.imagePath),
                    radius: toggleShow ? 27 : 25,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: toggleShow,
                  child: GestureDetector(
                    onTap: () {
                      // ignore: deprecated_member_use
                      // launch("tel://${widget.phone}");
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          const AssetImage('assets/images/call.png'),
                      radius: toggleShow ? 20 : 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: toggleShow,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/info.png'),
                    radius: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedPadding(
                  padding: EdgeInsets.all(toggleShow ? 3 : 0),
                  duration: const Duration(seconds: 0),
                  curve: Curves.bounceInOut,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      // border: Border.all(color: PColor,width: 0.8),

                      color: toggleShow
                          ? const Color(0xFF043B65).withOpacity(0.25)
                          : const Color(0xffF8A44C).withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: SizeConfig.screenWidth! / 1.35,
                    height: SizeConfig.screenheight! / 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'د. ' + widget.DoctorName,
                          style: const TextStyle(
                            color: PColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.live_help,
                              color: Color.fromARGB(255, 187, 148, 6),
                              size: 20,
                            ),
                            Text(
                              widget.Specialize.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: PColor.withOpacity(0.60),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(
                              Icons.calendar_today,
                              color: Color.fromARGB(255, 187, 148, 6),
                              size: 20,
                            ),
                            Text(
                              widget.Day,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: PColor.withOpacity(0.60),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(
                              Icons.watch_later,
                              color: Color.fromARGB(255, 187, 148, 6),
                              size: 20,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              (widget.From > 12
                                          ? widget.From - 12
                                          : widget.From)
                                      .toString() +
                                  ' ' +
                                  fromFormat +
                                  '  -  ' +
                                  (widget.To > 12 ? widget.To - 12 : widget.To)
                                      .toString() +
                                  ' ' +
                                  fromTo,

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: PColor.withOpacity(0.60),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GeneralButton(
                            customText: 'حجز',
                            raduis: 8,
                            color: Colors.green.shade300,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Booking(
                                      widget.HospitalName,
                                      widget.HospitalId,
                                      widget.DoctorName,
                                      widget.DoctorId,
                                      widget.Day,
                                      widget.From,
                                      widget.To)));
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
