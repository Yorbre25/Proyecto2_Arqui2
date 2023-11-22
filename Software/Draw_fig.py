from PIL import Image, ImageDraw
import math

# Tamaño de la imagen
width, height = 640, 480

# Crear una nueva imagen blanca
image = Image.new("RGB", (width, height), "white")
draw = ImageDraw.Draw(image)
data_list = []
for i in range(360):
    data_list.append(int(math.cos((i*math.pi)/180)*100))

for i in range(360):
    data_list.append(int(math.sin((i*math.pi)/180)*100))

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
    num_points = 360  # Número de puntos para aproximar el círculo
    for i in range(num_points):
        x = center_x + int((radius * data_list[i])/100)
        y = center_y + int((radius * data_list[i+360])/100)
        draw.point((x, y), fill="black")

    """
    num_points = 6200  # Número de puntos para aproximar el círculo
    for i in range(num_points):
        angle = int(2000 * math.pi * i / num_points)
        x = center_x + int((radius * cos_list[angle])/1000)
        y = center_y + int((radius * sin_list[angle])/1000)
        draw.point((x, y), fill="black")
    """
def draw_triangle(vertices):
    for i in range(3):
        x1, y1 = vertices[i]
        x2, y2 = vertices[(i + 1) % 3]
        draw_line(x1, y1, x2, y2)

def draw_ellipse(center_x, center_y, a, b):
    num_points = 360  # Número de puntos para aproximar el círculo
    for i in range(num_points):
        x = center_x + int((a * data_list[i])/100)
        y = center_y + int((b * data_list[i+360])/100)
        draw.point((x, y), fill="black")


# Pared
draw_line(100, 200, 100, 450)
draw_line(500, 200, 500, 450)
draw_line(100, 200, 500, 200)
draw_line(100, 450, 500, 450)

# marcos de ventanas
draw_line(260, 130, 339, 130)
draw_line(300, 100, 300, 159)

draw_line(140, 275, 220, 275)
draw_line(180, 245, 180, 304)

draw_line(380, 275, 460, 275)
draw_line(420, 245, 420, 304)

# puerta
draw_line(250, 325, 250, 450)
draw_line(350, 325, 350, 450)
draw_line(250, 325, 350, 325)

# Techo 
draw_triangle([(100, 200), (500, 200), (300, 50)])

# doorknob
draw_circle(335, 390, 7)

# ventanas
draw_ellipse(300, 130, 40, 30)
draw_ellipse(180, 275, 40, 30)
draw_ellipse(420, 275, 40, 30)


# Guardar la imagen
image.save("custom_figure.png")