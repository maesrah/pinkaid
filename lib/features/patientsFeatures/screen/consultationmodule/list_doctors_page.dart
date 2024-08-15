import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/patientsFeatures/screen/consultationmodule/appointment_screen.dart';
import 'package:pinkaid/features/patientsFeatures/screen/consultationmodule/book_consultation.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class ListDoctorsPage extends StatelessWidget {
  const ListDoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Iconsax.arrow_circle_left_copy)),
              title: const Text('All doctors'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding,vertical: kSpaceScreenPadding),
            width: MediaQuery.of(context).size.width,
            height: 190,
            
            decoration: BoxDecoration(color: kColorInfo,
            borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
           // mainAxisAlignment: MainAxisAlignment.,
            children: [
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding,vertical: kSpaceScreenPadding),
            child: Image.asset('assets/icons/google.png',
            height: 100,),
          ),
          GestureDetector(
            onTap:() {
              //Get.to(BookConsultation(doct));
            },
            child: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Dr Pawn',style: KTextTheme.lightTextTheme.headlineSmall,),
                const SizedBox(height: kSpaceScreenPadding,),
                Text(
                  'Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis. ',
                  style: KTextTheme.lightTextTheme.bodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,),
                 const SizedBox(height: kSpaceScreenPadding,),
                ElevatedButton(onPressed: (){
            Get.to(() => ListDoctorsPage());
            
                }, child: const Text('Book'))
                ],
              ),
            ),
          )
          ],),
          ),
          // child: ListView.builder(
          //                 itemCount: 2,
          //                 itemBuilder: (context, index) {
          //                   return Padding(
          //                     padding: const EdgeInsets.symmetric(vertical: kSpaceScreenPadding),
          //                     child: Container(child: Row(children: [],),),
          //                   );}),
        ));
  }
}