import 'package:flutter/material.dart';
import 'package:teste_tecnico_vision/presentation/screens/shopping_list_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: <Widget>[
          ShoppingListPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: const Color.fromRGBO(214, 200, 193, 100),
        backgroundColor: const Color.fromRGBO(253, 246, 243, 100),
        selectedIndex: _currentPage,
        destinations: const <Widget>[
          destinonavegacao(
            icone: Icons.shopping_cart_outlined,
            iconeSelecionado: Icons.shopping_cart,
          ),
          destinonavegacao(
            icone: Icons.credit_card_outlined,
            iconeSelecionado: Icons.credit_card,
          ),
          destinonavegacao(
            icone: Icons.settings_outlined,
            iconeSelecionado: Icons.settings,
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            _currentPage = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}

class destinonavegacao extends StatelessWidget {
  const destinonavegacao({
    Key? key,
    required this.icone,
    required this.iconeSelecionado,
  }) : super(key: key);
  final IconData icone;
  final IconData iconeSelecionado;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(icone),
      selectedIcon: Icon(iconeSelecionado, color: Colors.white),
      label: '',
    );
  }
}
