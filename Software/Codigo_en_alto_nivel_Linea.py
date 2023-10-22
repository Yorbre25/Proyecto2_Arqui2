from PIL import Image, ImageDraw

# Tamaño de la imagen
width, height = 640, 480

# Crear una nueva imagen blanca
image = Image.new("RGB", (width, height), "white")
draw = ImageDraw.Draw(image)

# Puntos de inicio y fin de la línea
x1, y1 = 100, 100
x2, y2 = 500, 400

# Algoritmo de Bresenham para trazar una línea
dx = abs(x2 - x1)
dy = abs(y2 - y1)
sx = 1 if x2 >= x1 else -1
sy = 1 if y2 >= y1 else -1

if dx > dy:
    error = dx / 2
else:
    error = -dy / 2

while True:
    draw.point((x1, y1), fill="black")
    if x1 == x2 and y1 == y2:
        break
    e2 = error
    if e2 > -dx:
        error -= dy
        x1 += sx
    if e2 < dy:
        error += dx
        y1 += sy
        
# Guardar la imagen
image.save("line.png")