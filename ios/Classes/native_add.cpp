#include <stdint.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <algorithm>
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

uint8_t
clamp(int32_t number, int16_t min, int16_t max)
{
    if (number > max)
        return max;
    if (number < min)
        return min;
    return number;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
change_brightness(uint8_t *bitmap, uint32_t length, int16_t brightness)
{
    for (int i = 0; i < length; i += 4)
    {
        uint8_t red = bitmap[i];
        uint8_t green = bitmap[i + 1];
        uint8_t blue = bitmap[i + 2];

        bitmap[i] = clamp(red + brightness);
        bitmap[i + 1] = clamp(green + brightness);
        bitmap[i + 2] = clamp(blue + brightness);
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

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
invert(uint8_t *bitmap, uint32_t length)
{
    for (int i = 0; i < length; i += 4)
    {
        float red = bitmap[i] * -1;
        float green = bitmap[i + 1] * -1;
        float blue = bitmap[i + 2] * -1;

        bitmap[i] = clamp(red + 255);
        bitmap[i + 1] = clamp(green + 255);
        bitmap[i + 2] = clamp(blue + 255);
    }
    return bitmap;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
apply_threshold(uint8_t *bitmap, uint32_t length, int16_t threshold)
{
    for (int i = 0; i < length; i += 4)
    {
        uint8_t red = bitmap[i];
        uint8_t green = bitmap[i + 1];
        uint8_t blue = bitmap[i + 2];

        if (red != green || green != blue || blue != red)
        {
            return bitmap;
        }

        if (red > threshold)
        {
            bitmap[i] = 255;
            bitmap[i + 1] = 255;
            bitmap[i + 2] = 255;
        }
        else
        {
            bitmap[i] = 0;
            bitmap[i + 1] = 0;
            bitmap[i + 2] = 0;
        }
    }
    return bitmap;
}

uint8_t
get_solarized_color(uint8_t number, int *colors, uint8_t levels)
{
    for (int i = 0; i < levels; i++)
    {
        if (number < colors[i])
        {
            int middle = colors[i] / 2;
            uint8_t color;
            if (number > middle)
                color = colors[i];
            else
                color = colors[i - 1];

            return clamp(color);
        }
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
change_contrast_gray(uint8_t *bitmap, uint32_t length, int16_t contrast)
{
    for (int i = 0; i < length; i += 4)
    {
        uint8_t red = bitmap[i];
        uint8_t green = bitmap[i + 1];
        uint8_t blue = bitmap[i + 2];

        if (red >= 128)
        {
            bitmap[i] = clamp(red + contrast, 128, 255);
        }
        else
        {
            bitmap[i] = clamp(red - contrast, 0, 127);
        }
        if (green >= 128)
        {
            bitmap[i + 1] = clamp(green + contrast, 128, 255);
        }
        else
        {
            bitmap[i + 1] = clamp(green - contrast, 0, 127);
        }
        if (blue >= 128)
        {
            bitmap[i + 2] = clamp(blue + contrast, 128, 255);
        }
        else
        {
            bitmap[i + 2] = clamp(blue - contrast, 0, 127);
        }
    }
    return bitmap;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
filter_channel(uint8_t *bitmap, uint32_t length, uint8_t *filters)
{
    for (int i = 0; i < length; i += 4)
    {
        uint8_t red = bitmap[i];
        uint8_t green = bitmap[i + 1];
        uint8_t blue = bitmap[i + 2];

        if (red < filters[0] || red > filters[1])
        {
            bitmap[i] = 0;
        }
        if (green < filters[2] || green > filters[3])
        {
            bitmap[i + 1] = 0;
        }
        if (blue < filters[4] || blue > filters[5])
        {
            bitmap[i + 2] = 0;
        }
    }
    return bitmap;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
filter_color(uint8_t *bitmap, uint32_t length, uint8_t *filters)
{
    for (int i = 0; i < length; i += 4)
    {
        uint8_t red = bitmap[i];
        uint8_t green = bitmap[i + 1];
        uint8_t blue = bitmap[i + 2];

        if (red < filters[0] || red > filters[1])
        {
            bitmap[i] = 0;
            bitmap[i + 1] = 0;
            bitmap[i + 2] = 0;
        }
        if (green < filters[2] || green > filters[3])
        {
            bitmap[i] = 0;
            bitmap[i + 1] = 0;
            bitmap[i + 2] = 0;
        }
        if (blue < filters[4] || blue > filters[5])
        {
            bitmap[i] = 0;
            bitmap[i + 1] = 0;
            bitmap[i + 2] = 0;
        }
    }
    return bitmap;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
change_color(uint8_t *bitmap, uint32_t length, int16_t *colors)
{
    for (int i = 0; i < length; i += 4)
    {
        uint8_t red = bitmap[i];
        uint8_t green = bitmap[i + 1];
        uint8_t blue = bitmap[i + 2];

        bitmap[i] = clamp(red + colors[0]);
        bitmap[i + 1] = clamp(green + colors[1]);
        bitmap[i + 2] = clamp(blue + colors[2]);
    }
    return bitmap;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
change_tone(uint8_t *bitmap, uint32_t length, int16_t tone)
{
    for (int i = 0; i < length; i += 4)
    {
        uint8_t red = bitmap[i];
        uint8_t green = bitmap[i + 1];
        uint8_t blue = bitmap[i + 2];

        if (tone > 0)
        {
            bitmap[i] = red - (tone / 2);
            bitmap[i + 1] = green - (tone / 2);
            bitmap[i + 2] = blue + tone;
        }
        else
        {
            bitmap[i] = red + tone;
            bitmap[i + 1] = green - (tone / 2);
            bitmap[i + 2] = blue - (tone / 2);
        }
    }
    return bitmap;
}

double *
rgbToHsv(uint8_t *rgb)
{
    double red = rgb[0] / 255;
    double green = rgb[1] / 255;
    double blue = rgb[2] / 255;

    double cmax = green;
    double cmin = blue;

    if (green > blue && green > red)
        cmax = green;
    else if (blue > green && blue > red)
        cmax = blue;
    else if (red > green && red > blue)
        cmax = red;

    if (green < blue && green < red)
        cmin = green;
    else if (blue < green && blue < red)
        cmin = blue;
    else if (red < green && red < blue)
        cmin = red;

    double diff = cmax - cmin;
    double h = -1, s = -1;

    double v = cmax;

    if (v == 0)
        s = 0;
    else
        s = diff / cmax;

    if (red == green && green == blue)
        h = 0;
    else if (v == red)
        h = 60 * ((int)((green - blue) * diff) % 6);
    else if (v == green)
        h = ((60 * (blue - red)) * diff) + 2;
    else if (v == blue)
        h = ((60 * (red - green)) * diff) + 4;

    if (h < 0)
        h = h + 360;

    double hsv[3] = {h, s, v};
    return hsv;
}

uint8_t *
hsvToRgb(double *hsv)
{
    double h = hsv[0];
    float s = hsv[1] / 100;
    float v = hsv[2] / 100;
    float C = s * v;
    float X = C * (1 - abs(fmod(h / 60.0, 2) - 1));
    float m = v - C;
    float r, g, b;
    if (h >= 0 && h < 60)
    {
        r = C, g = X, b = 0;
    }
    else if (h >= 60 && h < 120)
    {
        r = X, g = C, b = 0;
    }
    else if (h >= 120 && h < 180)
    {
        r = 0, g = C, b = X;
    }
    else if (h >= 180 && h < 240)
    {
        r = 0, g = X, b = C;
    }
    else if (h >= 240 && h < 300)
    {
        r = X, g = 0, b = C;
    }
    else
    {
        r = C, g = 0, b = X;
    }

    uint8_t rgb[3] = {
        (uint8_t)std::round((r + m) * 255),
        (uint8_t)std::round((g + m) * 255),
        (uint8_t)std::round((b + m) * 255)};

    return rgb;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
change_hue(uint8_t *bitmap, uint32_t length, double hue)
{
    for (int i = 0; i < length; i += 4)
    {
        uint8_t rgbAux[3] = {bitmap[i], bitmap[i + 1], bitmap[i + 2]};
        double *hsv = rgbToHsv(rgbAux);
        // uint8_t *rgb = hsvToRgb(hsv);
        bitmap[i] = clamp(hsv[0] + hue);
        bitmap[i + 1] = clamp((uint8_t)(hsv[1] * 255));
        bitmap[i + 2] = clamp((uint8_t)(hsv[2] * 255));
    }
    return bitmap;
}

int32_t
get_kernel_norm(int32_t *kernel)
{
    int32_t sum = 0;
    for (int y = 0; y < 9; y++)
    {
        sum += kernel[y];
    }
    return sum;
}

uint8_t *
apply_convolutional_filter(uint8_t *bitmap, uint32_t width, uint32_t height, int32_t *kernel)
{
    int32_t norm = get_kernel_norm(kernel);

    for (int y = width * 4; y < (width * 4) * (height - 1); y += width * 4)
    {
        for (int x = y + 4; x < y - 4 + (width * 4); x += 4)
        {
            uint8_t red = bitmap[x];
            uint8_t green = bitmap[x + 1];
            uint8_t blue = bitmap[x + 2];

            // if (red != green || green != blue || blue != red)
            // {
            //     return bitmap;
            // }

            float new_color = 0;

            uint8_t top_left_red = bitmap[x - (width * 4) - 4];
            uint8_t top_left_green = bitmap[x + 1 - (width * 4) - 4];
            uint8_t top_left_blue = bitmap[x + 2 - (width * 4) - 4];
            new_color += kernel[0] * top_left_red;

            uint8_t top_red = bitmap[x - (width * 4)];
            uint8_t top_green = bitmap[x + 1 - (width * 4)];
            uint8_t top_blue = bitmap[x + 2 - (width * 4)];
            new_color += kernel[1] * top_red;

            uint8_t top_right_red = bitmap[x - (width * 4) + 4];
            uint8_t top_right_green = bitmap[x + 1 - (width * 4) + 4];
            uint8_t top_right_blue = bitmap[x + 2 - (width * 4) + 4];
            new_color += kernel[2] * top_right_red;

            uint8_t left_red = bitmap[x - 4];
            uint8_t left_green = bitmap[x + 1 - 4];
            uint8_t left_blue = bitmap[x + 2 - 4];
            new_color += kernel[3] * left_red;

            new_color += kernel[4] * red;

            uint8_t right_red = bitmap[x + 4];
            uint8_t right_green = bitmap[x + 1 + 4];
            uint8_t right_blue = bitmap[x + 2 + 4];
            new_color += kernel[5] * right_red;

            uint8_t bottom_left_red = bitmap[x + (width * 4) - 4];
            uint8_t bottom_left_green = bitmap[x + 1 + (width * 4) - 4];
            uint8_t bottom_left_blue = bitmap[x + 2 - (width * 4) - 4];
            new_color += kernel[6] * bottom_left_red;

            uint8_t bottom_red = bitmap[x + (width * 4)];
            uint8_t bottom_green = bitmap[x + 1 + (width * 4)];
            uint8_t bottom_blue = bitmap[x + 2 + (width * 4)];
            new_color += kernel[7] * bottom_red;

            uint8_t bottom_right_red = bitmap[x + (width * 4) + 4];
            uint8_t bottom_right_green = bitmap[x + 1 + (width * 4) + 4];
            uint8_t bottom_right_blue = bitmap[x + 2 + (width * 4) + 4];
            new_color += kernel[8] * bottom_right_red;

            if (norm > 0)
            {
                new_color = new_color / norm;
            }

            bitmap[x] = clamp(std::round(new_color));
            bitmap[x + 1] = clamp(std::round(new_color));
            bitmap[x + 2] = clamp(std::round(new_color));
        }
    }
    return bitmap;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint8_t *
apply_sobel_filter(uint8_t *bitmap, uint32_t width, uint32_t height)
{
    int32_t kernel[9] = {1, 2, 1, 2, 4, 2, 1, 2, 1};
    return apply_convolutional_filter(bitmap, width, height, kernel);
}
