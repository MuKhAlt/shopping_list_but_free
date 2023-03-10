import 'package:flutter/material.dart';
import 'package:shopping_list_but_free/models/collection.dart';
import 'package:shopping_list_but_free/models/shopping_item.dart';
import 'package:shopping_list_but_free/objectbox.dart';
import 'package:shopping_list_but_free/objectbox.g.dart';
import 'package:shopping_list_but_free/widgets/add_entity.dart';

/// Displays a form that creates a new **Collection** and stores it to obx when submitted.
///
/// If a [shoppingItem] is given, it adds its **name (all lower case)**  to **Collection**.
class AddCollection extends StatefulWidget {
  final ShoppingItem? shoppingItem;

  const AddCollection({
    this.shoppingItem,
    Key? key,
  }) : super(key: key);

  @override
  State<AddCollection> createState() => _AddCollectionState();
}

class _AddCollectionState extends State<AddCollection> {
  @override
  Widget build(BuildContext context) {
    return AddEntity(
      onSubmit: _submit,
      inputFieldHintText: 'Collection name',
    );
  }

  void _submit(String collectionName) {
    late final Collection newCollection;

    // Whether a Collection with same name exists
    if (objectbox.collectionBox
            .query(Collection_.name.equals(collectionName))
            .build()
            .findFirst() !=
        null) {
      // Assign to the existing Collection
      newCollection = objectbox.collectionBox
          .query(Collection_.name.equals(collectionName))
          .build()
          .findFirst() as Collection;
    } else {
      // Create a new Collection
      newCollection = Collection(name: collectionName.trim());
    }

    // Add shoppingItem's name to collection if a shoppingItem is provided
    if (widget.shoppingItem != null) {
      final currentCollection = objectbox.collectionBox
          .query(Collection_.shoppingItemsNames
              .containsElement(widget.shoppingItem!.name.toLowerCase()))
          .build()
          .findFirst();

      // Remove shoppingItem name from current Collection that
      // has it
      currentCollection!.shoppingItemsNames
          .remove(widget.shoppingItem!.name.toLowerCase());

      // Add Collection to objectbox
      objectbox.collectionBox.put(currentCollection);

      // Add shoppingItem name to new Collection
      newCollection.shoppingItemsNames
          .add(widget.shoppingItem!.name.toLowerCase());
    }

    // Add newCollection to obx
    objectbox.collectionBox.put(newCollection);

    // Show warning SnackBar if the added Collection is Others
    if (newCollection.name == 'Others') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cannot use the name "Others" for a new collection')));
    }

    // Pop Widget
    Navigator.of(context).pop();
  }
}
