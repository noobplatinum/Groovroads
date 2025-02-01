import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovroads/core/configs/assets/appimgs.dart';
import 'package:groovroads/core/configs/assets/appvectors.dart';
import 'package:groovroads/common/widgets/button/entrybutton.dart';
import 'package:groovroads/presentation/authentication/signx.dart';
import 'package:groovroads/presentation/modeoptions/bloc/mode_cubit.dart';

class ModeOptions extends StatelessWidget {
  const ModeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Appimages.modeBG), // Use modeBG as the background image
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 1),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 60), // Reduce the upper margin
                        child: Image.asset(
                          Appvectors.logo,
                          width: 300,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 8), // Adjust the space here (reduce from 1 to 8 for slight spacing)
                      const Text(
                        'On Any Road You Travel',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Text(
                  'Choose a Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ModeCubit>().updateTheme(ThemeMode.light);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.5), // Slightly opaque dark background
                            ),
                            child: IconButton(
                              icon: Image.asset(Appvectors.sun),
                              iconSize: 30,
                              onPressed: () {
                                context.read<ModeCubit>().updateTheme(ThemeMode.light);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Light',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 40),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ModeCubit>().updateTheme(ThemeMode.dark);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.5), // Slightly opaque dark background
                            ),
                            child: IconButton(
                              icon: Image.asset(Appvectors.moon),
                              iconSize: 30,
                              onPressed: () {
                                context.read<ModeCubit>().updateTheme(ThemeMode.dark);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Dark',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                EntryButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (BuildContext context) => const SignX()),
                    );
                  },
                  title: 'Continue',
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 40, top: 30),
                  child: Text(
                    'Pick a Display Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}