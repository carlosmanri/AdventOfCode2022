from functools import reduce

with open('input.txt') as f:
    lines = [line.rstrip() for line in f]

# indexes of  ""  
indexes = [index + 1 for index, line in enumerate(lines) if line == ""]

# Group by elf
elves = [lines[i:j-1] for i, j in zip([0] + indexes, indexes)]

# Cast to ints
elves = [[int(kcal) for kcal in elf] for elf in elves]

res = sum(sorted(([sum(elf) for elf in elves]), reverse=True)[:3])

print("Los tres elfos mas calóricos tienen: " + str(res))
       