

## This file is a general .xdc for the Arty A7-100 Rev. D
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


# Clock signal

#set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk_manual }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];


#Switches

set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports ICAP_msg_ready_debug]
#set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports Signal_Measure]
set_property -dict {PACKAGE_PIN C10 IOSTANDARD LVCMOS33} [get_ports enrollment_mode]
#set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { sw[3] }]; #IO_L14P_T2_SRCC_16 Sch=sw[3]


## LEDs

set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports debug_1]
#set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { LED[7] }]; #IO_L19N_T3_VREF_35 Sch=led0_g
#set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { led0_r }]; #IO_L19P_T3_35 Sch=led0_r
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports debug_2]
#set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { LED[6] }]; #IO_L21P_T3_DQS_35 Sch=led1_g
#set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { led1_r }]; #IO_L20N_T3_35 Sch=led1_r
#set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { led2_b }]; #IO_L21N_T3_DQS_35 Sch=led2_b
#set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports calibration_check_suc_debug]; #IO_L22N_T3_35 Sch=led2_g
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports calibration_check_fail_debug]
#set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { led3_b }]; #IO_L23P_T3_35 Sch=led3_b
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports calibration_check_suc_debug]
#set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports Measure_Fail]; #IO_L23N_T3_35 Sch=led3_r
set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports debug_3]; #IO_L24N_T3_35 Sch=led[4]
#set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { LED[1] }]; #IO_25_35 Sch=led[5]
#set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports Measure_TryNext]; #IO_L24P_T3_A01_D17_14 Sch=led[6]
#set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports Measure_Succeed]; #IO_L24N_T3_A00_D16_14 Sch=led[7]


##Buttons

set_property -dict {PACKAGE_PIN D9 IOSTANDARD LVCMOS33} [get_ports clk_manual]
#set_property -dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports Get_Calibrated_Points]; #IO_L11P_T1_SRCC_16 Sch=btn[1]
#set_property -dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports Get_Measurement]; #IO_L11N_T1_SRCC_16 Sch=btn[2]
#set_property -dict { PACKAGE_PIN B8    IOSTANDARD LVCMOS33 } [get_ports Cal_Next_Step]; #IO_L12P_T1_MRCC_16 Sch=btn[3]


##Pmod Headers


##Pmod Header JA

#set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { ja[1] }]; #IO_0_15 Sch=ja[1]
#set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { ja[2] }]; #IO_L4P_T0_15 Sch=ja[2]
#set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L4N_T0_15 Sch=ja[3]
#set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L6P_T0_15 Sch=ja[4]
#set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_L6N_T0_VREF_15 Sch=ja[7]
#set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { ja[8] }]; #IO_L10P_T1_AD11P_15 Sch=ja[8]
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { ja[9] }]; #IO_L10N_T1_AD11N_15 Sch=ja[9]
#set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { ja[10] }]; #IO_L11P_T1_SRCC_15 Sch=ja[10]


##Pmod Header JB

#set_property -dict { PACKAGE_PIN D15   IOSTANDARD LVCMOS33 } [get_ports { jb[1] }]; #IO_L12P_T1_MRCC_15 Sch=jb[1]
#set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { jb[2] }]; #IO_L12N_T1_MRCC_15 Sch=jb[2]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { jb[3] }]; #IO_L22N_T3_A16_15 Sch=jb[3]
#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { jb[4] }]; #IO_L23P_T3_FOE_B_15 Sch=jb[4]
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { jb[7] }]; #IO_L23N_T3_FWE_B_15 Sch=jb[7]
#set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { jb[8] }]; #IO_L24P_T3_RS1_15 Sch=jb[8]
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { jb[9] }]; #IO_L24N_T3_RS0_15 Sch=jb[9]
#set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { jb[10] }]; #IO_25_15 Sch=jb[10]


##Pmod Header JC

#set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { jc[1] }]; #IO_L20P_T3_A08_D24_14 Sch=jc[1]
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { jc[2] }]; #IO_L20N_T3_A07_D23_14 Sch=jc[2]
#set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { jc[3] }]; #IO_L21P_T3_DQS_14 Sch=jc[3]
#set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { jc[4] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=jc[4]
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { jc[7] }]; #IO_L22P_T3_A05_D21_14 Sch=jc[7]
#set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { jc[8] }]; #IO_L22N_T3_A04_D20_14 Sch=jc[8]
#set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { jc[9] }]; #IO_L23P_T3_A03_D19_14 Sch=jc[9]
#set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { jc[10] }]; #IO_L23N_T3_A02_D18_14 Sch=jc[10]


##Pmod Header JD

#set_property -dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports { jd[1] }]; #IO_L11N_T1_SRCC_35 Sch=jd[1]
#set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { jd[2] }]; #IO_L12N_T1_MRCC_35 Sch=jd[2]
#set_property -dict { PACKAGE_PIN F4    IOSTANDARD LVCMOS33 } [get_ports { jd[3] }]; #IO_L13P_T2_MRCC_35 Sch=jd[3]
#set_property -dict { PACKAGE_PIN F3    IOSTANDARD LVCMOS33 } [get_ports { jd[4] }]; #IO_L13N_T2_MRCC_35 Sch=jd[4]
#set_property -dict { PACKAGE_PIN E2    IOSTANDARD LVCMOS33 } [get_ports { jd[7] }]; #IO_L14P_T2_SRCC_35 Sch=jd[7]
#set_property -dict { PACKAGE_PIN D2    IOSTANDARD LVCMOS33 } [get_ports { jd[8] }]; #IO_L14N_T2_SRCC_35 Sch=jd[8]
#set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { jd[9] }]; #IO_L15P_T2_DQS_35 Sch=jd[9]
#set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { jd[10] }]; #IO_L15N_T2_DQS_35 Sch=jd[10]


##USB-UART Interface

#set_property -dict { PACKAGE_PIN D10   IOSTANDARD LVCMOS33 } [get_ports { uart_rxd_out }]; #IO_L19N_T3_VREF_16 Sch=uart_rxd_out
#set_property -dict { PACKAGE_PIN A9    IOSTANDARD LVCMOS33 } [get_ports { uart_txd_in }]; #IO_L14N_T2_SRCC_16 Sch=uart_txd_in


##ChipKit Signals

#ChipKit Single Ended Analog Inputs
#The ck_an_p pins can be used as single ended analog inputs with voltages from 0-3.3V (Chipkit Analog pins A0-A5). These signals
#should only be connected to the XADC core. When using these pins as digital I/O, use pins ck_io[14-19].

#set_property -dict { PACKAGE_PIN C5    IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[0] }]; #IO_L1N_T0_AD4N_35 Sch=ck_an_n[0]
#set_property -dict { PACKAGE_PIN C6    IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[0] }]; #IO_L1P_T0_AD4P_35 Sch=ck_an_p[0]
#set_property -dict { PACKAGE_PIN A5    IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[1] }]; #IO_L3N_T0_DQS_AD5N_35 Sch=ck_an_n[1]
#set_property -dict { PACKAGE_PIN A6    IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[1] }]; #IO_L3P_T0_DQS_AD5P_35 Sch=ck_an_p[1]
#set_property -dict { PACKAGE_PIN B4    IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[2] }]; #IO_L7N_T1_AD6N_35 Sch=ck_an_n[2]
#set_property -dict { PACKAGE_PIN C4    IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[2] }]; #IO_L7P_T1_AD6P_35 Sch=ck_an_p[2]
#set_property -dict { PACKAGE_PIN A1    IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[3] }]; #IO_L9N_T1_DQS_AD7N_35 Sch=ck_an_n[3]
#set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[3] }]; #IO_L9P_T1_DQS_AD7P_35 Sch=ck_an_p[3]
#set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[4] }]; #IO_L10N_T1_AD15N_35 Sch=ck_an_n[4]
#set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[4] }]; #IO_L10P_T1_AD15P_35 Sch=ck_an_p[4]
#set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[5] }]; #IO_L1N_T0_AD0N_15 Sch=ck_an_n[5]
#set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[5] }]; #IO_L1P_T0_AD0P_15 Sch=ck_an_p[5]

