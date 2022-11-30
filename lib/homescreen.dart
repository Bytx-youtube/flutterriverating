import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StateMachineController? controller;
  SMIInput<double>? inputValue;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenWidth,
              width: screenWidth,
              child: RiveAnimation.asset(
                'assets/star-rating.riv',
                onInit: (art) {
                  controller = StateMachineController.fromArtboard(
                    art, "State Machine 1",
                  );

                  if(controller != null) {
                    art.addController(controller!);
                    inputValue = controller?.findInput("Rating");
                    inputValue?.change(1);
                  }
                },
              ),
            ),
            TextFormField(
              onChanged: (v) {
                inputValue?.change(double.parse(v));
              },
            ),
            GestureDetector(
              onTap: () {
                int? id = inputValue?.id;
                print(controller?.getInputValue(id!));
              },
              child: Container(
                height: 40,
                width: 70,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
