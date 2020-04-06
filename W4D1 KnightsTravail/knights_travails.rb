require_relative "knight_tree.rb"

class KnightPathFinder
    attr_reader :root_node, :considered_positions
      

    def self.valid_moves(initial_pos)
        moves = []
        pos_1 = initial_pos.first
        pos_2 = initial_pos.last

        directions = [[pos_1 + 2, pos_2 + 1], [pos_1 + 2, pos_2 - 1], [pos_1 + 1, pos_2 + 2], [pos_1 + 1, pos_2 - 2], [pos_1 - 2, pos_2 + 1], [pos_1 - 2, pos_2 - 1], [pos_1 - 1, pos_2 + 2], [pos_1 - 1, pos_2 - 2]]
  
        directions.each do |dir| 
          if dir.all? { |num| (0..7).include?(num) }
            moves << dir
          end
        end
        moves
    end

    def initialize(initial_pos)
        @root_node = PolyTreeNode.new(initial_pos)
        @considered_positions = [initial_pos]
    end 
  
    def new_move_positions(pos) 
        possibles = KnightPathFinder.valid_moves(pos)
        final_moves = possibles.reject { |move| @considered_positions.include?(move)}
        @considered_positions += final_moves
        final_moves
          # if @considered_positions.include?(pos) 
        #     raise "position already considered"  
        # elsif !possibles.include?(pos)
        #     raise "invalid position"
        # else
        #    @considered_positions << pos
        #     p pos
        # end   
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(start_pos)
        
        nodes = [root_node]
        until nodes.empty?
            current_node = nodes.shift

            current_pos = current_node.value
            new_move_positions(current_pos).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
    end
    
   # move = PolyTreeNode.new(self.root_node.value, new_move_positions(self.root_node.value))
   # move.bfs
   # new_move_positions(self.root_node.value).bfs

    def find_path(end_pos)
    end_node = root_node.dfs(end_pos)

    trace_path_back(end_node)
      .reverse
      .map(&:value)
    end

    def trace_path_back(end_node)
     nodes = []

      current_node = end_node
      until current_node.nil?
        nodes << current_node
        current_node = current_node.parent
      end

     nodes
    end
end


end



# [00, 01, 02, 03, 04, 05, 06, 07,]  00 + 21= 21 + 12= 33
# [10, 11, 12, 13, 14, 15, 16, 17,]
# [20, 21, 22, 23, 24, 25, 26, 27,]  "a" ['b'. 'c']
# [30, 31, 32, 33, 34, 35, 36, 37,]  [0,0], [[2, 1]]
# [40, 41, 42, 43, 44, 45, 46, 47,]  [2,1], [[3,3]]
# [50, 51, 52, 53, 54, 55, 56, 57,]
# [60, 61, 62, 63, 64, 65, 66, 67,]
# [70, 71, 72, 73, 74, 75, 76, 77,]


# kpf = KnightPathFinder.new([0, 0])
# kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
# kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]




# def pos_moves(pos)
# da_great_8 = [[-1, 2], [1, 2], [2, 1] ,[2, -1], [1, -2],[-1, -2], [-2, -1], [-2, 1]]
# possible_moves = []
#   da_great_8.each do |mod|
#     new_x = pos[0] + mod[0]
#     new_y = pos[1] + mod[1]
#     possible_moves << [new_x, new_y]
#   end 
# possible_moves.select{ |subs| !subs[0].negative? && !subs[1].negative? }
# end

# p pos_moves([4, 3])

# KnightPathFinder.valid_moves(kpf.root_node.value)