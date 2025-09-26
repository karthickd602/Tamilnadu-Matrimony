import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../controller/dashboard_controller.dart';

class SwipeCustomerCard extends StatelessWidget {
  SwipeCustomerCard({super.key});

  final controller = Get.put(DashboardController());
  final List<SwipeItem> _swipeItems = [];
  late final MatchEngine _matchEngine;

  @override
  Widget build(BuildContext context) {
    // ✅ initialize swipe engine from profiles (reactive)
    if (_swipeItems.isEmpty) {
      for (var profile in controller.customerList) {
        _swipeItems.add(
          SwipeItem(
            content: profile,
            likeAction: () => controller.onLike(profile["name"]),
            nopeAction: () => controller.onSkip(profile["name"]),
            superlikeAction: () => controller.onSuperLike(profile["name"]),
          ),
        );
      }
      _matchEngine = MatchEngine(swipeItems: _swipeItems);
    }

    return Column(
      children: [
        Expanded(
          child: Obx(() {
            if (controller.customerList.isEmpty) {
              return const Center(child: Text("No profiles available"));
            }
            return SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (context, index) {
                final profile = controller.customerList[index];
                return _buildProfileCard(context, profile);
              },
              onStackFinished: () {
                Get.snackbar("End", "No more profiles to show!");
              },
              upSwipeAllowed: true,
              fillSpace: true,
            );
          }),
        ),

        // 🔹 Bottom Action Bar
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionButton(Icons.close, Colors.red, () {
                _matchEngine.currentItem?.nope();
              }),
              _actionButton(Icons.star, Colors.blue, () {
                _matchEngine.currentItem?.superLike();
              }),
              _actionButton(Icons.favorite, Colors.green, () {
                _matchEngine.currentItem?.like();
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context, Map<String, dynamic> profile) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(profile["image"], fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${profile["name"]}, ${profile["age"]}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  "${profile["job"]} • ${profile["location"]}",
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "${profile["religion"]}, ${profile["caste"]}\n${profile["qualification"]} • ${profile["marital"]} • ${profile["height"]}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, Color color, VoidCallback onTap) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: color.withValues(alpha: 0.1),
      child: IconButton(
        icon: Icon(icon, color: color, size: 32),
        onPressed: onTap,
      ),
    );
  }
}
