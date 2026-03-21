import 'package:flutter/material.dart';
import 'package:eqqu/widgets/info_page.dart';

class EqquPlatformScreen extends StatelessWidget {
  const EqquPlatformScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      title: 'EQQU platforma',
      headline: 'EQQU platforma je místo, kde najdete vše pro koně, podobně jako Vinted pro módu.',
      paragraphs: [
        'EQQU je online tržiště zaměřené na jezdecké potřeby, kde můžete nakupovat a prodávat vybavení pro koně snadno a rychle, stejně jako na Vinted.',
        'Na EQQU najdete široký výběr koňských potřeb, od sedel po ohlávky, vše na jednom místě, podobně jako Vinted pro oblečení.',
      ],
      imagePath: 'assets/images/product_02.png',
    );
  }
}
