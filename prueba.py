import math
def twos_complement(val, num_bits):
    if val >= 0:
        return format(val, f'0{num_bits}b')
    else:
        return format((1 << num_bits) + val, f'0{num_bits}b')

def generate_mif_file(data, file_name):
    memory_width = 66
    elements_per_memory_position = 6

    with open(file_name, 'w') as mif_file:
        mif_file.write(f'''DEPTH = {len(data) // elements_per_memory_position};\nWIDTH = {memory_width};\nADDRESS_RADIX = DEC;\nDATA_RADIX = HEX;\nCONTENT BEGIN\n''')

        for i in range(0, len(data), elements_per_memory_position):
            mem_content = ''
            for j in range(elements_per_memory_position):
                if i + j < len(data):
                    mem_content = f"{twos_complement(data[i + j], 11)}" + mem_content  # Concatenating each 10-bit element in reverse order

            mif_file.write(f"{i // elements_per_memory_position} : {mem_content.upper()};\n")

        mif_file.write("END;")
    print(f"MIF file '{file_name}' has been generated with the given data.")

# Example list of integers (you can replace this with your own list)
data_list = []
#for i in range(360):
#    data_list.append(int(math.cos((i*math.pi)/180)*1000))

for i in range(360):
    data_list.append(int(math.sin((i*math.pi)/180)*1000))

# Define the filename for the MIF file
mif_filename = 'memory_initialization_file_sin.mif'

# Generate the MIF file
generate_mif_file(data_list, mif_filename)