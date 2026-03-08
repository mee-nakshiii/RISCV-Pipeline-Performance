
.data
array: .word 45, 12, 89, 34, 67, 23, 90, 11, 56, 78, 33, 21, 44, 99, 10, 5, 88, 77, 66, 55, 44, 33, 22, 11, 9, 8, 7, 6, 5, 4, 3, 2, 1, 100, 200, 150, 120, 130, 140, 110, 105, 115, 125, 135, 145, 155, 165, 175, 185, 195, 205, 215, 225, 235, 245, 255, 265, 275, 285, 295, 305, 315, 325, 335
size:  .word 64
msg:   .string "Recursive Merge Sort Completed.\n"

.text
main:
    la a0, array
    li a1, 0              # low
    lw t0, size
    addi a2, t0, -1       # high
    jal ra, merge_sort    # Start Recursion
    
    li a7, 4
    la a0, msg
    ecall                 # Print Status
    li a7, 10
    ecall                 # Exit

merge_sort:
    addi sp, sp, -16      # Allocate 16 bytes
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)
    
    mv s0, a1
    mv s1, a2
    bge s0, s1, ms_done   # Base Case
    
    sub t0, s1, s0
    srli t0, t0, 1
    add s2, s0, t0        # mid
    
    mv a1, s0
    mv a2, s2
    jal ra, merge_sort    # Recurse Left
    
    addi a1, s2, 1
    mv a2, s1
    jal ra, merge_sort    # Recurse Right

ms_done:
    lw ra, 12(sp)         # Restore
    lw s0, 8(sp)
    lw s1, 4(sp)
    lw s2, 0(sp)
    addi sp, sp, 16       # Deallocate stack
    ret