/**
 * Author: Xiangyun Wang
 * 
 * Created Date: 2021-05-28
 * 
 * Description: This file is used to calculate the lane shift of PI step in SHA3
 * 
 **/

#include <stdio.h>

int main(){

    int output[5][5][2] = {0}; 

    for (int i = 0; i<5; i++){
        for (int j = 0; j<5; j++){
            output[i][j][0] = j;
            output[i][j][1] = (2*i+3*j)%5;
            printf("lane (%d, %d) is moved to: (%d, %d)\n", i,j,output[i][j][0],output[i][j][1]);
        }
    }

    return 0;
}