##ChipKit Digital I/O Low

set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {debug_v2[0]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {debug_v2[1]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {debug_v2[2]}]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {debug_v2[3]}]
#set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { Point_Sel[4] }]; #IO_L5P_T0_D06_14 Sch=ck_io[4]
#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { Point_Sel[5] }]; #IO_L14P_T2_SRCC_14 Sch=ck_io[5]
#set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { ck_io[6] }]; #IO_L14N_T2_SRCC_14 Sch=ck_io[6]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports clk_debug]

set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {debug_v1[0]}]
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports {debug_v1[1]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {debug_v1[2]}]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {debug_v1[3]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {debug_v1[4]}]
#set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { debug_v1[5] }]; #IO_L12P_T1_MRCC_14 Sch=ck_io[1]
##ChipKit Digital I/O On Outer Analog Header
##These pins should be used when using the analog header signals A0-A5 as digital I/O (Chipkit digital pins 14-19)

#set_property -dict { PACKAGE_PIN F5    IOSTANDARD LVCMOS33 } [get_ports { ck_io[14] }]; #IO_0_35 Sch=ck_a[0]
#set_property -dict { PACKAGE_PIN D8    IOSTANDARD LVCMOS33 } [get_ports { ck_io[15] }]; #IO_L4P_T0_35 Sch=ck_a[1]
#set_property -dict { PACKAGE_PIN C7    IOSTANDARD LVCMOS33 } [get_ports { ck_io[16] }]; #IO_L4N_T0_35 Sch=ck_a[2]
#set_property -dict { PACKAGE_PIN E7    IOSTANDARD LVCMOS33 } [get_ports { ck_io[17] }]; #IO_L6P_T0_35 Sch=ck_a[3]
#set_property -dict { PACKAGE_PIN D7    IOSTANDARD LVCMOS33 } [get_ports { ck_io[18] }]; #IO_L6N_T0_VREF_35 Sch=ck_a[4]
#set_property -dict { PACKAGE_PIN D5    IOSTANDARD LVCMOS33 } [get_ports { ck_io[19] }]; #IO_L11P_T1_SRCC_35 Sch=ck_a[5]

#ChipKit Digital I/O On Inner Analog Header
#Note: These pins will need to be connected to the XADC core when used as differential analog inputs (Chipkit analog pins A6-A11)

#set_property -dict { PACKAGE_PIN B7    IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[6]}]; #IO_L2P_T0_AD12P_35 Sch=ad_p[12]
#set_property -dict { PACKAGE_PIN B6    IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[6] }]; #IO_L2N_T0_AD12N_35 Sch=ad_n[12]
#set_property -dict { PACKAGE_PIN E6    IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[7] }]; #IO_L5P_T0_AD13P_35 Sch=ad_p[13]
#set_property -dict { PACKAGE_PIN E5    IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[7] }]; #IO_L5N_T0_AD13N_35 Sch=ad_n[13]
#set_property -dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[8] }]; #IO_L8P_T1_AD14P_35 Sch=ad_p[14]
#set_property -dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[8]  }]; #IO_L8N_T1_AD14N_35 Sch=ad_n[14]


##ChipKit Digital I/O High

set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {debug_delay[0]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {debug_delay[1]}]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {debug_delay[2]}]
set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {debug_delay[3]}]
set_property -dict {PACKAGE_PIN R11 IOSTANDARD LVCMOS33} [get_ports {debug_delay[4]}]
set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {debug_delay[5]}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {debug_delay[6]}]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {debug_delay[7]}]

#set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { ck_io[34] }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=ck_io[34]
#set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { ck_io[35] }]; #IO_L11N_T1_SRCC_14 Sch=ck_io[35]
#set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { ck_io[36] }]; #IO_L8P_T1_D11_14 Sch=ck_io[36]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { ck_io[37] }]; #IO_L17P_T2_A14_D30_14 Sch=ck_io[37]
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { ck_io[38] }]; #IO_L7N_T1_D10_14 Sch=ck_io[38]
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { ck_io[39] }]; #IO_L7P_T1_D09_14 Sch=ck_io[39]
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { ck_io[40] }]; #IO_L9N_T1_DQS_D13_14 Sch=ck_io[40]
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { ck_io[41] }]; #IO_L9P_T1_DQS_14 Sch=ck_io[41]

##Misc. ChipKit signals

#set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { ck_ioa }]; #IO_L10N_T1_D15_14 Sch=ck_ioa
#set_property -dict { PACKAGE_PIN C2    IOSTANDARD LVCMOS33 } [get_ports { ck_rst }]; #IO_L16P_T2_35 Sch=ck_rst

## ChipKit SPI

#set_property -dict { PACKAGE_PIN G1    IOSTANDARD LVCMOS33 } [get_ports { ck_miso }]; #IO_L17N_T2_35 Sch=ck_miso
#set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { ck_mosi }]; #IO_L17P_T2_35 Sch=ck_mosi
#set_property -dict { PACKAGE_PIN F1    IOSTANDARD LVCMOS33 } [get_ports { ck_sck }]; #IO_L18P_T2_35 Sch=ck_sck
#set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33 } [get_ports { ck_ss }]; #IO_L16N_T2_35 Sch=ck_ss


## ChipKit I2C

#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { ck_scl }]; #IO_L4P_T0_D04_14 Sch=ck_scl
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { ck_sda }]; #IO_L4N_T0_D05_14 Sch=ck_sda
#set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports { scl_pup }]; #IO_L9N_T1_DQS_AD3N_15 Sch=scl_pup
#set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS33 } [get_ports { sda_pup }]; #IO_L9P_T1_DQS_AD3P_15 Sch=sda_pup


##SMSC Ethernet PHY

#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { eth_col }]; #IO_L16N_T2_A27_15 Sch=eth_col
#set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { eth_crs }]; #IO_L15N_T2_DQS_ADV_B_15 Sch=eth_crs
#set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { eth_mdc }]; #IO_L14N_T2_SRCC_15 Sch=eth_mdc
#set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { eth_mdio }]; #IO_L17P_T2_A26_15 Sch=eth_mdio
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { eth_ref_clk }]; #IO_L22P_T3_A17_15 Sch=eth_ref_clk
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { eth_rstn }]; #IO_L20P_T3_A20_15 Sch=eth_rstn
#set_property -dict { PACKAGE_PIN F15   IOSTANDARD LVCMOS33 } [get_ports { eth_rx_clk }]; #IO_L14P_T2_SRCC_15 Sch=eth_rx_clk
#set_property -dict { PACKAGE_PIN G16   IOSTANDARD LVCMOS33 } [get_ports { eth_rx_dv }]; #IO_L13N_T2_MRCC_15 Sch=eth_rx_dv
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[0] }]; #IO_L21N_T3_DQS_A18_15 Sch=eth_rxd[0]
#set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[1] }]; #IO_L16P_T2_A28_15 Sch=eth_rxd[1]
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[2] }]; #IO_L21P_T3_DQS_15 Sch=eth_rxd[2]
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[3] }]; #IO_L18N_T2_A23_15 Sch=eth_rxd[3]
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { eth_rxerr }]; #IO_L20N_T3_A19_15 Sch=eth_rxerr
#set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { eth_tx_clk }]; #IO_L13P_T2_MRCC_15 Sch=eth_tx_clk
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { eth_tx_en }]; #IO_L19N_T3_A21_VREF_15 Sch=eth_tx_en
#set_property -dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS33 } [get_ports { eth_txd[0] }]; #IO_L15P_T2_DQS_15 Sch=eth_txd[0]
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { eth_txd[1] }]; #IO_L19P_T3_A22_15 Sch=eth_txd[1]
#set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { eth_txd[2] }]; #IO_L17N_T2_A25_15 Sch=eth_txd[2]
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { eth_txd[3] }]; #IO_L18P_T2_A24_15 Sch=eth_txd[3]


