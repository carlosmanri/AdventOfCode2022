

input_file = open('input.txt', 'r')
output_file = open('input.dat', 'w')


lines = input_file.readlines()

for line in lines:
    pairs = line.split(",")
    lp = pairs[0].split("-")
    rp = pairs[1].split("-")
    output_file.write(str(lp[0]).zfill(2)+"    "+str(lp[1]).zfill(2)+"    "+str(rp[0]).zfill(2)+"    "+str(rp[1]).zfill(2))

input_file.close()
output_file.close()