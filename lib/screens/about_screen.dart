import 'package:flutter/material.dart';
import 'package:eqqu/widgets/info_page.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      title: 'O nás',
      headline: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
      paragraphs: [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec risus justo, mattis non justo sed, viverra imperdiet augue. Ut finibus orci a massa dictum, sed faucibus lectus efficitur. Vivamus et enim commodo justo viverra placerat a vitae lacus. In facilisis purus libero, a congue turpis consectetur ornare. Duis id tempor dolor.',
        'Fusce nulla eros, mattis eget congue nec, porttitor id felis. Cras auctor tempus metus, mattis scelerisque mi efficitur vel. Nulla sollicitudin quam id mollis facilisis. Integer ornare porta dignissim. Praesent pellentesque mauris urna, vel venenatis purus dictum vel. Proin tristique varius euismod.',
      ],
      imagePath: 'assets/images/background.jpg',
    );
  }
}
