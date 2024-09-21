import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s_game/game.dart';
import 'package:s_game/option.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff140F3D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GameStartButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const StarGame();
                }));
              },
              bgColor: const Color(0xff2BC16A),
              textColor: const Color(0xffe3f1e7),
              buttonname: "Start",
            ),
            const SizedBox(
              height: 20,
            ),
            GameStartButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OptionPage();
                }));
              },
              bgColor: const Color(0xff2BC16A),
              textColor: const Color(0xffe3f1e7),
              buttonname: "Options",
            ),
            const SizedBox(
              height: 20,
            ),
            GameStartButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              bgColor: const Color(0xffED573C),
              textColor: const Color(0xffe3f1e7),
              buttonname: "Exit",
            ),
          ],
        ),
      ),
    );
  }
}

class GameStartButton extends StatelessWidget {
  const GameStartButton({
    required this.bgColor,
    required this.textColor,
    required this.buttonname,
    required this.onPressed,
    super.key,
  });

  final Color? bgColor;
  final Color? textColor;
  final String buttonname;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor, fixedSize: const Size(300, 60)),
        child: Text(
          buttonname,
          style: TextStyle(color: textColor, fontSize: 40),
        ),
      ),
    );
  }
}
