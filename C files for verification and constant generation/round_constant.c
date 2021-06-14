/**
 * Author: Yicheng Song
 * 
 * Created Date: 2021-05-28
 * 
 * Description: This file is used to calculate round constants of round function
 * 
 **/
 
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

uint64_t rc(int t)
{
    uint64_t result = 0x1;

    for (int i = 1; i <= t; i++)
    {
        result <<= 1;
        if (result & 0x100)
            result ^= 0x71;
    }

    return result & 0x1;
}

int main(void)
{
    for (int i = 0; i < 18; i++)
    {
        uint64_t result = 0x0;
        uint64_t shift = 1;
        for (int j = 0; j < 4; j++)
        {
            uint64_t value = rc(7*i + j);
            result |=  value << (shift - 1);
            shift *= 2;
        }            
        printf("0x%02" PRIx64 "\n", result);
    }
}   