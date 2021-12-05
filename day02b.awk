#!/opt/homebrew/bin/gawk -f

{
  action = $1
  count = $2
  
  switch (action) {
  case "forward":
    position += count
    depth += aim * count
    break
  case "down":
    aim += count
    break
  case "up":
    aim -= count
    break
  }
}
END {
  print position * depth
}

