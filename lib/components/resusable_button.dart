import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool loading;


  ReusableButton({super.key, required this.title, required this.onPressed,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height *0.09,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
        onPressed:loading?null: onPressed,
        child:loading?const CircularProgressIndicator(): Text(title,
         style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
