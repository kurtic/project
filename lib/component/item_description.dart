import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  DescriptionText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: textTheme.display1.apply(fontSizeDelta: 2),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            text,
            style: textTheme.body1,
          ),
        ),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.

      ],
    );
  }
}
