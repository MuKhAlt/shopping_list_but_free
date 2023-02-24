import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_list_but_free/models/shopping_list.dart';

/// Displays a card that lets the user copy the Json encoding of
/// [shoppingList]
class ExportShoppingList extends StatefulWidget {
  final ShoppingList shoppingList;
  const ExportShoppingList({
    required this.shoppingList,
    Key? key,
  }) : super(key: key);

  @override
  State<ExportShoppingList> createState() => _ExportShoppingListState();
}

class _ExportShoppingListState extends State<ExportShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Center(
            child: SizedBox(
              width: min(MediaQuery.of(context).size.width - 10, 300),
              height: MediaQuery.of(context).size.height / 3,
              child: Card(
                elevation: 20,
                child: Column(
                  children: [
                    Row(
                      children: [
                        BackButton(
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Send the shopping list code for others to import it',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.copy),
                      label: const Text('Shopping list code'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}