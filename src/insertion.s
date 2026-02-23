# src/insertion.s
.globl insertion_sort

insertion_sort:
    # a0 = array address, a1 = size
    addi t0, zero, 1      # i = 1 (outer loop counter)
outer_loop:
    bge t0, a1, end_sort  # if i >= size, done
    
    mv t1, t0             # j = i (inner loop counter)
inner_loop:
    ble t1, zero, next_i  # if j <= 0, break to next i
    
    # Calculate addresses for array[j] and array[j-1]
    slli t2, t1, 2        # t2 = j * 4
    add t2, a0, t2        # t2 = address of array[j]
    addi t3, t2, -4       # t3 = address of array[j-1]
    
    lw t4, 0(t2)          # val_j = array[j]
    lw t5, 0(t3)          # val_j_1 = array[j-1]
    
    bge t4, t5, next_i    # if array[j] >= array[j-1], break inner
    
    # Swap elements (using registers directly for speed)
    sw t5, 0(t2)
    sw t4, 0(t3)
    
    addi t1, t1, -1       # j--
    j inner_loop

next_i:
    addi t0, t0, 1        # i++
    j outer_loop

end_sort:
    ret