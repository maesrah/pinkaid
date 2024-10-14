import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/controller/meal_controller.dart';

void showMealBottomSheet(BuildContext context,String mealType) {
  final controller = Get.put(MealController());
  Get.bottomSheet(
    Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              controller.searchMeal(value);
            },
            decoration: InputDecoration(
              labelText: 'Search Meals',
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.filteredMeals.length,
                itemBuilder: (context, index) {
                  final meal = controller.filteredMeals[index];
                  return ListTile(
                    title: Text(meal['mealName']??'Unknown meal'),
                    subtitle: Text(
                        'Calories: ${meal['calories']??0}, Protein: ${meal['nutrient']??0}g'),
                    trailing: TextButton(
                      onPressed: () {
                        controller.updateMeal(mealType, meal['mealName']?? 'Unknown',meal['calories'] ?? 0);
                      },
                      child: Text('Add'),
                    ),
                  );
                },
              );
            }),
          ),
          TextButton(
            onPressed: () {
              // Add a new meal
              showAddMealDialog(context);
            },
            child: Text('Add Custom Meal'),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

void showAddMealDialog(BuildContext context) {
  final mealController = Get.find<MealController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add Custom Meal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Meal Name'),
            ),
            TextField(
              controller: caloriesController,
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: proteinController,
              decoration: InputDecoration(labelText: 'Protein (g)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newMeal = {
                'name': nameController.text,
                'calories': double.tryParse(caloriesController.text) ?? 0,
                'protein': double.tryParse(proteinController.text) ?? 0,
              };
              mealController.addMeal(newMeal);
              Get.back();
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}
