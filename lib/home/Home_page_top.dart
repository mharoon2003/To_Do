//top section of the home page



import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'Search_home.dart';

class TopSession extends StatelessWidget {
  final VoidCallback? onDrawerOpen;

  const TopSession({super.key, this.onDrawerOpen, });

  @override
  Widget build(BuildContext context) {
    return

    SizedBox(
        height: 260,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 16,
                right: 16,
              ),
              width: double.infinity,
              height: 210,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/black_container.jpg',
                    ),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: onDrawerOpen,
                      icon: const Icon(Icons.menu_outlined),
                  color: Colors.white,),
                  SizedBox(height: 12,),
                  const Text(
                    'Hey Dear!',
                    style: TextStyle(color: Color.fromARGB(255, 237, 231, 231)),
                  ),
                  const Gap(10),
                  const Text(
                    'Let\'s complete\nyour task!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 190,
              right: 0,
              left: 0,
              child: CustomSearchBar(),
            ),
          ],
        ),
    );
  }
}