##Quad SPI Flash

#set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS33 } [get_ports { qspi_cs }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_cs
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]


##Power Analysis

#set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports { sns0v_n[95] }]; #IO_L8N_T1_AD10N_15 Sch=sns0v_n[95]
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports { sns0v_p[95] }]; #IO_L8P_T1_AD10P_15 Sch=sns0v_p[95]
#set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33 } [get_ports { sns5v_n[0] }]; #IO_L5N_T0_AD9N_15 Sch=sns5v_n[0]
#set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33 } [get_ports { sns5v_p[0] }]; #IO_L5P_T0_AD9P_15 Sch=sns5v_p[0]
#set_property -dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS33 } [get_ports { vsns5v[0] }]; #IO_L3P_T0_DQS_AD1P_15 Sch=vsns5v[0]
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports { vsnsvu }]; #IO_L7P_T1_AD2P_15 Sch=vsnsvu

#set_property LUT_REMAP 0 [get_cells MPSoffset/first]
set_property dont_touch true [get_cells -hier -filter {REF_NAME=~ LUT*}]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets Launch_IBUF]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets Get_Measurement_IBUF]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {Get_Calibrated_Points_IBUF}]
set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -of_objects [get_cells Ring_Osc/first]]
set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -of_objects [get_cells Ring_Osc/ro_loop[0].flip]]
set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -of_objects [get_cells Ring_Osc/ro_loop[1].flip]]
#set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -of_objects [get_cells Ring_Osc/counter0_0[0]]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_manual_IBUF]


# ROUTING CONFIGURATION
# MPS routing

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[1].BUF}]
set_property LOC SLICE_X28Y99 [get_cells {TDC_1/MPSoffset/MPS_path[1].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[2].BUF}]
set_property LOC SLICE_X28Y99 [get_cells {TDC_1/MPSoffset/MPS_path[2].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[3].BUF}]
set_property LOC SLICE_X28Y99 [get_cells {TDC_1/MPSoffset/MPS_path[3].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[4].BUF}]
set_property LOC SLICE_X28Y99 [get_cells {TDC_1/MPSoffset/MPS_path[4].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[5].BUF}]
set_property LOC SLICE_X28Y98 [get_cells {TDC_1/MPSoffset/MPS_path[5].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[6].BUF}]
set_property LOC SLICE_X28Y98 [get_cells {TDC_1/MPSoffset/MPS_path[6].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[7].BUF}]
set_property LOC SLICE_X28Y98 [get_cells {TDC_1/MPSoffset/MPS_path[7].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[8].BUF}]
set_property LOC SLICE_X28Y98 [get_cells {TDC_1/MPSoffset/MPS_path[8].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[9].BUF}]
set_property LOC SLICE_X28Y97 [get_cells {TDC_1/MPSoffset/MPS_path[9].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[10].BUF}]
set_property LOC SLICE_X28Y97 [get_cells {TDC_1/MPSoffset/MPS_path[10].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[11].BUF}]
set_property LOC SLICE_X28Y97 [get_cells {TDC_1/MPSoffset/MPS_path[11].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[12].BUF}]
set_property LOC SLICE_X28Y97 [get_cells {TDC_1/MPSoffset/MPS_path[12].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[13].BUF}]
set_property LOC SLICE_X28Y96 [get_cells {TDC_1/MPSoffset/MPS_path[13].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[14].BUF}]
set_property LOC SLICE_X28Y96 [get_cells {TDC_1/MPSoffset/MPS_path[14].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[15].BUF}]
set_property LOC SLICE_X28Y96 [get_cells {TDC_1/MPSoffset/MPS_path[15].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[16].BUF}]
set_property LOC SLICE_X28Y96 [get_cells {TDC_1/MPSoffset/MPS_path[16].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[17].BUF}]
set_property LOC SLICE_X28Y95 [get_cells {TDC_1/MPSoffset/MPS_path[17].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[18].BUF}]
set_property LOC SLICE_X28Y95 [get_cells {TDC_1/MPSoffset/MPS_path[18].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[19].BUF}]
set_property LOC SLICE_X28Y95 [get_cells {TDC_1/MPSoffset/MPS_path[19].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[20].BUF}]
set_property LOC SLICE_X28Y95 [get_cells {TDC_1/MPSoffset/MPS_path[20].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[21].BUF}]
set_property LOC SLICE_X28Y94 [get_cells {TDC_1/MPSoffset/MPS_path[21].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[22].BUF}]
set_property LOC SLICE_X28Y94 [get_cells {TDC_1/MPSoffset/MPS_path[22].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[23].BUF}]
set_property LOC SLICE_X28Y94 [get_cells {TDC_1/MPSoffset/MPS_path[23].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[24].BUF}]
set_property LOC SLICE_X28Y94 [get_cells {TDC_1/MPSoffset/MPS_path[24].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[25].BUF}]
set_property LOC SLICE_X28Y93 [get_cells {TDC_1/MPSoffset/MPS_path[25].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[26].BUF}]
set_property LOC SLICE_X28Y93 [get_cells {TDC_1/MPSoffset/MPS_path[26].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[27].BUF}]
set_property LOC SLICE_X28Y93 [get_cells {TDC_1/MPSoffset/MPS_path[27].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[28].BUF}]
set_property LOC SLICE_X28Y93 [get_cells {TDC_1/MPSoffset/MPS_path[28].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[29].BUF}]
set_property LOC SLICE_X28Y92 [get_cells {TDC_1/MPSoffset/MPS_path[29].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[30].BUF}]
set_property LOC SLICE_X28Y92 [get_cells {TDC_1/MPSoffset/MPS_path[30].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[31].BUF}]
set_property LOC SLICE_X28Y92 [get_cells {TDC_1/MPSoffset/MPS_path[31].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[32].BUF}]
set_property LOC SLICE_X28Y92 [get_cells {TDC_1/MPSoffset/MPS_path[32].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[33].BUF}]
set_property LOC SLICE_X28Y91 [get_cells {TDC_1/MPSoffset/MPS_path[33].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[34].BUF}]
set_property LOC SLICE_X28Y91 [get_cells {TDC_1/MPSoffset/MPS_path[34].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[35].BUF}]
set_property LOC SLICE_X28Y91 [get_cells {TDC_1/MPSoffset/MPS_path[35].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[36].BUF}]
set_property LOC SLICE_X28Y91 [get_cells {TDC_1/MPSoffset/MPS_path[36].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[37].BUF}]
set_property LOC SLICE_X28Y90 [get_cells {TDC_1/MPSoffset/MPS_path[37].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[38].BUF}]
set_property LOC SLICE_X28Y90 [get_cells {TDC_1/MPSoffset/MPS_path[38].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[39].BUF}]
set_property LOC SLICE_X28Y90 [get_cells {TDC_1/MPSoffset/MPS_path[39].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[40].BUF}]
set_property LOC SLICE_X28Y90 [get_cells {TDC_1/MPSoffset/MPS_path[40].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[41].BUF}]
set_property LOC SLICE_X28Y89 [get_cells {TDC_1/MPSoffset/MPS_path[41].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[42].BUF}]
set_property LOC SLICE_X28Y89 [get_cells {TDC_1/MPSoffset/MPS_path[42].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[43].BUF}]
set_property LOC SLICE_X28Y89 [get_cells {TDC_1/MPSoffset/MPS_path[43].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[44].BUF}]
set_property LOC SLICE_X28Y89 [get_cells {TDC_1/MPSoffset/MPS_path[44].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[45].BUF}]
set_property LOC SLICE_X28Y88 [get_cells {TDC_1/MPSoffset/MPS_path[45].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[46].BUF}]
set_property LOC SLICE_X28Y88 [get_cells {TDC_1/MPSoffset/MPS_path[46].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[47].BUF}]
set_property LOC SLICE_X28Y88 [get_cells {TDC_1/MPSoffset/MPS_path[47].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[48].BUF}]
set_property LOC SLICE_X28Y88 [get_cells {TDC_1/MPSoffset/MPS_path[48].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[49].BUF}]
set_property LOC SLICE_X28Y87 [get_cells {TDC_1/MPSoffset/MPS_path[49].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[50].BUF}]
set_property LOC SLICE_X28Y87 [get_cells {TDC_1/MPSoffset/MPS_path[50].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[51].BUF}]
set_property LOC SLICE_X28Y87 [get_cells {TDC_1/MPSoffset/MPS_path[51].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[52].BUF}]
set_property LOC SLICE_X28Y87 [get_cells {TDC_1/MPSoffset/MPS_path[52].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[53].BUF}]
set_property LOC SLICE_X28Y86 [get_cells {TDC_1/MPSoffset/MPS_path[53].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[54].BUF}]
set_property LOC SLICE_X28Y86 [get_cells {TDC_1/MPSoffset/MPS_path[54].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[55].BUF}]
set_property LOC SLICE_X28Y86 [get_cells {TDC_1/MPSoffset/MPS_path[55].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[56].BUF}]
set_property LOC SLICE_X28Y86 [get_cells {TDC_1/MPSoffset/MPS_path[56].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[57].BUF}]
set_property LOC SLICE_X28Y85 [get_cells {TDC_1/MPSoffset/MPS_path[57].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[58].BUF}]
set_property LOC SLICE_X28Y85 [get_cells {TDC_1/MPSoffset/MPS_path[58].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[59].BUF}]
set_property LOC SLICE_X28Y85 [get_cells {TDC_1/MPSoffset/MPS_path[59].BUF}]
set_property BEL A6LUT [get_cells {TDC_1/MPSoffset/MPS_path[60].BUF}]
set_property LOC SLICE_X28Y85 [get_cells {TDC_1/MPSoffset/MPS_path[60].BUF}]

