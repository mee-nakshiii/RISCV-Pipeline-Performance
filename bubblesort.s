# Standalone Bubble Sort - 64 Elements
.data
array: .word 45, 12, 89, 34, 67, 23, 90, 11, 56, 78, 33, 21, 44, 99, 10, 5, 88, 77, 66, 55, 44, 33, 22, 11, 9, 8, 7, 6, 5, 4, 3, 2, 1, 100, 200, 150, 120, 130, 140, 110, 105, 115, 125, 135, 145, 155, 165, 175, 185, 195, 205, 215, 225, 235, 245, 255, 265, 275, 285, 295, 305, 315, 325, 335
size:  .word 64
msg:   .string "Bubble Sort Completed. Check CPI for Branch Flushes.\n"

.text
main:
    la a0, array
    lw a1, size
    addi s1, a1, -1       # limit = size - 1
    li t0, 0              # i = 0
bubble_outer:
    bge t0, s1, end_bub
    li t1, 0              # j = 0
    sub s2, s1, t0
bubble_inner:
    bge t1, s2, next_bub  # Control Hazard point
    slli t2, t1, 2
    add t2, a0, t2
    addi t3, t2, 4
    lw t4, 0(t2)
    lw t5, 0(t3)
    ble t4, t5, skip_swp
    sw t5, 0(t2)          # Swap Memory
    sw t4, 0(t3)
skip_swp:
    addi t1, t1, 1
    j bubble_inner
next_bub:
    addi t0, t0, 1
    j bubble_outer

end_bub:
    li a7, 4
    la a0, msg
    ecall                 # Print Status
    li a7, 10
    ecall                 # Exit