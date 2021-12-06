#!/opt/homebrew/bin/gawk -f

BEGIN {
  FS=""
  RS=","
}

{
  fish[$1] += 1
}

END {
  for (i=0; i<256; i++) {
    for (f=0; f<=8; f++) fish[f-1] = fish[f]
    fish[6] += fish[-1]
    fish[8] = fish[-1]
  }

  for (f=0; f<=8; f++) sum += fish[f]
  print sum
}
