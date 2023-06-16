import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../core/utils/screen_config.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  final bool isWeb;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      {this.isWeb = false});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = getScreenHeight(context);
    final double screenWidth = getScreenWidth(context);
    final double barHeight = isWeb ? screenHeight * 0.24 : screenHeight * 0.12;
    final double barWidth = isWeb ? screenWidth * 0.05 : screenWidth * 0.1;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 5),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppTheme.offWhite,
          margin: EdgeInsets.symmetric(horizontal: isWeb ? 10 : 5),
          child: Stack(
            children: [
              Container(
                height: barHeight,
                width: barWidth,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    height: barHeight * spendingPctOfTotal,
                    width: barWidth,
                    decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        FittedBox(
          child: Text(
            label,
            style: TextStyle(
              color: AppTheme.white,
            ),
          ),
        ),
      ],
    );
  }
}
