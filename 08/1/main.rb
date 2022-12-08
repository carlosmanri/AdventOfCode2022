puts "Day 8"

$forest = []
visibleTrees = 0

File.read('input.txt').strip.split("\n").each do |line|
  $forest << []
  line.each_char do |char|
    $forest.last << char.to_i
  end
end

$forest.each_with_index do |row, row_idx |
  row.each_with_index do | tree, col_idx |

    # trees on the edge are visible
    if row_idx == 0 || col_idx == 0 || row_idx == 98 || col_idx == 98
      visibleTrees += 1
      next
    end

    # check horizontal line of forest
    # compares the tree to the max of the left and right of the tree
    if tree > row[0..(col_idx - 1)].max || tree > row[(col_idx + 1)..].max
      visibleTrees += 1
      next
    end

    # check vertical line of forest
    # compares the tree to the max of the above and below of the tree
    if tree > $forest[0..(row_idx - 1)].map { |r| r[col_idx] }.max ||
      tree > $forest[(row_idx + 1)..].map { |r| r[col_idx] }.max
      visibleTrees += 1
      next
    end

  end
end

puts "There are #{visibleTrees} visible trees."
