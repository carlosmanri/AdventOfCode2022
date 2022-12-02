with open('input.txt') as f:
    lines = [line.rstrip() for line in f]

# indexes of  ""  
indexes = [index + 1 for index, line in enumerate(lines) if line == ""]

# Group by elf
elves = [lines[i:j-1] for i, j in zip([0] + indexes, indexes)]

# Cast to ints
elves = [[int(kcal) for kcal in elf] for elf in elves]

res = max([sum(elf) for elf in elves])

print("El elfo más calórico es el :" + str(res))    
