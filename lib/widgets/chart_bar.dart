import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPrcOfAmount;
  
  ChartBar(this.label, this.spendingAmount, this.spendingPrcOfAmount);
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint){
      return SingleChildScrollView(
        child: Column(
          children: [
            FittedBox(
              child: Container(
                height: constraint.maxHeight * 0.15,
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05,),
            Container(
              height: constraint.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPrcOfAmount,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(height: constraint.maxHeight * 0.05,),
            Text(label),
          ],
        ),
      ); 
    }); 
  }
}
