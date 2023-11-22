from PIL import Image, ImageDraw
import math

# Tamaño de la imagen
width, height = 640, 480

# Crear una nueva imagen blanca
image = Image.new("RGB", (width, height), "white")
draw = ImageDraw.Draw(image)

# Centro y radio del círculo
center_x, center_y = width // 2, height // 2
radius = 100
cos_list = []
sin_list = []
for i in range(int(2000 * math.pi)+1):
    cos_list.append(int(math.cos(i)*1000))
    sin_list.append(int(math.sin(i)*1000))

# Algoritmo CORDIC para dibujar un círculo
num_points = 6200  # Número de puntos para aproximar el círculo

for i in range(num_points):
    angle = int(2000 * math.pi * i / num_points)
    x = center_x + int((radius * cos_list[angle])/1000)
    y = center_y + int((radius * sin_list[angle])/1000)
    draw.point((x, y), fill="black")

# Guardar la imagen
image.save("circle.png")