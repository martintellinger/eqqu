import 'package:flutter/material.dart';
import 'package:eqqu/widgets/info_page.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      title: 'Jak funguje EQQU?',
      headline: 'EQQU funguje jako Vinted, ale zaměřuje se na potřeby jezdců a koní, kde můžete snadno nakupovat a prodávat vybavení pro koně.',
      paragraphs: [
        'EQQU je platforma podobná Vinted, ale specializovaná na jezdecké potřeby. Umožňuje uživatelům pohodlně prodávat a kupovat vybavení pro koně a jezdce.',
        'EQQU funguje stejně jako Vinted, ale místo oblečení nabízí široký výběr jezdeckých potřeb a vybavení pro koně, které můžete snadno prodat nebo koupit.',
      ],
      imagePath: 'assets/images/horse_rider.png',
    );
  }
}
