.include "src/data.s"
.include "src/utils.s"
.include "src/insertion.s"
.include "src/bubbles.s"

.text
.globl main

main:
    #INSERTION SORT
    la a0, array         
    lw a1, size         
    jal ra, insertion_sort 
    
    #BUBBLE SORT
    la a0, array         # Reload address
    lw a1, size          
    jal ra, bubble_sort 
    
    #EXIT PROGRAM
    li a7, 10         
    ecall