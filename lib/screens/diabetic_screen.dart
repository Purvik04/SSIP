import 'package:flutter/material.dart';
import 'package:arogya_mitra/data/diabeticData.dart';
import 'package:arogya_mitra/screens/diabetic_different_screens.dart';

class DiabeticScreen extends StatefulWidget {
  @override
  State<DiabeticScreen> createState() => _DiabeticScreenState();
}

class _DiabeticScreenState extends State<DiabeticScreen> {
  int selectedChipIndex = 0;

  final List<String> chipLabels = [
    'Diet Plan',
    'Insulin Management',
    'Exercise',
    'Medication',
    'Blood Glucose Monitoring',
  ];

  final List<Color> chipColors = [
    Color(0xFF0856DE),
    Color(0xFF0856DE),
    Color(0xFF0856DE),
    Color(0xFF0856DE),
    Color(0xFF0856DE),
  ];

  void onChipTap(int index) {
    setState(() {
      selectedChipIndex = index;
    });
  }

  Widget buildContent() {
    switch (selectedChipIndex) {
      case 0:
        return NutritionPlanScreen(diabeticNutritionPlan);
      case 1:
        return InsulinManagementScreen(insulinManagementData);
      case 2:
        return ExercisePlanScreen(diabeticExercisePlan);
      case 3:
        return MedicationScreen(medicationDataPlan);
      case 4:
        return BloodGlucoseMonitoringScreen(
          diabeticBloodGlucosePlan: diabeticBloodGluosePlan,
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetic Nutrition Plan'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                spacing: 10,
                runSpacing: 6,
                children: List.generate(
                  chipLabels.length,
                  (index) {
                    return ActionChip(
                      label: Text(chipLabels[index]),
                      backgroundColor: selectedChipIndex == index
                          ? Colors.white // Color for the selected chip
                          : chipColors[index],
                      labelStyle: TextStyle(
                        color: selectedChipIndex == index ? Colors.black : Colors.white, // Text color for selected chip
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 3), // Adjust label padding
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      side: BorderSide(
                        color: selectedChipIndex == index
                            ? chipColors[index] // Color for the selected chip
                            : Colors.black,
                      ),
                      onPressed: () {
                        onChipTap(index);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          buildContent(),
        ],
      ),
    );
  }
}
