import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/wordle_controller.dart';
import 'package:pinkaid/theme/theme.dart';


class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WordleController game = Get.find<WordleController>();
    //Color backgroundColor;
    
    return Obx(() {
       
      return Column(
        
        children: game.wordleBoard
            .map((row) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: row
                      .map((letter) => Container(
                            padding: EdgeInsets.all(16.0),
                            width: 64.0,
                            height: 60.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: letter.code == 0
                                  ? kColorPrimaryLight
                                  : letter.code == 1
                                      ? Colors.green.shade400
                                      : Colors.amber.shade400,
                            ),
                            child: Center(
                                child: Text(
                              letter.letter!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ))
                      .toList(),
                ))
            .toList(),
      );
    });
  }
}
