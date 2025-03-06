from PIL import Image

if __name__ == '__main__':
    palette = [
        180, 190, 254,
        166, 173, 200,
        147, 153, 178,
        127, 132, 156,
        108, 112, 134,
        88, 91, 112,
        69, 71, 90,
        49, 50, 68,
        30, 30, 46,
        24, 24, 37,
        17, 17, 27,
    ]

    img = Image.open('/home/edudscrc/Downloads/deathmetal.jpg')
    
    p_img = Image.new('P', (16, 16))
    p_img.putpalette(palette)

    conv = img.quantize(palette=p_img, dither=0)
    conv.show()