set_property BEL D6LUT [get_cells {TDC_1/MPSoffset/MPS_path[61].BUF}]
set_property LOC SLICE_X28Y84 [get_cells {TDC_1/MPSoffset/MPS_path[61].BUF}]
set_property BEL C6LUT [get_cells {TDC_1/MPSoffset/MPS_path[62].BUF}]
set_property LOC SLICE_X28Y84 [get_cells {TDC_1/MPSoffset/MPS_path[62].BUF}]
set_property BEL B6LUT [get_cells {TDC_1/MPSoffset/MPS_path[63].BUF}]
set_property LOC SLICE_X28Y84 [get_cells {TDC_1/MPSoffset/MPS_path[63].BUF}]


set_property BEL C6LUT [get_cells TDC_1/MPSoffset/selection2_lut]
set_property LOC SLICE_X29Y92 [get_cells TDC_1/MPSoffset/selection2_lut]
set_property BEL D6LUT [get_cells TDC_1/MPSoffset/selection3_lut]
set_property LOC SLICE_X29Y92 [get_cells TDC_1/MPSoffset/selection3_lut]
set_property BEL B6LUT [get_cells TDC_1/MPSoffset/selection1_lut]
set_property LOC SLICE_X29Y92 [get_cells TDC_1/MPSoffset/selection1_lut]
set_property BEL A6LUT [get_cells TDC_1/MPSoffset/selection0_lut]
set_property LOC SLICE_X29Y92 [get_cells TDC_1/MPSoffset/selection0_lut]
set_property BEL A6LUT [get_cells TDC_1/MPSoffset/selection4_lut]
set_property LOC SLICE_X29Y91 [get_cells TDC_1/MPSoffset/selection4_lut]

# test path routing

