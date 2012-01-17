class TreeNode
  attr :children
  attr_reader :parent
  attr_accessor :name

  def initialize(name=nil)
    @name = name
    @children = []
  end

  def add_child(child)
    if child.parent
      child.parent.children.delete(child)
    end
    child.parent = self
    @children << child
  end

  def parent=(new_parent)
    @parent = new_parent
  end
  
  def children_count
    @children.length
  end
  
  def is_child(child)
    children.include? child
  end
  
  def path
    path = ""
    path += "#{parent.path} > " if parent
    path += @name
  end
  
  def search(&block)
    block.call(self)
    @children.each do |child|
      child.search(&block)
    end
  end
    

end
