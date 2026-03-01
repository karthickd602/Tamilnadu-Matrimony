import 'package:flutter/material.dart';

class HoroscopeChart extends StatelessWidget {
  final Map<int, String> rasiData;
  final Map<int, String> amsamData;
  final String rasiTitle;
  final String amsamTitle;

  const HoroscopeChart({
    super.key,
    required this.rasiData,
    required this.amsamData,
    this.rasiTitle = "ராசி",
    this.amsamTitle = "அம்சம்",
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If width is large enough, show side-by-side, else stack
        bool isWide = constraints.maxWidth > 600;

        return isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildGrid(context, rasiData, rasiTitle)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildGrid(context, amsamData, amsamTitle)),
                ],
              )
            : Column(
                children: [
                  _buildGrid(context, rasiData, rasiTitle),
                  const SizedBox(height: 24),
                  _buildGrid(context, amsamData, amsamTitle),
                ],
              );
      },
    );
  }

  Widget _buildGrid(BuildContext context, Map<int, String> data, String title) {
    return AspectRatio(
      aspectRatio: 1, // Square chart
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Column(
          children: [
            // Row 1 (Top): Boxes 0, 1, 2, 3
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  _buildBox(
                    data[0] ?? "",
                    border: const Border(right: BorderSide()),
                  ),
                  _buildBox(
                    data[1] ?? "",
                    border: const Border(right: BorderSide()),
                  ),
                  _buildBox(
                    data[2] ?? "",
                    border: const Border(right: BorderSide()),
                  ),
                  _buildBox(data[3] ?? "", border: const Border()),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.black),

            // Middle Section
            Expanded(
              flex: 2, // 2 rows height
              child: Row(
                children: [
                  // Left Column (top to bottom): 11, 10
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildBox(
                          data[11] ?? "",
                          border: const Border(
                            right: BorderSide(),
                            bottom: BorderSide(),
                          ),
                        ),
                        _buildBox(
                          data[10] ?? "",
                          border: const Border(right: BorderSide()),
                        ),
                      ],
                    ),
                  ),

                  // Center Title
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Right Column (top to bottom): 4, 5
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildBox(
                          data[4] ?? "",
                          border: const Border(
                            left: BorderSide(),
                            bottom: BorderSide(),
                          ),
                        ),
                        _buildBox(
                          data[5] ?? "",
                          border: const Border(left: BorderSide()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.black),

            // Row 4 (Bottom): Boxes 9, 8, 7, 6
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  _buildBox(
                    data[9] ?? "",
                    border: const Border(right: BorderSide()),
                  ),
                  _buildBox(
                    data[8] ?? "",
                    border: const Border(right: BorderSide()),
                  ),
                  _buildBox(
                    data[7] ?? "",
                    border: const Border(right: BorderSide()),
                  ),
                  _buildBox(data[6] ?? "", border: const Border()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(String text, {required BoxBorder border}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: border),
        padding: const EdgeInsets.all(4),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