set_property BEL D6LUT [get_cells TDC_1/testpath/SW1_0]
set_property LOC SLICE_X31Y99 [get_cells TDC_1/testpath/SW1_0]
set_property BEL C6LUT [get_cells TDC_1/testpath/SW1_1]
set_property LOC SLICE_X31Y99 [get_cells TDC_1/testpath/SW1_1]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[1].SWmap_0}]
set_property LOC SLICE_X31Y99 [get_cells {TDC_1/testpath/map_loop0[1].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[1].SWmap_1}]
set_property LOC SLICE_X31Y99 [get_cells {TDC_1/testpath/map_loop0[1].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[2].SWmap_0}]
set_property LOC SLICE_X31Y98 [get_cells {TDC_1/testpath/map_loop0[2].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[2].SWmap_1}]
set_property LOC SLICE_X31Y98 [get_cells {TDC_1/testpath/map_loop0[2].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[3].SWmap_0}]
set_property LOC SLICE_X31Y98 [get_cells {TDC_1/testpath/map_loop0[3].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[3].SWmap_1}]
set_property LOC SLICE_X31Y98 [get_cells {TDC_1/testpath/map_loop0[3].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[4].SWmap_0}]
set_property LOC SLICE_X31Y97 [get_cells {TDC_1/testpath/map_loop0[4].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[4].SWmap_1}]
set_property LOC SLICE_X31Y97 [get_cells {TDC_1/testpath/map_loop0[4].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[5].SWmap_0}]
set_property LOC SLICE_X31Y97 [get_cells {TDC_1/testpath/map_loop0[5].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[5].SWmap_1}]
set_property LOC SLICE_X31Y97 [get_cells {TDC_1/testpath/map_loop0[5].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[6].SWmap_0}]
set_property LOC SLICE_X31Y96 [get_cells {TDC_1/testpath/map_loop0[6].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[6].SWmap_1}]
set_property LOC SLICE_X31Y96 [get_cells {TDC_1/testpath/map_loop0[6].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[7].SWmap_0}]
set_property LOC SLICE_X31Y96 [get_cells {TDC_1/testpath/map_loop0[7].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[7].SWmap_1}]
set_property LOC SLICE_X31Y96 [get_cells {TDC_1/testpath/map_loop0[7].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[8].SWmap_0}]
set_property LOC SLICE_X31Y95 [get_cells {TDC_1/testpath/map_loop0[8].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[8].SWmap_1}]
set_property LOC SLICE_X31Y95 [get_cells {TDC_1/testpath/map_loop0[8].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[9].SWmap_0}]
set_property LOC SLICE_X31Y95 [get_cells {TDC_1/testpath/map_loop0[9].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[9].SWmap_1}]
set_property LOC SLICE_X31Y95 [get_cells {TDC_1/testpath/map_loop0[9].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[10].SWmap_0}]
set_property LOC SLICE_X31Y94 [get_cells {TDC_1/testpath/map_loop0[10].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[10].SWmap_1}]
set_property LOC SLICE_X31Y94 [get_cells {TDC_1/testpath/map_loop0[10].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[11].SWmap_0}]
set_property LOC SLICE_X31Y94 [get_cells {TDC_1/testpath/map_loop0[11].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[11].SWmap_1}]
set_property LOC SLICE_X31Y94 [get_cells {TDC_1/testpath/map_loop0[11].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[12].SWmap_0}]
set_property LOC SLICE_X31Y93 [get_cells {TDC_1/testpath/map_loop0[12].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[12].SWmap_1}]
set_property LOC SLICE_X31Y93 [get_cells {TDC_1/testpath/map_loop0[12].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[13].SWmap_0}]
set_property LOC SLICE_X31Y93 [get_cells {TDC_1/testpath/map_loop0[13].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[13].SWmap_1}]
set_property LOC SLICE_X31Y93 [get_cells {TDC_1/testpath/map_loop0[13].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[14].SWmap_0}]
set_property LOC SLICE_X31Y92 [get_cells {TDC_1/testpath/map_loop0[14].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[14].SWmap_1}]
set_property LOC SLICE_X31Y92 [get_cells {TDC_1/testpath/map_loop0[14].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[15].SWmap_0}]
set_property LOC SLICE_X31Y92 [get_cells {TDC_1/testpath/map_loop0[15].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[15].SWmap_1}]
set_property LOC SLICE_X31Y92 [get_cells {TDC_1/testpath/map_loop0[15].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[16].SWmap_0}]
set_property LOC SLICE_X31Y91 [get_cells {TDC_1/testpath/map_loop0[16].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[16].SWmap_1}]
set_property LOC SLICE_X31Y91 [get_cells {TDC_1/testpath/map_loop0[16].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[17].SWmap_0}]
set_property LOC SLICE_X31Y91 [get_cells {TDC_1/testpath/map_loop0[17].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[17].SWmap_1}]
set_property LOC SLICE_X31Y91 [get_cells {TDC_1/testpath/map_loop0[17].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[18].SWmap_0}]
set_property LOC SLICE_X31Y90 [get_cells {TDC_1/testpath/map_loop0[18].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[18].SWmap_1}]
set_property LOC SLICE_X31Y90 [get_cells {TDC_1/testpath/map_loop0[18].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[19].SWmap_0}]
set_property LOC SLICE_X31Y90 [get_cells {TDC_1/testpath/map_loop0[19].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[19].SWmap_1}]
set_property LOC SLICE_X31Y90 [get_cells {TDC_1/testpath/map_loop0[19].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[20].SWmap_0}]
set_property LOC SLICE_X31Y89 [get_cells {TDC_1/testpath/map_loop0[20].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[20].SWmap_1}]
set_property LOC SLICE_X31Y89 [get_cells {TDC_1/testpath/map_loop0[20].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[21].SWmap_0}]
set_property LOC SLICE_X31Y89 [get_cells {TDC_1/testpath/map_loop0[21].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[21].SWmap_1}]
set_property LOC SLICE_X31Y89 [get_cells {TDC_1/testpath/map_loop0[21].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[22].SWmap_0}]
set_property LOC SLICE_X31Y88 [get_cells {TDC_1/testpath/map_loop0[22].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[22].SWmap_1}]
set_property LOC SLICE_X31Y88 [get_cells {TDC_1/testpath/map_loop0[22].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[23].SWmap_0}]
set_property LOC SLICE_X31Y88 [get_cells {TDC_1/testpath/map_loop0[23].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[23].SWmap_1}]
set_property LOC SLICE_X31Y88 [get_cells {TDC_1/testpath/map_loop0[23].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[24].SWmap_0}]
set_property LOC SLICE_X31Y87 [get_cells {TDC_1/testpath/map_loop0[24].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[24].SWmap_1}]
set_property LOC SLICE_X31Y87 [get_cells {TDC_1/testpath/map_loop0[24].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[25].SWmap_0}]
set_property LOC SLICE_X31Y87 [get_cells {TDC_1/testpath/map_loop0[25].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[25].SWmap_1}]
set_property LOC SLICE_X31Y87 [get_cells {TDC_1/testpath/map_loop0[25].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[26].SWmap_0}]
set_property LOC SLICE_X31Y86 [get_cells {TDC_1/testpath/map_loop0[26].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[26].SWmap_1}]
set_property LOC SLICE_X31Y86 [get_cells {TDC_1/testpath/map_loop0[26].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[27].SWmap_0}]
set_property LOC SLICE_X31Y86 [get_cells {TDC_1/testpath/map_loop0[27].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[27].SWmap_1}]
set_property LOC SLICE_X31Y86 [get_cells {TDC_1/testpath/map_loop0[27].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[28].SWmap_0}]
set_property LOC SLICE_X31Y85 [get_cells {TDC_1/testpath/map_loop0[28].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[28].SWmap_1}]
set_property LOC SLICE_X31Y85 [get_cells {TDC_1/testpath/map_loop0[28].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[29].SWmap_0}]
set_property LOC SLICE_X31Y85 [get_cells {TDC_1/testpath/map_loop0[29].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[29].SWmap_1}]
set_property LOC SLICE_X31Y85 [get_cells {TDC_1/testpath/map_loop0[29].SWmap_1}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/map_loop0[30].SWmap_0}]
set_property LOC SLICE_X31Y84 [get_cells {TDC_1/testpath/map_loop0[30].SWmap_0}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/map_loop0[30].SWmap_1}]
set_property LOC SLICE_X31Y84 [get_cells {TDC_1/testpath/map_loop0[30].SWmap_1}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/map_loop0[31].SWmap_0}]
set_property LOC SLICE_X31Y84 [get_cells {TDC_1/testpath/map_loop0[31].SWmap_0}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/map_loop0[31].SWmap_1}]
set_property LOC SLICE_X31Y84 [get_cells {TDC_1/testpath/map_loop0[31].SWmap_1}]


set_property BEL A6LUT [get_cells {TDC_1/testpath/selection00_lut}]
set_property LOC SLICE_X33Y99 [get_cells {TDC_1/testpath/selection00_lut}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/selection10_lut}]
set_property LOC SLICE_X33Y98 [get_cells {TDC_1/testpath/selection10_lut}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/selection01_lut}]
set_property LOC SLICE_X33Y97 [get_cells {TDC_1/testpath/selection01_lut}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/selection11_lut}]
set_property LOC SLICE_X33Y96 [get_cells {TDC_1/testpath/selection11_lut}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/selection02_lut}]
set_property LOC SLICE_X33Y95 [get_cells {TDC_1/testpath/selection02_lut}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/selection12_lut}]
set_property LOC SLICE_X33Y94 [get_cells {TDC_1/testpath/selection12_lut}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/selection03_lut}]
set_property LOC SLICE_X33Y93 [get_cells {TDC_1/testpath/selection03_lut}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/selection13_lut}]
set_property LOC SLICE_X33Y92 [get_cells {TDC_1/testpath/selection13_lut}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/selection04_lut}]
set_property LOC SLICE_X33Y91 [get_cells {TDC_1/testpath/selection04_lut}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/selection14_lut}]
set_property LOC SLICE_X33Y90 [get_cells {TDC_1/testpath/selection14_lut}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/selection05_lut}]
set_property LOC SLICE_X33Y89 [get_cells {TDC_1/testpath/selection05_lut}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/selection15_lut}]
set_property LOC SLICE_X33Y88 [get_cells {TDC_1/testpath/selection15_lut}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/selection06_lut}]
set_property LOC SLICE_X33Y87 [get_cells {TDC_1/testpath/selection06_lut}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/selection16_lut}]
set_property LOC SLICE_X33Y86 [get_cells {TDC_1/testpath/selection16_lut}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/selection07_lut}]
set_property LOC SLICE_X33Y85 [get_cells {TDC_1/testpath/selection07_lut}]
set_property BEL D6LUT [get_cells {TDC_1/testpath/selection17_lut}]
set_property LOC SLICE_X33Y84 [get_cells {TDC_1/testpath/selection17_lut}]


set_property BEL D6LUT [get_cells {TDC_1/testpath/selection08_lut}]
set_property LOC SLICE_X35Y90 [get_cells {TDC_1/testpath/selection08_lut}]
set_property BEL B6LUT [get_cells {TDC_1/testpath/selection18_lut}]
set_property LOC SLICE_X35Y90 [get_cells {TDC_1/testpath/selection18_lut}]
set_property BEL C6LUT [get_cells {TDC_1/testpath/selection09_lut}]
set_property LOC SLICE_X35Y90 [get_cells {TDC_1/testpath/selection09_lut}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/selection19_lut}]
set_property LOC SLICE_X35Y90 [get_cells {TDC_1/testpath/selection19_lut}]

