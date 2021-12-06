#!/opt/homebrew/bin/gawk -f

{
  split($1, one, ",")
  split($3, two, ",")
  x1=one[1]
  y1=one[2]
  x2=two[1]
  y2=two[2]

  if (x1 != x2 && y1 != y2) next

  if (y1 == y2 && x1 < x2) for (i = x1; i <= x2; i++) grid[i, y1] += 1
  if (y1 == y2 && x1 > x2) for (i = x2; i <= x1; i++) grid[i, y1] += 1
  if (x1 == x2 && y1 < y2) for (i = y1; i <= y2; i++) grid[x1, i] += 1
  if (x1 == x2 && y1 > y2) for (i = y2; i <= y1; i++) grid[x1, i] += 1
}

END {
  for (i in grid) {
    split(i,s,SUBSEP)
    total += (grid[s[1], s[2]] > 1) ? 1 : 0
  }
  print total
}
