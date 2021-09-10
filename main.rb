class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def <=>(value)
    @data <=> value
  end
  
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
    if node > value
      insert value, node.left_child, node, true
    elsif node < value
      insert value, node.right_child, node, false
    else
      puts "Value #{value} already exist in the binary search tree!"
      return node
    end
  end

  def find value, node = @root
    if node == nil
      puts "The value #{value} doesn't exist in the tree"
      return
    end
    return node if node == value
    if node > value
      find value, node.left_child
    else
      find value, node.right_child
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

bst = Tree.new [1,2,3,4,5,6,7,8,9]
bst.pretty_print
puts "\n\n"
# bst.insert 10
# bst.insert -1
# bst.insert 1
# bst.pretty_print
p bst.find 8
p bst.find 10
p bst.find 5
# bst.pretty_print

