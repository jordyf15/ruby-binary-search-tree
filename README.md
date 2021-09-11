# Ruby Binary Search Tree
A mini project for The Odin project's Full Stack Ruby On Rails path Ruby Programming section where we have to build a Binary Search Tree with a Tree and Node class and also the following methods for the Tree Class to operate on the binary search tree.

1. `#build_tree` method which takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a balanced binary tree full of Node objects appropriately placed. The #build_tree method should return the level-0 root node.
2. `#insert` and `#delete` method which accepts a value to insert/delete to/from the binary search tree.
3. `#find method` which accepts a value and returns the node with the given value.
4. `#level_order` method that returns an array of values. This method should traverse the tree in breadth-first level order. This method can be implemented using either iteration or recursion which is done with both in this source code.
5. `#inorder`, `#preorder`, and `#postorder` methods that returns an array of values. Each method should traverse the tree in their respective depth-first order.
6. `#height` method which accepts a node and returns its height.
7. `#depth` method which accepts a node and returns its depth.
8. `#balanced?` method which checks if the tree is balanced.
9. `#rebalance` method which rebalances an unbalanced tree.
