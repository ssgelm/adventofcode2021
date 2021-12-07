#!/opt/homebrew/bin/gawk -f

BEGIN {
  RS=","
  min_loc = 10000
}

{
  crabs[NR] = $1
  if ($1 < min_loc) min_loc = $1
  if ($1 > max_loc) max_loc = $1
}

END {
  for (i=min_loc; i<=max_loc; i++) {
    cost = 0
    for (c in crabs) cost += (crabs[c] > i) ? crabs[c]-i : i-crabs[c]
    if (cost < lowest_cost || lowest_cost == 0) lowest_cost = cost
  }
  print lowest_cost
}
