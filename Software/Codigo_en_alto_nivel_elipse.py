from PIL import Image, ImageDraw
import math

# Tamaño de la imagen
width, height = 640, 480

# Crear una nueva imagen blanca
image = Image.new("RGB", (width, height), "white")
draw = ImageDraw.Draw(image)

# Centro y semiejes de la elipse
center_x, center_y = width // 2, height // 2
a = 200  # Semieje mayor
b = 100  # Semieje menor

#SENO Y COSENO TAMBIEN DEBEN SER PRECALCULADAS COMO TABLAS
cos_list = []
sin_list = []
for i in range(int(2000 * math.pi)+1):
    cos_list.append(int(math.cos(i)*1000))
    sin_list.append(int(math.sin(i)*1000))

# Algoritmo para dibujar una elipse
angle = 0
while angle < 2000 * math.pi:
    x = center_x + (a * cos_list[angle])/1000
    y = center_y + (b * sin_list[angle])/1000
    draw.point((int(x), int(y)), fill="black")
    angle += 1  # Ajusta la precisión ajustando este valor

# Guardar la imagen
image.save("ellipse.png")