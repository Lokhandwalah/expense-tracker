import 'package:expense_tracker/core/app_theme.dart';
import 'package:expense_tracker/core/utils/screen_config.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = getScreenHeight(context);
    final double screenWidth = getScreenWidth(context);
    final double barHeight = screenHeight * 0.1;
    final double barWidth = screenWidth * 0.1;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // SizedBox(height: 5),
        // FittedBox(
        //   child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
        // ),
        SizedBox(height: 5),
        Card(
          color: AppTheme.offWhite,
          child: Stack(
            children: [
              Container(
                height: barHeight,
                width: barWidth,
                child: Container(
                  color: AppTheme.offWhite,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: barHeight * spendingPctOfTotal,
                  width: barWidth,
                  child: Container(
                    color: AppTheme.primary,
                  ),
                ),
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
