# src/bubbles.s
.globl bubble_sort

bubble_sort:
    # a0 = array address, a1 = size
    addi s1, a1, -1       # s1 = size - 1 (outer limit)
    li t0, 0              # t0 = i (outer loop counter)

bubble_outer:
    bge t0, s1, bubble_done
    li t1, 0              # t1 = j (inner loop counter)
    sub s2, s1, t0        # s2 = size - 1 - i (inner limit)

bubble_inner:
    bge t1, s2, next_i
    
    slli t2, t1, 2        # t2 = j * 4
    add t2, a0, t2        # t2 = address of array[j]
    addi t3, t2, 4        # t3 = address of array[j+1]
    
    lw t4, 0(t2)          # t4 = array[j]
    lw t5, 0(t3)          # t5 = array[j+1]
    
    ble t4, t5, skip_swap # if array[j] <= array[j+1], don't swap
    
    # Prep arguments for swap function
    # Save current counters because swap might overwrite t-registers
    addi sp, sp, -16
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw t0, 8(sp)
    sw t1, 12(sp)
    
    mv a0, t2             # arg 0: address of array[j]
    mv a1, t3             # arg 1: address of array[j+1]
    jal ra, swap
    
    # Restore counters
    lw a0, 0(sp)
    lw a1, 4(sp)
    lw t0, 8(sp)
    lw t1, 12(sp)
    addi sp, sp, 16

skip_swap:
    addi t1, t1, 1        # j++
    j bubble_inner

next_i:
    addi t0, t0, 1        # i++
    j bubble_outer

bubble_done:
    ret