#!/opt/homebrew/bin/gawk -f

function check_num(num) {
  for (n=0; n<length(drawn_nums); n++) {
    if (num == drawn_nums[n]) return 1
  }
  return 0
}
function check_board(board_num) {
  # check for horizontal match
  for (i=0; i<row; i++) {
    sum = 0
    b = 0
    for (j=1; j<=NF; j++) {
      if (! check_num(boards[board_num, i, j])) {
        b = 1
        break
      }

    }
    if (b == 1) continue
    return 1
  }

  # check for vertical match
  for (j=1; j<=NF; j++) {
    sum = 0
    b = 0
    for (i=0; i<row; i++) {
      if (! check_num(boards[board_num, i, j])) {
        b = 1
        break
      }

    }
    if (b == 1) continue
    return 1
  }

  return 0
}
function sum_unmarked(board_num,    unmarked_sum) {
  for (i=0; i<row; i++) {
    for (j=1; j<=NF; j++) {
      if (! check_num(boards[board_num, i, j])) {
        unmarked_sum += boards[board_num, i, j]
      }
    }
  }
  return unmarked_sum
}
BEGIN {
  row = 0
  num_boards = 0
  unsolved_boards[num_boards] = 1
}
NR == 1 {
  split($0, num_basket, ",")
  getline # skip the next blank line
  next
}
/^$/ {
  num_boards++
  unsolved_boards[num_boards] = 1
  row = 0
  next
}
NF == 5 {
  for (i=1; i<=NF; i++) {
    boards[num_boards, row, i] = $i
  }
  row++
}
END {
  # for (board in unsolved_boards) printf "%d, ", board
  # print ""
  cur_drawn = 0
  while (length(unsolved_boards) > 1) {
    drawn_nums[cur_drawn] = num_basket[cur_drawn]
    for (board in unsolved_boards) {
      if (check_board(board)) delete unsolved_boards[board]
    }
    cur_drawn++
    # for (board in unsolved_boards) printf "%d, ", board
    # print ""
    # print length(unsolved_boards), cur_drawn-1, num_boards
  }
  for (board in unsolved_boards) final_board = board
  # print boards[final_board, 0, 1], drawn_nums[cur_drawn-1], sum_unmarked(final_board)
  print sum_unmarked(final_board) * drawn_nums[cur_drawn-1]
}
