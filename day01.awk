#!/usr/bin/awk -f

{
  if (prev > 0 && $0 > prev) incr++
  prev = $0
}
END {
  print incr
}
