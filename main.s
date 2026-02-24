# main.s - Updated Entry Point
.text              # Tell Ripes this is CODE first
.globl main

main:
    la a0, array   # Load Evana's array
    lw a1, size    # Load size
    
    jal ra, insertion_sort  # Run your logic
    
    li a7, 10      # Exit
    ecall

# Move the includes to the BOTTOM
.include "data.s"
.include "src/utils.s"
.include "src/insertion.s"
.include "src/bubbles.s"