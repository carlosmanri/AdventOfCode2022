puts "Day 8"

$forest = []
best_scenic_score = 0

File.read('input.txt').strip.split("\n").each do |line|
  $forest << []
  line.each_char do |char|
    $forest.last << char.to_i
  end
end

$forest.each_with_index do |row, row_idx |
  row.each_with_index do | tree, col_idx |

    scenic_score = [0, 0, 0, 0]

    # trees on the edge are visible
    if row_idx == 0 || col_idx == 0 || row_idx == 98 || col_idx == 98
      next
    end

    row[0..(col_idx - 1)].reverse.each do | next_tree |
      scenic_score[0] += 1
      break if next_tree >= tree # stop when a higher tree is reached
    end

    row[(col_idx + 1)..].each do | next_tree |
      scenic_score[1] += 1
      break if next_tree >= tree
    end

    $forest[0..(row_idx - 1)].map { |r| r[col_idx] }.reverse.each do |next_tree|
      scenic_score[2] += 1
      break if next_tree >= tree
    end

    $forest[(row_idx + 1)..].map { |r| r[col_idx] }.each do |next_tree|
      scenic_score[3] += 1
      break if next_tree >= tree
    end

    scenic_score = scenic_score.inject(:*)

    if scenic_score > best_scenic_score
      best_scenic_score = scenic_score
    end

  end
end


puts "The highest scenic score possible is #{best_scenic_score}"
