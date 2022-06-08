#include <stdint.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <cmath>

using namespace std;

uint8_t
clamp(int32_t number)
{
    if (number > 255)
        return 255;
    if (number < 0)
        return 0;
    return number;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t
native_add(int32_t x, int32_t y)
{
    return x + y;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
change_brightness(uint8_t *bitmap, int16_t brightness, uint32_t length)
{
    for (int i = 0; i < length; i += 4)
    {
        bitmap[i] = clamp(bitmap[i] + brightness);
        bitmap[i + 1] = clamp(bitmap[i + 1] + brightness);
        bitmap[i + 2] = clamp(bitmap[i + 2] + brightness);
    }
    return bitmap;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
to_grayscale(uint8_t *bitmap, uint32_t length)
{
    for (int i = 0; i < length; i += 4)
    {
        float red = bitmap[i] * 0.299f;
        float green = bitmap[i + 1] * 0.587f;
        float blue = bitmap[i + 2] * 0.144f;

        float gray = std::round(red + green + blue);

        bitmap[i] = clamp(gray);
        bitmap[i + 1] = clamp(gray);
        bitmap[i + 2] = clamp(gray);
    }
    return bitmap;
}
