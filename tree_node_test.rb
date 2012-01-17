require 'tree_node'
require 'test/unit'

class TreeNodeTest < Test::Unit::TestCase

  def setup
    @tree_node = TreeNode.new
  end

  def test_has_no_children_when_created
    assert_equal(0, @tree_node.children_count,
                 "should have an empty children array when created")
  end

  def test_has_no_parent_when_created
    assert_nil(@tree_node.parent)
  end

end

class TreeNodeChildAssignmentTest < Test::Unit::TestCase

  def setup
    @tree_node = TreeNode.new
    @child_node = TreeNode.new
    @tree_node.add_child(@child_node)
  end

  def test_children_count
    assert_equal(1, @tree_node.children_count,
                 "should have a single child when one is added")
  end

  def test_parent_assignment
    assert_equal(@tree_node, @child_node.parent, "child node should be able to return parent node")
  end
  
  def test_is_child
    assert_equal(true, @tree_node.is_child(@child_node), "parent node should be able to check for child nodes")
  end
  
  def test_move_child
    @child_node_2 = TreeNode.new
    @tree_node.add_child(@child_node_2)
    assert_equal(true, @tree_node.is_child(@child_node_2))
    @child_node.add_child(@child_node_2)
    assert_equal(false, @tree_node.is_child(@child_node_2), "should remove child from old parent node when making child of a new node")
  end
  
end

class TreeNodeNameAssignmentTest < Test::Unit::TestCase
  
  def setup
    @tree_node = TreeNode.new
  end

  
  def test_name_assignment
    @tree_node.name = 'Fred'
    assert_equal('Fred', @tree_node.name)
  end

end  

class TreeNodePathTest < Test::Unit::TestCase

  def setup
    @parent_node = TreeNode.new("Parent")
    @child_node = TreeNode.new("Child")
    @grandchild_node = TreeNode.new("Grandchild")
    @parent_node.add_child(@child_node)
    @child_node.add_child(@grandchild_node)
  end

  def test_path_method
    assert_equal("Parent > Child > Grandchild", @grandchild_node.path, "The path should be the names of each node in the chain, separated by '>'.")
  end

end

class TreeNodeSearchTest < Test::Unit::TestCase
  
  #     A
  #    / \
  #   B   C
  #  / \
  # D   E
  #    / \
  #   F   G
  
  def setup
    @a_node = TreeNode.new("A")
    @b_node = TreeNode.new("B")
    @c_node = TreeNode.new("C")
    @d_node = TreeNode.new("D")
    @e_node = TreeNode.new("E")
    @f_node = TreeNode.new("F")
    @g_node = TreeNode.new("G")
    
    @a_node.add_child(@b_node)
    @a_node.add_child(@c_node)
    
    @b_node.add_child(@d_node)
    @b_node.add_child(@e_node)
    
    @e_node.add_child(@f_node)
    @e_node.add_child(@g_node)
    
  end
  
  def test_search
    test_results = ["A", "B", "D", "E", "F", "G", "C"] 
    @a_node.search do |result|
      assert_equal(test_results.first, result.name)
      test_results.shift
    end
  end

end