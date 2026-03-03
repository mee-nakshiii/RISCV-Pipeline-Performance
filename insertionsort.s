# Standalone Insertion Sort - 64 Elements
.data
array: .word 45, 12, 89, 34, 67, 23, 90, 11, 56, 78, 33, 21, 44, 99, 10, 5, 88, 77, 66, 55, 44, 33, 22, 11, 9, 8, 7, 6, 5, 4, 3, 2, 1, 100, 200, 150, 120, 130, 140, 110, 105, 115, 125, 135, 145, 155, 165, 175, 185, 195, 205, 215, 225, 235, 245, 255, 265, 275, 285, 295, 305, 315, 325, 335
size:  .word 64
msg:   .string "Insertion Sort Completed. Check CPI for Load-Use stalls.\n"

.text
main:
    la a0, array
    lw a1, size
    addi t0, zero, 1      # i = 1
outer_ins:
    bge t0, a1, end_ins
    mv t1, t0             # j = i
inner_ins:
    ble t1, zero, next_ins
    slli t2, t1, 2
    add t2, a0, t2
    addi t3, t2, -4
    lw t4, 0(t2)          # Load current
    lw t5, 0(t3)          # Load previous
    bge t4, t5, next_ins  # Pipeline check: Data Hazard here
    sw t5, 0(t2)          # Shift Memory
    sw t4, 0(t3)
    addi t1, t1, -1
    j inner_ins
next_ins:
    addi t0, t0, 1
    j outer_ins

end_ins:
    li a7, 4
    la a0, msg
    ecall                 # Print Status
    li a7, 10
    ecall                 # Exit