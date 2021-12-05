#!/opt/homebrew/bin/gawk -f

{
  action = $1
  count = $2
  
  switch (action) {
  case "forward":
    position += count
    break
  case "down":
    depth += count
    break
  case "up":
    depth -= count
    break
  }
}
END {
  print position * depth
}

