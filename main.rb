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
    @root = build_tree array.sort.uniq, 0, array.uniq.size-1
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

  def depth node, depth = 0, current_node = @root
    return depth if current_node == node
    if node.data > current_node.data
      depth node, depth+1, current_node.right_child
    else
      depth node, depth+1, current_node.left_child
    end
  end

  def level_order node = @root, queue = [@root], values = []
    return values if queue.size == 0
    values.push node.data
    queue.shift
    queue.push node.left_child unless node.left_child == nil
    queue.push node.right_child unless node.right_child == nil
    level_order queue[0], queue, values
  end

  def level_order_iterative node = @root, queue = [@root], values = []
    until queue.size == 0
      values.push queue[0].data
      queue.push queue[0].left_child unless queue[0].left_child == nil
      queue.push queue[0].right_child unless queue[0].right_child == nil
      queue.shift
    end
    values
  end

  def in_order node = @root, values = []
    return values if node == nil
    in_order node.left_child, values
    values.push node.data
    in_order node.right_child, values
  end

  def pre_order node = @root, values = []
    return values if node == nil
    values.push node.data
    pre_order node.left_child, values
    pre_order node.right_child, values
  end

  def post_order node = @root, values = []
    return values if node == nil
    post_order node.left_child, values
    post_order node.right_child, values
    values.push node.data
  end

  def balanced? node = @root, balanced = true
    return balanced if node == nil

    left_tree_height = node.left_child == nil ? 0 : height(node.left_child)+1
    right_tree_height = node.right_child == nil ? 0 : height(node.right_child)+1
    balanced = false if left_tree_height - right_tree_height > 1 || left_tree_height - right_tree_height < -1
    
    return balanced if balanced == false
    return false if balanced?(node.left_child, balanced) == false
    return false if balanced?(node.right_child, balanced) == false
    balanced
  end

  def rebalance 
    @root = build_tree level_order.uniq.sort, 0, level_order.uniq.size-1  
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if @root == nil
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end


def driver_script
  arr = Array.new(15) { rand(1..100) }
  p arr
  bst = Tree.new (arr)
  bst.pretty_print
  p bst.balanced?
  p bst.in_order
  p bst.pre_order
  p bst.post_order
  bst.insert 101
  bst.insert 102
  bst.insert 103
  p bst.balanced?
  bst.rebalance
  p bst.balanced?
  p bst.in_order
  p bst.pre_order
  p bst.post_order
end

driver_script