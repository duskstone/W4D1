class PolyTreeNode
    attr_reader :value, :children, :parent

    def initialize(value, children = [])
        @value = value
        @children = children
        @parent = nil
    end
    
    #node1("a", ["b", "c"]) 
    #node2("b", ["e", "f"]) @parent = nod

    def parent=(new_parent)          
        return if self.parent == new_parent
        if self.parent
            self.parent.children.delete(self) 
        end
        @parent = new_parent
        self.parent.children << self unless self.parent.nil?
    end

    def add_child(child)
      child.parent = self 
    end

    def remove_child(child)
        child.parent = nil
        raise "error" if !@children.include?(child)
    end


    def dfs(target)
        return self if self.value == target
        return nil if @children.empty?
    
        
        @children.each do |child| 
           search_result = child.dfs(target) 
            return search_result unless search_result.nil?
        end 
        nil
    end

    def bfs(target) #find_path(7, 4) 
        
        queue = [self] #[1,2 chil][2,1]
        until queue.empty?
            node = queue.shift
            return node if node.value == target
            queue.concat(node.children) 
        end
        nil
    end

end