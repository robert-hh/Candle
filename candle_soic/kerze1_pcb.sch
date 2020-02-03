EESchema Schematic File Version 4
LIBS:kerze1_pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L kerze1_pcb-rescue:ATTINY85-P IC1
U 1 1 576FE9B2
P 4700 3700
F 0 "IC1" H 3550 4100 50  0000 C CNN
F 1 "ATTINY85-P" H 5700 3300 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 5700 3700 50  0001 C CIN
F 3 "" H 4700 3700 50  0000 C CNN
	1    4700 3700
	-1   0    0    -1  
$EndComp
$Comp
L kerze1_pcb-rescue:R R1
U 1 1 576FEA33
P 6400 4100
F 0 "R1" V 6480 4100 50  0000 C CNN
F 1 "82" V 6400 4100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6330 4100 50  0001 C CNN
F 3 "" H 6400 4100 50  0000 C CNN
	1    6400 4100
	-1   0    0    1   
$EndComp
$Comp
L kerze1_pcb-rescue:R R3
U 1 1 576FEA9C
P 7250 4500
F 0 "R3" V 7330 4500 50  0000 C CNN
F 1 "10k" V 7250 4500 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 7180 4500 50  0001 C CNN
F 3 "" H 7250 4500 50  0000 C CNN
	1    7250 4500
	1    0    0    -1  
$EndComp
$Comp
L kerze1_pcb-rescue:LED D3
U 1 1 576FEAE5
P 6400 4450
F 0 "D3" H 6400 4550 50  0000 C CNN
F 1 "NZ-Y5N15N" H 6400 4350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02" H 6400 4450 50  0001 C CNN
F 3 "" H 6400 4450 50  0000 C CNN
	1    6400 4450
	0    1    -1   0   
$EndComp
$Comp
L kerze1_pcb-rescue:Photores R2
U 1 1 576FEB42
P 7250 3800
F 0 "R2" V 7330 3800 50  0000 C CNN
F 1 "Photores" V 7460 3800 50  0000 C TNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02" V 7180 3800 50  0001 C CNN
F 3 "" H 7250 3800 50  0000 C CNN
	1    7250 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 3650 7000 4350
Wire Wire Line
	6050 3650 7000 3650
Connection ~ 7000 4350
Connection ~ 7250 4350
$Comp
L kerze1_pcb-rescue:CONN_01X01 P1
U 1 1 576FF342
P 2950 3450
F 0 "P1" H 2950 3550 50  0000 C CNN
F 1 "CONN_01X01" V 3050 3450 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 2950 3450 50  0001 C CNN
F 3 "" H 2950 3450 50  0000 C CNN
	1    2950 3450
	-1   0    0    1   
$EndComp
$Comp
L kerze1_pcb-rescue:CONN_01X01 P2
U 1 1 576FF472
P 2950 3950
F 0 "P2" H 2950 4050 50  0000 C CNN
F 1 "CONN_01X01" V 3050 3950 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01" H 2950 3950 50  0001 C CNN
F 3 "" H 2950 3950 50  0000 C CNN
	1    2950 3950
	-1   0    0    1   
$EndComp
Wire Wire Line
	3350 2700 3350 3450
Connection ~ 3350 3450
Wire Wire Line
	3350 4650 6400 4650
$Comp
L kerze1_pcb-rescue:GND #PWR2
U 1 1 5770013E
P 3350 4650
F 0 "#PWR2" H 3350 4400 50  0001 C CNN
F 1 "GND" H 3350 4500 50  0000 C CNN
F 2 "" H 3350 4650 50  0000 C CNN
F 3 "" H 3350 4650 50  0000 C CNN
	1    3350 4650
	1    0    0    -1  
$EndComp
$Comp
L kerze1_pcb-rescue:VCC #PWR1
U 1 1 57700166
P 3350 2700
F 0 "#PWR1" H 3350 2550 50  0001 C CNN
F 1 "VCC" H 3350 2850 50  0000 C CNN
F 2 "" H 3350 2700 50  0000 C CNN
F 3 "" H 3350 2700 50  0000 C CNN
	1    3350 2700
	1    0    0    -1  
$EndComp
Connection ~ 3350 3950
Wire Wire Line
	6800 4350 7000 4350
$Comp
L kerze1_pcb-rescue:D_Schottky_Small D4
U 1 1 5770F8D1
P 3250 3450
F 0 "D4" H 3200 3530 50  0000 L CNN
F 1 "BAT48" H 2970 3370 50  0000 L CNN
F 2 "Diodes_SMD:MiniMELF_Standard" V 3250 3450 50  0001 C CNN
F 3 "" V 3250 3450 50  0000 C CNN
	1    3250 3450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3150 3950 3350 3950
Connection ~ 3350 4650
$Comp
L kerze1_pcb-rescue:R R4
U 1 1 57715DA6
P 6800 4200
F 0 "R4" V 6880 4200 50  0000 C CNN
F 1 "100k" V 6800 4200 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6730 4200 50  0001 C CNN
F 3 "" H 6800 4200 50  0000 C CNN
	1    6800 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 3450 6800 4050
$Comp
L kerze1_pcb-rescue:R R5
U 1 1 5772085F
P 7250 4200
F 0 "R5" V 7330 4200 50  0000 C CNN
F 1 "27k" V 7250 4200 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 7180 4200 50  0001 C CNN
F 3 "" H 7250 4200 50  0000 C CNN
	1    7250 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 3550 7250 3550
Wire Wire Line
	6800 3450 6050 3450
Wire Wire Line
	6400 3950 6400 3850
Wire Wire Line
	6400 3850 6050 3850
Connection ~ 6400 4650
$Comp
L kerze1_pcb-rescue:CP C1
U 1 1 577FB4A0
P 3350 3800
F 0 "C1" H 3375 3900 50  0000 L CNN
F 1 "10uf" H 3375 3700 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 3388 3650 50  0001 C CNN
F 3 "" H 3350 3800 50  0000 C CNN
	1    3350 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 3950 3350 4650
Wire Wire Line
	7000 4350 7250 4350
Wire Wire Line
	3350 3450 3350 3650
Wire Wire Line
	6400 4650 7250 4650
$EndSCHEMATC
