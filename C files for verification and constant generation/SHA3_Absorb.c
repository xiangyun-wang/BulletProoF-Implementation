#include <stdio.h>
#include <math.h>

int main(){
    int buf_size = 72;
    int counter = 0;
    int counter_limit = buf_size/72;
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
    int sum[5][8] = {0}
    int cyclic_offset[5][5] = {{0,1,190,28,91},{36,300,6,55,276},{3,10,171,153,231},{105,45,15,21,136},{210,66,253,120,78}};
    int round_constant[18][8] = {{0,0,0,0,0,0,0,1},{1,0,0,0,0,0,1,0},{1,0,0,0,1,0,1,0},{0,0,0,0,0,0,0,0},{1,0,0,0,1,0,1,1},{0,0,0,0,0,0,0,1},{1,0,0,0,0,0,0,1},{0,0,0,0,1,0,0,1},{1,0,0,0,1,0,1,0},{1,0,0,0,1,0,0,0},{0,0,0,0,1,0,0,1},{0,0,0,0,1,0,1,0},{1,0,0,0,1,0,1,1},{1,0,0,0,1,0,1,1},{1,0,0,0,1,0,0,1},{0,0,0,0,0,0,1,1},{0,0,0,0,0,0,1,0},{1,0,0,0,0,0,0,0}};
    //printf("hello world");
    // parse

    int nvm_data[buf_size] = {0};
    nvm_data[31] = 1;
    nvm_data[63] = 1;

    while(counter < counter_limit){

      while(round_count < 18){

        for (int i = 0; i < 5; i++){
          for (int j = 0; j<5; j++){
            for (int k = 0; k<8; k++){
              // first two planes are for R, others for C
              if(((i=0&&j<5) || (i=1&&j<4))&&round_count==0){
                // iota out do xor with new input, to theta_in
                theta_in[i][j][k] = iota_out[i][j][k] ^ nvm_data[counter*72+i*40+j*8+k]
              }else{
                // copy iota out to theta_in
                theta_in[i][j][k] = iota_out[i][j][k];
              }
            }
          }
        }


//-------------------------------------------------------------------------------------------------
        // theta
        //calculate the sum sheet
        for(int i = 0; i < 5; i++){
          for(int j = 0; j < 8; j++){
            sum[i][j] = theta_in[i][0][j]^theta_in[i][1][j]^theta_in[i][2][j]^theta_in[i][3][j]^theta_in[i][4][j];
          }
        }

        for(int i = 0; i < 5; i++){
          for(int j = 0; j < 5; j++){
            for(int k = 0; k < 8; k++){
              //right rotate k
              int k_1 = k + 1;
              if(k_1 == 8){
                k_1 == 0;
              }
              if(i == 0){
                theta_out[0][j][k] = theta_in[0][j][k] ^ sum[4][k] ^ sum[1][k_1];
              }
              else if(i == 4){
                theta_out[4][j][k] = theta_in[4][j][k] ^ sum[3][k] ^ sum[0][k_1];
              }
              else{
                theta_out[i][j][k] = theta_in[i][j][k] ^ sum[i - 1][k] ^ sum[i + 1][k_1];
              }
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

//-----------------------------------------------------------------------------

        round_count++;
      }
      round_count = 0;
      councter++;
    }

    for (int i = 0; i<5; i++){
        for (int j = 0; j<5; j++){
            for (int k = 0; k<8; k++){
                printf("%d,",iota_out[i][j][k]);
            }
        }
    }


    return 0;
}
