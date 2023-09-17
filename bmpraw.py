from PIL import Image

# Função para converter uma cor RGB em um valor entre 0 e 255
def rgb_to_byte(color):
    # As 16 primeiras cores do modo de vídeo 13h
    colors_13h = [
        (0, 0, 0),       # Cor 0: Preto
        (16, 16, 16),     # Cor 1: Azul
        (32, 32, 32),     # Cor 2: Verde
        (48, 48, 48),   # Cor 3: Verde-azulado
        (64, 64, 64),     # Cor 4: Vermelho
        (80, 80, 80),   # Cor 5: Magenta
        (96, 96, 96),    # Cor 6: Marrom
        (112, 112, 112), # Cor 7: Cinza claro
        (128, 128, 128), # Cor 8: Cinza escuro
        (144, 144, 144),     # Cor 9: Azul brilhante
        (160, 160, 160),     # Cor 10: Verde brilhante
        (176, 176, 176),   # Cor 11: Verde-azulado brilhante
        (192, 192, 192),     # Cor 12: Vermelho brilhante
        (208, 208, 208),   # Cor 13: Magenta brilhante
        (240, 240, 240),   # Cor 14: Amarelo
        (255, 255, 255)  # Cor 15: Branco
    ]

    # Encontre a cor mais próxima na lista de cores 13h
    min_dist = float('inf')
    min_index = 0
    for i, c13h in enumerate(colors_13h):
        dist = sum((a - b) ** 2 for a, b in zip(color, c13h))
        if dist < min_dist:
            min_dist = dist
            min_index = i

    return min_index

# Carregue a imagem BMP de 16 cores
image = Image.open('output.bmp')

# Converta a imagem para tons de cinza para facilitar a correspondência de cores
#image = image.convert('')

# Crie uma lista para armazenar os valores de 0 a 255
values = []

# Percorra cada pixel da imagem
for pixel_value in image.getdata():
    # Converta o valor RGB do pixel em um valor entre 0 e 255
    value = rgb_to_byte((pixel_value, pixel_value, pixel_value))
    values.append(value)

# Salve os valores em um arquivo RAW
with open('output.raw', 'wb') as file:
    file.write(bytearray(values))

print("Conversão concluída. Os valores foram salvos em 'output.raw'.")

