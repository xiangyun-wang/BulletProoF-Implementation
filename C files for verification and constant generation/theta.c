/**
 * Author: Yicheng Song
 * 
 * Created Date: 2021-05-31
 * 
 * Description: This file is used to calculate the sum of columns
 * 
 **/
 
 #include<stdio.h>
 
 int main(){
	int theta_in[5][5][8];
	int theta_out[5][5][8] = {0};
	int sum[5][8] = {0}
	
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
				
				printf("%d", theta_out[i][j][k]);
			}
			printf("\n");
		}
	}
	
	
}