set_property BEL D6LUT [get_cells {TDC_1/testpath/selection010_lut}]
set_property LOC SLICE_X36Y90 [get_cells {TDC_1/testpath/selection010_lut}]
set_property BEL A6LUT [get_cells {TDC_1/testpath/selection110_lut}]
set_property LOC SLICE_X36Y90 [get_cells {TDC_1/testpath/selection110_lut}]

set_property BEL B6LUT [get_cells {TDC_1/testpath/out_lut}]
set_property LOC SLICE_X36Y90 [get_cells {TDC_1/testpath/out_lut}]

# carry chain



set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[0].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y68 [get_cells {TDC_1/carrychain/map_loop2_1[0].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[0].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y68 [get_cells {TDC_1/carrychain/map_loop2_1[0].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[0].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y68 [get_cells {TDC_1/carrychain/map_loop2_1[0].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[0].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y68 [get_cells {TDC_1/carrychain/map_loop2_1[0].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[1].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y69 [get_cells {TDC_1/carrychain/map_loop2_1[1].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[1].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y69 [get_cells {TDC_1/carrychain/map_loop2_1[1].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[1].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y69 [get_cells {TDC_1/carrychain/map_loop2_1[1].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[1].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y69 [get_cells {TDC_1/carrychain/map_loop2_1[1].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[2].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y70 [get_cells {TDC_1/carrychain/map_loop2_1[2].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[2].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y70 [get_cells {TDC_1/carrychain/map_loop2_1[2].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[2].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y70 [get_cells {TDC_1/carrychain/map_loop2_1[2].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[2].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y70 [get_cells {TDC_1/carrychain/map_loop2_1[2].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[3].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y71 [get_cells {TDC_1/carrychain/map_loop2_1[3].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[3].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y71 [get_cells {TDC_1/carrychain/map_loop2_1[3].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[3].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y71 [get_cells {TDC_1/carrychain/map_loop2_1[3].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[3].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y71 [get_cells {TDC_1/carrychain/map_loop2_1[3].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[4].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y72 [get_cells {TDC_1/carrychain/map_loop2_1[4].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[4].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y72 [get_cells {TDC_1/carrychain/map_loop2_1[4].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[4].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y72 [get_cells {TDC_1/carrychain/map_loop2_1[4].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[4].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y72 [get_cells {TDC_1/carrychain/map_loop2_1[4].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[5].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y73 [get_cells {TDC_1/carrychain/map_loop2_1[5].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[5].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y73 [get_cells {TDC_1/carrychain/map_loop2_1[5].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[5].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y73 [get_cells {TDC_1/carrychain/map_loop2_1[5].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[5].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y73 [get_cells {TDC_1/carrychain/map_loop2_1[5].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[6].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y74 [get_cells {TDC_1/carrychain/map_loop2_1[6].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[6].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y74 [get_cells {TDC_1/carrychain/map_loop2_1[6].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[6].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y74 [get_cells {TDC_1/carrychain/map_loop2_1[6].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[6].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y74 [get_cells {TDC_1/carrychain/map_loop2_1[6].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[7].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y75 [get_cells {TDC_1/carrychain/map_loop2_1[7].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[7].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y75 [get_cells {TDC_1/carrychain/map_loop2_1[7].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[7].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y75 [get_cells {TDC_1/carrychain/map_loop2_1[7].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[7].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y75 [get_cells {TDC_1/carrychain/map_loop2_1[7].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[8].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y76 [get_cells {TDC_1/carrychain/map_loop2_1[8].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[8].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y76 [get_cells {TDC_1/carrychain/map_loop2_1[8].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[8].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y76 [get_cells {TDC_1/carrychain/map_loop2_1[8].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[8].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y76 [get_cells {TDC_1/carrychain/map_loop2_1[8].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[9].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y77 [get_cells {TDC_1/carrychain/map_loop2_1[9].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[9].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y77 [get_cells {TDC_1/carrychain/map_loop2_1[9].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[9].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y77 [get_cells {TDC_1/carrychain/map_loop2_1[9].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[9].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y77 [get_cells {TDC_1/carrychain/map_loop2_1[9].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[10].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y78 [get_cells {TDC_1/carrychain/map_loop2_1[10].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[10].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y78 [get_cells {TDC_1/carrychain/map_loop2_1[10].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[10].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y78 [get_cells {TDC_1/carrychain/map_loop2_1[10].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[10].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y78 [get_cells {TDC_1/carrychain/map_loop2_1[10].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[11].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y79 [get_cells {TDC_1/carrychain/map_loop2_1[11].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[11].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y79 [get_cells {TDC_1/carrychain/map_loop2_1[11].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[11].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y79 [get_cells {TDC_1/carrychain/map_loop2_1[11].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[11].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y79 [get_cells {TDC_1/carrychain/map_loop2_1[11].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[12].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y80 [get_cells {TDC_1/carrychain/map_loop2_1[12].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[12].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y80 [get_cells {TDC_1/carrychain/map_loop2_1[12].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[12].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y80 [get_cells {TDC_1/carrychain/map_loop2_1[12].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[12].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y80 [get_cells {TDC_1/carrychain/map_loop2_1[12].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[13].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y81 [get_cells {TDC_1/carrychain/map_loop2_1[13].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[13].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y81 [get_cells {TDC_1/carrychain/map_loop2_1[13].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[13].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y81 [get_cells {TDC_1/carrychain/map_loop2_1[13].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[13].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y81 [get_cells {TDC_1/carrychain/map_loop2_1[13].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[14].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y82 [get_cells {TDC_1/carrychain/map_loop2_1[14].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[14].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y82 [get_cells {TDC_1/carrychain/map_loop2_1[14].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[14].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y82 [get_cells {TDC_1/carrychain/map_loop2_1[14].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[14].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y82 [get_cells {TDC_1/carrychain/map_loop2_1[14].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[15].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y83 [get_cells {TDC_1/carrychain/map_loop2_1[15].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[15].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y83 [get_cells {TDC_1/carrychain/map_loop2_1[15].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[15].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y83 [get_cells {TDC_1/carrychain/map_loop2_1[15].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[15].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y83 [get_cells {TDC_1/carrychain/map_loop2_1[15].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[16].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y84 [get_cells {TDC_1/carrychain/map_loop2_1[16].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[16].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y84 [get_cells {TDC_1/carrychain/map_loop2_1[16].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[16].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y84 [get_cells {TDC_1/carrychain/map_loop2_1[16].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[16].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y84 [get_cells {TDC_1/carrychain/map_loop2_1[16].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[17].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y85 [get_cells {TDC_1/carrychain/map_loop2_1[17].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[17].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y85 [get_cells {TDC_1/carrychain/map_loop2_1[17].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[17].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y85 [get_cells {TDC_1/carrychain/map_loop2_1[17].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[17].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y85 [get_cells {TDC_1/carrychain/map_loop2_1[17].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[18].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y86 [get_cells {TDC_1/carrychain/map_loop2_1[18].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[18].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y86 [get_cells {TDC_1/carrychain/map_loop2_1[18].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[18].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y86 [get_cells {TDC_1/carrychain/map_loop2_1[18].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[18].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y86 [get_cells {TDC_1/carrychain/map_loop2_1[18].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[19].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y87 [get_cells {TDC_1/carrychain/map_loop2_1[19].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[19].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y87 [get_cells {TDC_1/carrychain/map_loop2_1[19].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[19].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y87 [get_cells {TDC_1/carrychain/map_loop2_1[19].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[19].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y87 [get_cells {TDC_1/carrychain/map_loop2_1[19].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[20].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y88 [get_cells {TDC_1/carrychain/map_loop2_1[20].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[20].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y88 [get_cells {TDC_1/carrychain/map_loop2_1[20].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[20].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y88 [get_cells {TDC_1/carrychain/map_loop2_1[20].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[20].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y88 [get_cells {TDC_1/carrychain/map_loop2_1[20].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[21].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y89 [get_cells {TDC_1/carrychain/map_loop2_1[21].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[21].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y89 [get_cells {TDC_1/carrychain/map_loop2_1[21].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[21].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y89 [get_cells {TDC_1/carrychain/map_loop2_1[21].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[21].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y89 [get_cells {TDC_1/carrychain/map_loop2_1[21].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[22].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y90 [get_cells {TDC_1/carrychain/map_loop2_1[22].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[22].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y90 [get_cells {TDC_1/carrychain/map_loop2_1[22].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[22].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y90 [get_cells {TDC_1/carrychain/map_loop2_1[22].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[22].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y90 [get_cells {TDC_1/carrychain/map_loop2_1[22].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[23].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y91 [get_cells {TDC_1/carrychain/map_loop2_1[23].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[23].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y91 [get_cells {TDC_1/carrychain/map_loop2_1[23].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[23].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y91 [get_cells {TDC_1/carrychain/map_loop2_1[23].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[23].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y91 [get_cells {TDC_1/carrychain/map_loop2_1[23].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[24].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y92 [get_cells {TDC_1/carrychain/map_loop2_1[24].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[24].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y92 [get_cells {TDC_1/carrychain/map_loop2_1[24].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[24].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y92 [get_cells {TDC_1/carrychain/map_loop2_1[24].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[24].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y92 [get_cells {TDC_1/carrychain/map_loop2_1[24].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[25].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y93 [get_cells {TDC_1/carrychain/map_loop2_1[25].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[25].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y93 [get_cells {TDC_1/carrychain/map_loop2_1[25].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[25].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y93 [get_cells {TDC_1/carrychain/map_loop2_1[25].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[25].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y93 [get_cells {TDC_1/carrychain/map_loop2_1[25].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[26].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y94 [get_cells {TDC_1/carrychain/map_loop2_1[26].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[26].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y94 [get_cells {TDC_1/carrychain/map_loop2_1[26].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[26].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y94 [get_cells {TDC_1/carrychain/map_loop2_1[26].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[26].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y94 [get_cells {TDC_1/carrychain/map_loop2_1[26].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[27].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y95 [get_cells {TDC_1/carrychain/map_loop2_1[27].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[27].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y95 [get_cells {TDC_1/carrychain/map_loop2_1[27].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[27].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y95 [get_cells {TDC_1/carrychain/map_loop2_1[27].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[27].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y95 [get_cells {TDC_1/carrychain/map_loop2_1[27].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[28].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y96 [get_cells {TDC_1/carrychain/map_loop2_1[28].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[28].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y96 [get_cells {TDC_1/carrychain/map_loop2_1[28].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[28].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y96 [get_cells {TDC_1/carrychain/map_loop2_1[28].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[28].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y96 [get_cells {TDC_1/carrychain/map_loop2_1[28].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[29].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y97 [get_cells {TDC_1/carrychain/map_loop2_1[29].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[29].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y97 [get_cells {TDC_1/carrychain/map_loop2_1[29].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[29].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y97 [get_cells {TDC_1/carrychain/map_loop2_1[29].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[29].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y97 [get_cells {TDC_1/carrychain/map_loop2_1[29].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[30].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y98 [get_cells {TDC_1/carrychain/map_loop2_1[30].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[30].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y98 [get_cells {TDC_1/carrychain/map_loop2_1[30].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[30].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y98 [get_cells {TDC_1/carrychain/map_loop2_1[30].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[30].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y98 [get_cells {TDC_1/carrychain/map_loop2_1[30].map_loop2_2[3].DFF}]

set_property BEL AFF [get_cells {TDC_1/carrychain/map_loop2_1[31].map_loop2_2[0].DFF}]
set_property LOC SLICE_X31Y99 [get_cells {TDC_1/carrychain/map_loop2_1[31].map_loop2_2[0].DFF}]
set_property BEL BFF [get_cells {TDC_1/carrychain/map_loop2_1[31].map_loop2_2[1].DFF}]
set_property LOC SLICE_X31Y99 [get_cells {TDC_1/carrychain/map_loop2_1[31].map_loop2_2[1].DFF}]
set_property BEL CFF [get_cells {TDC_1/carrychain/map_loop2_1[31].map_loop2_2[2].DFF}]
set_property LOC SLICE_X31Y99 [get_cells {TDC_1/carrychain/map_loop2_1[31].map_loop2_2[2].DFF}]
set_property BEL DFF [get_cells {TDC_1/carrychain/map_loop2_1[31].map_loop2_2[3].DFF}]
set_property LOC SLICE_X31Y99 [get_cells {TDC_1/carrychain/map_loop2_1[31].map_loop2_2[3].DFF}]




set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[31].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[1].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[2].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[3].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[4].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[5].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[6].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[7].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[8].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[9].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[10].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[11].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[12].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[13].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[14].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[15].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[16].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[17].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[18].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[19].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[20].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[21].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[22].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[23].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[24].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[25].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[26].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[27].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[28].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[29].CC_map}]
set_property BEL CARRY4 [get_cells {TDC_1/carrychain/map_loop1[30].CC_map}]
set_property BEL CARRY4 [get_cells TDC_1/carrychain/C4_1]
set_property LOC SLICE_X32Y99 [get_cells {TDC_1/carrychain/map_loop1[31].CC_map}]
set_property LOC SLICE_X32Y69 [get_cells {TDC_1/carrychain/map_loop1[1].CC_map}]
set_property LOC SLICE_X32Y70 [get_cells {TDC_1/carrychain/map_loop1[2].CC_map}]
set_property LOC SLICE_X32Y71 [get_cells {TDC_1/carrychain/map_loop1[3].CC_map}]
set_property LOC SLICE_X32Y72 [get_cells {TDC_1/carrychain/map_loop1[4].CC_map}]
set_property LOC SLICE_X32Y73 [get_cells {TDC_1/carrychain/map_loop1[5].CC_map}]
set_property LOC SLICE_X32Y74 [get_cells {TDC_1/carrychain/map_loop1[6].CC_map}]
set_property LOC SLICE_X32Y75 [get_cells {TDC_1/carrychain/map_loop1[7].CC_map}]
set_property LOC SLICE_X32Y76 [get_cells {TDC_1/carrychain/map_loop1[8].CC_map}]
set_property LOC SLICE_X32Y77 [get_cells {TDC_1/carrychain/map_loop1[9].CC_map}]
set_property LOC SLICE_X32Y78 [get_cells {TDC_1/carrychain/map_loop1[10].CC_map}]
set_property LOC SLICE_X32Y79 [get_cells {TDC_1/carrychain/map_loop1[11].CC_map}]
set_property LOC SLICE_X32Y80 [get_cells {TDC_1/carrychain/map_loop1[12].CC_map}]
set_property LOC SLICE_X32Y81 [get_cells {TDC_1/carrychain/map_loop1[13].CC_map}]
set_property LOC SLICE_X32Y82 [get_cells {TDC_1/carrychain/map_loop1[14].CC_map}]
set_property LOC SLICE_X32Y83 [get_cells {TDC_1/carrychain/map_loop1[15].CC_map}]
set_property LOC SLICE_X32Y84 [get_cells {TDC_1/carrychain/map_loop1[16].CC_map}]
set_property LOC SLICE_X32Y85 [get_cells {TDC_1/carrychain/map_loop1[17].CC_map}]
set_property LOC SLICE_X32Y86 [get_cells {TDC_1/carrychain/map_loop1[18].CC_map}]
set_property LOC SLICE_X32Y87 [get_cells {TDC_1/carrychain/map_loop1[19].CC_map}]
set_property LOC SLICE_X32Y88 [get_cells {TDC_1/carrychain/map_loop1[20].CC_map}]
set_property LOC SLICE_X32Y89 [get_cells {TDC_1/carrychain/map_loop1[21].CC_map}]
set_property LOC SLICE_X32Y90 [get_cells {TDC_1/carrychain/map_loop1[22].CC_map}]
set_property LOC SLICE_X32Y91 [get_cells {TDC_1/carrychain/map_loop1[23].CC_map}]
set_property LOC SLICE_X32Y92 [get_cells {TDC_1/carrychain/map_loop1[24].CC_map}]
set_property LOC SLICE_X32Y93 [get_cells {TDC_1/carrychain/map_loop1[25].CC_map}]
set_property LOC SLICE_X32Y94 [get_cells {TDC_1/carrychain/map_loop1[26].CC_map}]
set_property LOC SLICE_X32Y95 [get_cells {TDC_1/carrychain/map_loop1[27].CC_map}]
set_property LOC SLICE_X32Y96 [get_cells {TDC_1/carrychain/map_loop1[28].CC_map}]
set_property LOC SLICE_X32Y97 [get_cells {TDC_1/carrychain/map_loop1[29].CC_map}]
set_property LOC SLICE_X32Y98 [get_cells {TDC_1/carrychain/map_loop1[30].CC_map}]
set_property LOC SLICE_X32Y68 [get_cells TDC_1/carrychain/C4_1]


# RING OSCILLATOR

#set_property BEL D6LUT [get_cells Ring_Osc/first]
set_property BEL D6LUT [get_cells Ring_Osc/last]
set_property BEL C6LUT [get_cells {Ring_Osc/ro_loop[0].flip}]
set_property BEL B6LUT [get_cells {Ring_Osc/ro_delay[1].delay}]
set_property BEL A6LUT [get_cells {Ring_Osc/ro_delay[2].delay}]

set_property BEL D6LUT [get_cells {Ring_Osc/ro_delay[3].delay}]
set_property BEL C6LUT [get_cells {Ring_Osc/ro_delay[4].delay}]
set_property BEL B6LUT [get_cells {Ring_Osc/ro_delay[5].delay}]
set_property BEL A6LUT [get_cells {Ring_Osc/ro_delay[6].delay}]

set_property BEL D6LUT [get_cells {Ring_Osc/ro_delay[7].delay}]
set_property BEL C6LUT [get_cells {Ring_Osc/ro_delay[8].delay}]
set_property BEL B6LUT [get_cells {Ring_Osc/ro_delay[9].delay}]
set_property BEL A6LUT [get_cells {Ring_Osc/ro_delay[10].delay}]

set_property BEL D6LUT [get_cells {Ring_Osc/ro_delay[11].delay}]
set_property BEL C6LUT [get_cells {Ring_Osc/ro_delay[12].delay}]
set_property BEL B6LUT [get_cells {Ring_Osc/ro_delay[13].delay}]
set_property BEL A6LUT [get_cells {Ring_Osc/ro_delay[14].delay}]

set_property BEL D6LUT [get_cells {Ring_Osc/ro_delay[15].delay}]
set_property BEL C6LUT [get_cells {Ring_Osc/ro_delay[16].delay}]
set_property BEL B6LUT [get_cells {Ring_Osc/ro_delay[17].delay}]
set_property BEL A6LUT [get_cells {Ring_Osc/ro_delay[18].delay}]

set_property BEL D6LUT [get_cells {Ring_Osc/ro_delay[19].delay}]
set_property BEL C6LUT [get_cells {Ring_Osc/ro_delay[20].delay}]
set_property BEL B6LUT [get_cells {Ring_Osc/ro_delay[21].delay}]
set_property BEL A6LUT [get_cells {Ring_Osc/ro_delay[22].delay}]

set_property BEL D6LUT [get_cells {Ring_Osc/ro_delay[23].delay}]
set_property BEL C6LUT [get_cells {Ring_Osc/ro_delay[24].delay}]
set_property BEL B6LUT [get_cells {Ring_Osc/ro_delay[25].delay}]
set_property BEL A6LUT [get_cells {Ring_Osc/ro_delay[26].delay}]

set_property BEL D6LUT [get_cells {Ring_Osc/ro_delay[27].delay}]
set_property BEL C6LUT [get_cells {Ring_Osc/ro_delay[28].delay}]
set_property BEL B6LUT [get_cells {Ring_Osc/ro_delay[29].delay}]

#set_property LOC SLICE_X0Y74 [get_cells Ring_Osc/first]
set_property LOC SLICE_X0Y74 [get_cells Ring_Osc/last]
set_property LOC SLICE_X0Y74 [get_cells {Ring_Osc/ro_loop[0].flip}]
set_property LOC SLICE_X0Y74 [get_cells {Ring_Osc/ro_delay[1].delay}]
set_property LOC SLICE_X0Y74 [get_cells {Ring_Osc/ro_delay[2].delay}]

set_property LOC SLICE_X0Y73 [get_cells {Ring_Osc/ro_delay[3].delay}]
set_property LOC SLICE_X0Y73 [get_cells {Ring_Osc/ro_delay[4].delay}]
set_property LOC SLICE_X0Y73 [get_cells {Ring_Osc/ro_delay[5].delay}]
set_property LOC SLICE_X0Y73 [get_cells {Ring_Osc/ro_delay[6].delay}]

set_property LOC SLICE_X0Y72 [get_cells {Ring_Osc/ro_delay[7].delay}]
set_property LOC SLICE_X0Y72 [get_cells {Ring_Osc/ro_delay[8].delay}]
set_property LOC SLICE_X0Y72 [get_cells {Ring_Osc/ro_delay[9].delay}]
set_property LOC SLICE_X0Y72 [get_cells {Ring_Osc/ro_delay[10].delay}]

set_property LOC SLICE_X0Y71 [get_cells {Ring_Osc/ro_delay[11].delay}]
set_property LOC SLICE_X0Y71 [get_cells {Ring_Osc/ro_delay[12].delay}]
set_property LOC SLICE_X0Y71 [get_cells {Ring_Osc/ro_delay[13].delay}]
set_property LOC SLICE_X0Y71 [get_cells {Ring_Osc/ro_delay[14].delay}]

set_property LOC SLICE_X0Y70 [get_cells {Ring_Osc/ro_delay[15].delay}]
set_property LOC SLICE_X0Y70 [get_cells {Ring_Osc/ro_delay[16].delay}]
set_property LOC SLICE_X0Y70 [get_cells {Ring_Osc/ro_delay[17].delay}]
set_property LOC SLICE_X0Y70 [get_cells {Ring_Osc/ro_delay[18].delay}]

set_property LOC SLICE_X0Y69 [get_cells {Ring_Osc/ro_delay[19].delay}]
set_property LOC SLICE_X0Y69 [get_cells {Ring_Osc/ro_delay[20].delay}]
set_property LOC SLICE_X0Y69 [get_cells {Ring_Osc/ro_delay[21].delay}]
set_property LOC SLICE_X0Y69 [get_cells {Ring_Osc/ro_delay[22].delay}]

set_property LOC SLICE_X0Y68 [get_cells {Ring_Osc/ro_delay[23].delay}]
set_property LOC SLICE_X0Y68 [get_cells {Ring_Osc/ro_delay[24].delay}]
set_property LOC SLICE_X0Y68 [get_cells {Ring_Osc/ro_delay[25].delay}]
set_property LOC SLICE_X0Y68 [get_cells {Ring_Osc/ro_delay[26].delay}]

set_property LOC SLICE_X0Y67 [get_cells {Ring_Osc/ro_delay[27].delay}]
set_property LOC SLICE_X0Y67 [get_cells {Ring_Osc/ro_delay[28].delay}]
set_property LOC SLICE_X0Y67 [get_cells {Ring_Osc/ro_delay[29].delay}]
