#!/usr/bin/awk -f

{
  values[NR] = $0
}
NR >= 4 {
  windowA = values[NR-3] + values[NR-2] + values[NR-1]
  windowB = values[NR-2] + values[NR-1] + values[NR]
  if (windowB - windowA > 0) incr++
}
END {
  print incr
}
