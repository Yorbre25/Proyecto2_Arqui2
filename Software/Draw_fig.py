from PIL import Image, ImageDraw
import math

# Tamaño de la imagen
width, height = 640, 480

# Crear una nueva imagen blanca
image = Image.new("RGB", (width, height), "white")
draw = ImageDraw.Draw(image)
cos_list = []
sin_list = []
for i in range(int(2000 * math.pi)+1):
    cos_list.append(int(math.cos(i)*1000))
    sin_list.append(int(math.sin(i)*1000))

def draw_line(x1, y1, x2, y2):
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

def draw_circle(center_x, center_y, radius):
    # Algoritmo CORDIC para dibujar un círculo
    num_points = 6200  # Número de puntos para aproximar el círculo
    for i in range(num_points):
        angle = int(2000 * math.pi * i / num_points)
        x = center_x + int((radius * cos_list[angle])/1000)
        y = center_y + int((radius * sin_list[angle])/1000)
        draw.point((x, y), fill="black")

def draw_triangle(vertices):
    for i in range(3):
        x1, y1 = vertices[i]
        x2, y2 = vertices[(i + 1) % 3]
        draw_line(x1, y1, x2, y2)

def draw_eclipse(center_x, center_y, a, b):
    # Algoritmo para dibujar una elipse
    angle = 0
    while angle < 2000 * math.pi:
        x = center_x + (a * cos_list[angle])/1000
        y = center_y + (b * sin_list[angle])/1000
        draw.point((int(x), int(y)), fill="black")
        angle += 1  # Ajusta la precisión ajustando este valor

# Pared
draw_line(100, 200, 100, 450)
draw_line(500, 200, 500, 450)
draw_line(100, 200, 500, 200)
draw_line(100, 450, 500, 450)

# Techo 
draw_triangle([(100, 200), (500, 200), (300, 50)])

# puerta
draw_line(250, 325, 250, 450)
draw_line(350, 325, 350, 450)
draw_line(250, 325, 350, 325)

# doorknob
draw_circle(335, 390, 7)

# ventanas
draw_eclipse(300, 130, 40, 30)
draw_eclipse(180, 275, 40, 30)
draw_eclipse(420, 275, 40, 30)

# marcos de ventanas
draw_line(260, 130, 339, 130)
draw_line(300, 100, 300, 159)

draw_line(140, 275, 220, 275)
draw_line(180, 245, 180, 304)

draw_line(380, 275, 460, 275)
draw_line(420, 245, 420, 304)

# Guardar la imagen
image.save("custom_figure.png")