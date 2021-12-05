#!/opt/homebrew/bin/gawk -f

BEGIN {
  FS=""
}

{
  oxygen_nums[NR] = $0
  co2_nums[NR] = $0
}

END {
  # Oxygen Generator Rating
  cur_bit = 1
  while (length(oxygen_nums) > 1) {
    ones = 0
    for (val in oxygen_nums) {
      ones += substr(oxygen_nums[val], cur_bit, 1)
    }
    most_common = (ones >= length(oxygen_nums) / 2)
    for (val in oxygen_nums) {
      if (substr(oxygen_nums[val], cur_bit, 1) != most_common) delete oxygen_nums[val]
    }
    cur_bit++
  }
  for (val in oxygen_nums) oxygen_bin = oxygen_nums[val]
  split(oxygen_bin, oxygen_bin_arr)
  for (i in oxygen_bin_arr) oxygen += 2^(NF-i) * oxygen_bin_arr[i]

  # CO2 Scrubber Rating
  cur_bit = 1
  while (length(co2_nums) > 1) {
    ones = 0
    for (val in co2_nums) {
      ones += substr(co2_nums[val], cur_bit, 1)
    }
    least_common = (ones < length(co2_nums) / 2)
    for (val in co2_nums) {
      if (substr(co2_nums[val], cur_bit, 1) != least_common) delete co2_nums[val]
    }
    cur_bit++
  }
  for (val in co2_nums) co2_bin = co2_nums[val]
  split(co2_bin, co2_bin_arr)
  for (i in co2_bin_arr) co2 += 2^(NF-i) * co2_bin_arr[i]

  print oxygen * co2
}
