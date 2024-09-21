import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controllers/planet_controller.dart';
import '../../controllers/theme_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  late AnimationController animationController;

  late Animation rotate;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    rotate = Tween(begin: 0.0, end: pi * 2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dynamic pf = Provider.of<PlanetController>(context, listen: false);
    dynamic pt = Provider.of<PlanetController>(context);
    dynamic themePro = Provider.of<ThemeController>(context, listen: false);

    // Check if allPlanets is not empty
    bool hasPlanets = pt.allPlanets.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Solar System",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: themePro.isLight ? Colors.black : Colors.black,
        leading: hasPlanets
            ? IconButton(
          onPressed: () {
            setState(() {
              Navigator.of(context).pushNamed(
                'detail_page',
                arguments: pt.allPlanets[currentIndex],
              );
            });
          },
          icon: const Icon(Icons.arrow_forward_ios),
        )
            : null, // Hide if no planets
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                themePro.isLight = !themePro.isLight;
              });
            },
            icon: Icon(
              themePro.isLight ? Icons.dark_mode : Icons.light_mode,
            ),
            color: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.75),
                  BlendMode.darken,
                ),
                image: themePro.isLight
                    ? const AssetImage('lib/assets/images/bg_light.jpg')
                    : const AssetImage('lib/assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          hasPlanets
              ? ListWheelScrollView.useDelegate(
            itemExtent: 100,
            physics: const FixedExtentScrollPhysics(),
            diameterRatio: 1.0,

            onSelectedItemChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            squeeze: 0.64,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: pt.allPlanets.length,
              builder: (context, index) => AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).pushNamed(
                          'detail_page',
                          arguments: pf.allPlanets[index],
                        );
                      });
                    },
                    child: Transform.rotate(
                      angle: rotate.value,
                      child: Hero(

                        tag: pt.allPlanets[index]['name'],
                        child: Image.asset(
                          pt.allPlanets[index]['image'],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
              : const Center(
            child: Text(
              'No planets available',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          hasPlanets
              ? Align(
            alignment: const Alignment(0.5, 0.8),
            child: AnimatedDefaultTextStyle(
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              duration: const Duration(milliseconds: 350),
              child: Text(
                style: const TextStyle(
                  color: Colors.blue
                ),
                pf.allPlanets[currentIndex]['name'],
              ),
            ),
          )
              : Container(), // Hide if no planets
        ],
      ),
    );
  }

}
