#include <stdio.h>
#include <math.h>

int main(){
    int round_count = 0;
    int input[200] = {0};
    int output[5][5][8] = {0};
    int theta_in[5][5][8] = {0};
    int theta_out[5][5][8] = {0};
    int rho_in[5][5][8] = {0};
    int rho_out[5][5][8] = {0};
    int pi_out[5][5][8] = {0};
    int chi_out[5][5][8] = {0};
    int iota_out[5][5][8] = {0};
    int cyclic_offset[5][5] = {{0,1,190,28,91},{36,300,6,55,276},{3,10,171,153,231},{105,45,15,21,136},{210,66,253,120,78}};
    int round_constant[18][8] = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},};
    printf("hello world");
    // parse
    for (int i = 0; i < 5; i++){
        for (int j = 0; j<5; j++){
            for (int k = 0; k<8; k++){
                theta_in[i][j][k] = input[i*40+j*8+k];                
            }
        }
    }

    // theta -- need to add
    for (int i = 0; i < 5; i++){
        for (int j = 0; j<5; j++){
            for (int k = 0; k<8; k++){
                theta_out[i][j][k] = theta_in[i][j][k];                
            }
        }
    }    
    // rho
    for (int i = 0; i <5; i++){
        for (int j = 0; j<5; j++){
            for (int k = 0; k<8; k++){
                rho_out[i][j][(k+cyclic_offset[i][j])%8] = theta_out[i][j][k];
            }
        }
    }
    //pi

    for (int i = 0; i<5; i++){
        for (int j = 0; j<5; j++){
            for (int k = 0; k<8; k++){
                pi_out[2*j+3*i][i][k] = rho_out[i][j][k];
            }
        }
    }

    //chi
    for (int i = 0; i<5; i++){
        for (int j = 0; j<5; j++){
            for (int k = 0; k<8; k++){
                chi_out[i][j][k] = pi_out[i][j][k] ^ (~ pi_out[i][(j+1)%5][k]) & pi_out[i][(j+2)%5][k];
            }
        }
    }

    for (int i = 0; i<5; i++){
        for (int j = 0; j<5; j++){
            for (int k = 0; k<8; k++){
                if(i==0 && j==0){
                    iota_out[i][j][k] = chi_out[i][j][k] ^ round_constant[round_count][k];
                }else{
                    iota_out[i][j][k] = chi_out[i][j][k];
                }
            }
        }
    }



    return 0;
}