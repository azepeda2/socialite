import 'package:flutter/material.dart';
import 'package:social_media/enums/enums.dart';

class BottomNavBar extends StatelessWidget {
  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;

  const BottomNavBar({
    Key key, 
    this.items, 
    this.selectedItem, 
    this.onTap
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: BottomNavItem.values.indexOf(selectedItem),
      onTap: onTap,
      items: items.map(
        (item, icon) => MapEntry(
          item.toString(), 
          BottomNavigationBarItem(
            label: "",
            icon: Icon(icon, size: 30.0),
          ),
        ),
      ).values.toList(),
    );
  }
}