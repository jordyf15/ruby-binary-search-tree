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
    deleted_node_parent = find_parent value
    if deleted_node == nil
      puts "The value #{value} doesn't exist!"
    elsif deleted_node.left_child && deleted_node.right_child == nil # have one child (left)

      if deleted_node_parent.data > deleted_node.data
        deleted_node_parent.left_child = deleted_node.left_child
      else
        deleted_node_parent.right_child = deleted_node.left_child
      end
      deleted_node.left_child = nil

    elsif deleted_node.right_child && deleted_node.left_child == nil # have one child (right)

      if deleted_node_parent.data > deleted_node.data
        deleted_node_parent.left_child = deleted_node.right_child
      else
        deleted_node_parent.right_child = deleted_node.right_child
      end
      
      deleted_node.right_child = nil
    elsif deleted_node.right_child == nil && deleted_node.left_child == nil # leaf node
     
      if deleted_node_parent.data > deleted_node.data
        deleted_node_parent.left_child = nil
      else
        deleted_node_parent.right_child = nil
      end
    
    else # have two child
      replace_node = deleted_node.right_child
      until replace_node.left_child == nil
        replace_node = replace_node.left_child
      end
      temp_node = Node.new replace_node.data
      temp_node.left_child = deleted_node.left_child
      temp_node.right_child = replace_node.right_child
      delete replace_node.data
      
      if deleted_node_parent.data > deleted_node.data
        deleted_node_parent.left_child = temp_node
        temp_node.left_child = deleted_node.left_child
      else
        deleted_node_parent.right_child = temp_node
        temp_node.left_child = deleted_node.left_child
      end
      
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

bst = Tree.new [1,2,3,4,5,6,7,8,9]
bst.pretty_print
puts "\n\n"
bst.delete 7
bst.pretty_print

