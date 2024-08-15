import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/patientsFeatures/controller/doctor_controller.dart';
import 'package:pinkaid/features/patientsFeatures/controller/post_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/features/patientsFeatures/screen/consultationmodule/book_consultation.dart';
import 'package:pinkaid/features/patientsFeatures/screen/consultationmodule/list_doctors_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/post_card.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/separated/separated_list.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';


class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_circle_left_copy),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Text(
                'Appointment today',
                style: KTextTheme.lightTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kSpaceScreenPadding),
              const Center(child: Text('No appointment today')),
              const SizedBox(height: kSpaceScreenPaddingLg),
              Text(
                'List of doctors',
                style: KTextTheme.lightTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kSpaceScreenPadding),
              FutureBuilder(
                future: controller.fetchDoctor(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading doctors'));
                  } else if (!snapshot.hasData || controller.doctorsList.isEmpty) {
                    return const Center(child: const Text('No doctors available'));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.doctorsList.length,
                      itemBuilder: (_, index) => DoctorCard(
                        doctor: controller.doctorsList[index],
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpaceScreenPadding),
      child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding,vertical: kSpaceScreenPadding),
                  width: MediaQuery.of(context).size.width,
                  //height: 200,
                  
                  decoration: BoxDecoration(color: kColorInfo,
                  borderRadius: BorderRadius.circular(16)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding,vertical: kSpaceScreenPadding),
                  child: CircleAvatar(
                  radius: 40, // Adjust the radius to make the CircleAvatar bigger
                  backgroundColor: Colors.grey.shade200, // Optional: Set a background color
                  child: ClipOval(
                  child: Image.network(
                  doctor.profImage,
                  width: 100, 
                  height: 100, 
                  fit: BoxFit.cover, 
              ),
               ),
              )),
                GestureDetector(
                  onTap:() {
                    Get.to(BookConsultation(doctor: doctor,));
                  },
                  child: SizedBox(
                    width: 230,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text(doctor.fullName,style: KTextTheme.lightTextTheme.headlineSmall,),
                  //const SizedBox(height: 8,),
      Text(
        doctor.workExperience,
        style: KTextTheme.lightTextTheme.bodySmall,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,),
       
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kColorSecondaryLight,foregroundColor: Colors.black),
            onPressed: (){
           Get.to(()=> BookConsultation(doctor: doctor,));
                      
          }, child: const Text('Book',)),
        ],
      )
      ],
                    ),
                  ),
                )
                ],),
                ),
    );
  }
}

class ConsultationCard extends StatelessWidget {
  const ConsultationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(height:  200,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: kColorSecondaryLight),
                    child:  Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: kSpaceScreenPaddingLg,
        vertical: kSpaceScreenPaddingLg),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text('Dr Abc',style: KTextTheme.lightTextTheme.bodyLarge,),
    const Padding(
      padding: EdgeInsets.symmetric(vertical: kSpaceScreenPadding),
      child: Divider(height: 2,color: Colors.black,),
    ),
    const Row(children: [Icon(Iconsax.clock_copy),Text('Tuesday')],),
    const SizedBox(height: kSpaceScreenPadding,),
                       SeparatedList(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child:  Text(
                   'Cancel',
                   style: KTextTheme.lightTextTheme.titleSmall,),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child:  Text(
                      'Reschedule',
                      style: KTextTheme.lightTextTheme.titleSmall,
                    ),
                  ),
                ),
              ],
            ),
    ],)
                      ));
  }
}