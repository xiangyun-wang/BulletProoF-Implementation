#include <stdio.h>
#include <math.h>

int main(){
    int buf_size = 64;
    int counter = 0;
    int counter_limit = buf_size/32;
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
    int sum[5][8] = {0};
    int sum_out[5][8] = {0};
    int cyclic_offset[5][5] = {{0,1,190,28,91},{36,300,6,55,276},{3,10,171,153,231},{105,45,15,21,136},{210,66,253,120,78}};
    int round_constant[18][8] = {{0,0,0,0,0,0,0,1},{1,0,0,0,0,0,1,0},{1,0,0,0,1,0,1,0},{0,0,0,0,0,0,0,0},{1,0,0,0,1,0,1,1},{0,0,0,0,0,0,0,1},{1,0,0,0,0,0,0,1},{0,0,0,0,1,0,0,1},{1,0,0,0,1,0,1,0},{1,0,0,0,1,0,0,0},{0,0,0,0,1,0,0,1},{0,0,0,0,1,0,1,0},{1,0,0,0,1,0,1,1},{1,0,0,0,1,0,1,1},{1,0,0,0,1,0,0,1},{0,0,0,0,0,0,1,1},{0,0,0,0,0,0,1,0},{1,0,0,0,0,0,0,0}};
    int padded[200] = {0};
    //printf("hello world");
    // parse

    int nvm_data[buf_size];
    nvm_data[31] = 1;
    nvm_data[32] = 1;

    
    
    while(counter < counter_limit){
      for (int i = 0; i<72; i++){
        padded[i] = nvm_data[i%32+counter*32];
      }
      while(round_count < 18){
        
        for (int i = 0; i < 5; i++){
          for (int j = 0; j<5; j++){
            for (int k = 0; k<8; k++){
              // first two planes are for R, others for C
              if(round_count==0){
                // iota out do xor with new input, to theta_in
                //printf("TEst test %d %d %d\n",i,j,k);
                theta_in[i][j][k] = iota_out[i][j][k] ^ padded[i*40+j*8+k];
              }else{
                //printf("another test %d %d %d\n",i,j,k);
                // copy iota out to theta_in
                theta_in[i][j][k] = iota_out[i][j][k];
              }
            }
          }
        }

      // printf("Round: %d\n", round_count);
      // for (int i = 0; i<5; i++){
      //    for (int j = 0; j<5; j++){
      //        for (int k = 0; k<8; k++){
      //            printf("%d,",theta_in[i][j][k]);
      //        }
      //    }
      // }
    printf("\n"); 

        
//-------------------------------------------------------------------------------------------------
        // theta
        //calculate the sum sheet
        for(int i = 0; i < 5; i++){
          for(int j = 0; j < 8; j++){
            sum[i][j] = theta_in[0][i][j]^theta_in[1][i][j]^theta_in[2][i][j]^theta_in[3][i][j]^theta_in[4][i][j];
            printf("%d",sum[i][j]);
          }
        }
         printf("\n");

        for(int i = 0; i < 5; i++){
          for(int j = 0; j < 5; j++){
            for(int k = 0; k < 8; k++){
              //right rotate k
              int k_1 = k + 1;
              if(k_1 == 8){
                k_1 = 0;
              }
              if(j == 0){
                theta_out[i][0][k] = theta_in[i][0][k] ^ (sum[4][k] ^ sum[1][k_1]);
                sum_out[j][k] = sum[4][k] ^ sum[1][k_1];
              }
              else if(j == 4){
                theta_out[i][4][k] = theta_in[i][4][k] ^ (sum[3][k] ^ sum[0][k_1]);
                sum_out[j][k] = sum[3][k] ^ sum[0][k_1];
              }
              else{
                theta_out[i][j][k] = theta_in[i][j][k] ^ (sum[j - 1][k] ^ sum[j + 1][k_1]);
                sum_out[j][k] = sum[j-1][k] ^ sum[j+1][k_1];
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
                      pi_out[(2*j+3*i)%5][i][k] = rho_out[i][j][k];
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

          

          
          // iota
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
          printf("Round %d\n",round_count);
        //for (int i = 0; i<5; i++){
         for (int j = 0; j<5; j++){
             for (int k = 0; k<8; k++){
                 printf("%d,",sum_out[j][k]);
             }
         }
      //}
      printf("\n");

//-----------------------------------------------------------------------------
        // printf("Round %d completed\n", round_count);
        // for (int i = 0; i<5; i++){
        //   for (int j = 0; j<5; j++){
        //     for (int k = 0; k<8; k++){
        //         printf("%d,",iota_out[i][j][k]);
        //     }
        //   }
        // }
        round_count++;
      }
      round_count = 0;
      counter++;
    }
    puts("final output");
    for (int i = 0; i<5; i++){
         for (int j = 0; j<5; j++){
             for (int k = 0; k<8; k++){
              printf("%d,",iota_out[i][j][k]);
             }
         }
     }
    printf("\n");

    return 0;
}
