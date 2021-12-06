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
    print sum_unmarked(board_num) * drawn_nums[cur_drawn]
    exit
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
    print sum_unmarked(board_num) * drawn_nums[cur_drawn]
    exit
  }
}
function sum_unmarked(board_num) {
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
}
NR == 1 {
  split($0, num_basket, ",")
  getline # skip the next blank line
  next
}
/^$/ {
  num_boards++
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
  for (cur_drawn = 0; cur_drawn<length(num_basket); cur_drawn++) {
    drawn_nums[cur_drawn] = num_basket[cur_drawn]
    for (board = 0; board<=num_boards; board++) check_board(board) 
  }
}
