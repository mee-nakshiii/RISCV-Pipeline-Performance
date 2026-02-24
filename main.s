# DATA SECTION 
.data
.globl size, array

size: .word 64            # Array size
array: .word 45, 12, 89, 34, 67, 23, 90, 11, 56, 78, 33, 21, 44, 99, 10, 5, 88, 77, 66, 55, 44, 33, 22, 11, 9, 8, 7, 6, 5, 4, 3, 2, 1, 100, 200, 150, 120, 130, 140, 110, 105, 115, 125, 135, 145, 155, 165, 175, 185, 195, 205, 215, 225, 235, 245, 255, 265, 275, 285, 295, 305, 315, 325, 335

# MAIN EXECUTION BLOCK
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




.globl insertion_sort
insertion_sort:
    addi t0, zero, 1      # i = 1 (outer counter)
outer_loop_ins:
    bge t0, a1, end_ins   # if i >= size, return
    mv t1, t0             # j = i (inner counter)
inner_loop_ins:
    ble t1, zero, next_i_ins # if j <= 0, next i
    slli t2, t1, 2        # Byte offset (j * 4)
    add t2, a0, t2        # Address of array[j]
    addi t3, t2, -4       # Address of array[j-1]
    lw t4, 0(t2)          # Load array[j]
    lw t5, 0(t3)          # Load array[j-1]
    bge t4, t5, next_i_ins # If correct order, break inner
    sw t5, 0(t2)          # Perform Memory Shift
    sw t4, 0(t3)
    addi t1, t1, -1       # j--
    j inner_loop_ins
next_i_ins:
    addi t0, t0, 1        # i++
    j outer_loop_ins
end_ins:
    ret



.globl bubble_sort
bubble_sort:
    addi s1, a1, -1       # Limit = size - 1
    li t0, 0              # i = 0 (outer counter)
bubble_outer:
    bge t0, s1, end_bub
    li t1, 0              # j = 0 (inner counter)
    sub s2, s1, t0        # Optimization (size - 1 - i)
bubble_inner:
    bge t1, s2, next_bub
    slli t2, t1, 2        # Byte offset
    add t2, a0, t2        # Address of array[j]
    addi t3, t2, 4        # Address of array[j+1]
    lw t4, 0(t2)          # Load array[j]
    lw t5, 0(t3)          # Load array[j+1]
    ble t4, t5, skip_swp  # If ordered, skip swap
    sw t5, 0(t2)          # Adjacent Memory Swap
    sw t4, 0(t3)
skip_swp:
    addi t1, t1, 1        # j++
    j bubble_inner
next_bub:
    addi t0, t0, 1        # i++
    j bubble_outer
end_bub:
    ret

.globl swap
swap:
    lw t0, 0(a0)          # Load value at addr1
    lw t1, 0(a1)          # Load value at addr2
    sw t1, 0(a0)          # Swap store
    sw t0, 0(a1)
    ret