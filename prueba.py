import math


def generate_mif_file(data, file_name):
    with open(file_name, 'w') as mif_file:
        mif_file.write(f'''DEPTH = {len(data)};
WIDTH = 10;
ADDRESS_RADIX = DEC;
DATA_RADIX = HEX;

CONTENT BEGIN\n''')

        for address, value in enumerate(data):
            mif_file.write(f'{address} : {value:04X};\n')

        mif_file.write("END;")
    print(f"MIF file '{file_name}' has been generated with the given data.")

# Example list of integers (you can replace this with your own list)
data_list = []
for i in range(360):
    data_list.append(int(math.cos((i*math.pi)/180)*1000))

for i in range(360):
    data_list.append(int(math.sin((i*math.pi)/180)*1000))

# Define the filename for the MIF file
mif_filename = 'memory_initialization_file.mif'

# Generate the MIF file
generate_mif_file(data_list, mif_filename)