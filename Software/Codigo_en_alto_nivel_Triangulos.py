from PIL import Image, ImageDraw

# Tamaño de la imagen
width, height = 640, 480

# Crear una nueva imagen blanca
image = Image.new("RGB", (width, height), "white")
draw = ImageDraw.Draw(image)

# Definir los vértices del triángulo
vertices = [(200, 100), (400, 100), (300, 300)]

# Algoritmo de Bresenham para trazar un triángulo
def draw_line(x1, y1, x2, y2):
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

# Dibujar las líneas del triángulo
for i in range(3):
    x1, y1 = vertices[i]
    x2, y2 = vertices[(i + 1) % 3]
    draw_line(x1, y1, x2, y2)

# Guardar la imagen
image.save("triangle.png")