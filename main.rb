class Node
  attr_accessor :data, :left_child, :right_child
  def initialize data
    @data = data
    @left_child = nil
    @right_child = nil
  end
end

class Tree
  def initialize array
    @root = build_tree array.sort.uniq, 0, array.size-1
    p array.sort.uniq
  end

  def build_tree array, idx_start, idx_end
    return nil if idx_start > idx_end
    idx_mid = (idx_start+idx_end)/2
    root_node = Node.new array[idx_mid]

    root_node.left_child = build_tree array, idx_start, idx_mid-1
    root_node.right_child = build_tree array, idx_mid+1, idx_end

    return root_node
  end

  def insert value, node = @root, parent = nil, left = nil
    if node == nil
      node = Node.new(value) 
      left == true ? parent.left_child = node : parent.right_child = node
      return node
    end
    if node.data > value
      insert value, node.left_child, node, true
    elsif node.data < value
      insert value, node.right_child, node, false
    else
      puts "Value #{value} already exist in the binary search tree!"
      return node
    end
  end

  def delete value
    deleted_node = find value
    deleted_node_parent = find value
    if deleted_node == nil
      puts "The value #{value} doesn't exist!"
    elsif deleted_node.left_child && deleted_node.right_child == nil # have one child (left)
      deleted_node.data = deleted_node.left_child.data
      deleted_node.right_child = deleted_node.left_child.right_child
      deleted_node.left_child = deleted_node.left_child.left_child
    elsif deleted_node.right_child && deleted_node.left_child == nil # have one child (right)
      deleted_node.data = deleted_node.right_child.data
      deleted_node.left_child = deleted_node.right_child.left_child
      deleted_node.right_child = deleted_node.right_child.right_child
    elsif deleted_node.right_child == nil && deleted_node.left_child == nil # leaf node
      deleted_node_parent = find_parent value
      if deleted_node == @root
        @root = nil
      else
        if deleted_node_parent.data > deleted_node.data
          deleted_node_parent.left_child = nil
        else
          deleted_node_parent.right_child = nil
        end
      end
    else # two child
      successor_node = deleted_node.right_child
      until successor_node.left_child == nil
        successor_node = successor_node.left_child
      end
      temp = successor_node.data
      delete successor_node.data
      deleted_node.data = temp
    end
  end

  def find_parent value, node = @root
    return nil if node == nil || @root == value
    return node if node.left_child && node.left_child.data == value
    return node if node.right_child && node.right_child.data == value   
    if node.data > value
      find_parent value, node.left_child
    else
      find_parent value, node.right_child
    end
  end

  def find value, node = @root
    if node == nil
      puts "The value #{value} doesn't exist in the tree"
      return
    end
    return node if node.data == value
    if node.data > value
      find value, node.left_child
    else
      find value, node.right_child
    end
  end

  def height node 
    return -1 if node == nil
    leftTreeHeight = height node.left_child
    rightTreeHeight = height node.right_child
    return (leftTreeHeight > rightTreeHeight ? leftTreeHeight : rightTreeHeight) + 1
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

bst = Tree.new [1,2,3,4,5]
bst.pretty_print
puts "\n\n"
p bst.height bst.find(2)
# bst.delete 5
# bst.pretty_print