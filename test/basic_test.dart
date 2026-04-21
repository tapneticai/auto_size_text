import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets('Only Text', (tester) async {
    await pump(
      tester: tester,
      widget: AutoSizeText('Some Text'),
    );
  });

  testWidgets('Only text (rich)', (tester) async {
    await pump(
      tester: tester,
      widget: AutoSizeText.rich(TextSpan(text: 'Some Text')),
    );
  });

  testWidgets('Uses style fontSize', (tester) async {
    await pumpAndExpectFontSize(
      tester: tester,
      expectedFontSize: 34,
      widget: AutoSizeText(
        'Some Text',
        style: TextStyle(fontSize: 34),
      ),
    );
  });

  testWidgets('Uses style fontSize (rich)', (tester) async {
    await pumpAndExpectFontSize(
      tester: tester,
      expectedFontSize: 35,
      widget: AutoSizeText.rich(
        TextSpan(text: 'Some Text'),
        style: TextStyle(fontSize: 35),
      ),
    );
  });

  testWidgets('Respects inherit style', (tester) async {
    final defaultStyle = TextStyle(
      fontSize: 20,
      color: Colors.yellow,
    );
    final text = await pumpAndGetText(
      tester: tester,
      widget: DefaultTextStyle(
        style: defaultStyle,
        textAlign: TextAlign.right,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        maxLines: 17,
        child: AutoSizeText(
          'AutoSizeText Test',
        ),
      ),
    );
    expect(text.style, defaultStyle);

    final richText = getRichText(tester);
    expect(richText.textAlign, TextAlign.right);
    expect(richText.softWrap, false);
    expect(richText.overflow, TextOverflow.ellipsis);
    expect(richText.maxLines, 17);
  });

  testWidgets('Applies scale even if initial fontSize fits (#25)',
      (tester) async {
    await pumpAndExpectFontSize(
      tester: tester,
      expectedFontSize: 60,
      widget: AutoSizeText(
        'Some Text',
        style: TextStyle(fontSize: 15),
        textScaler: TextScaler.linear(4),
      ),
    );
  });

  testWidgets('Uses textKey', (tester) async {
    final textKey = GlobalKey();
    final text = await pumpAndGetText(
      tester: tester,
      widget: AutoSizeText(
        'A text with key',
        textKey: textKey,
      ),
    );
    expect(text.key, textKey);
  });

  testWidgets('Passes semanticsIdentifier to Text', (tester) async {
    final text = await pumpAndGetText(
      tester: tester,
      widget: AutoSizeText(
        'Text with semantics identifier',
        semanticsIdentifier: 'auto_size_text_identifier',
      ),
    );
    expect(text.semanticsIdentifier, 'auto_size_text_identifier');
  });

  testWidgets('Passes semanticsIdentifier to Text.rich', (tester) async {
    final text = await pumpAndGetText(
      tester: tester,
      widget: AutoSizeText.rich(
        TextSpan(text: 'Rich text with semantics identifier'),
        semanticsIdentifier: 'auto_size_text_rich_identifier',
      ),
    );
    expect(text.semanticsIdentifier, 'auto_size_text_rich_identifier');
  });
}
