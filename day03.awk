#!/opt/homebrew/bin/gawk -f

BEGIN {
  FS=""
}

{
  for (i=1; i<=NF; i++) ones[i] += $i
}

END {
  for (i=1; i<=NF; i++) {
    bit = (ones[i] > NR / 2)
    gamma += 2^(NF-i) * bit
    epsilon += 2^(NF-i) * !bit
  }
  print gamma * epsilon
}
