.globl insertion_sort
insertion_sort:
    addi t0, zero, 1      # i = 1 (outer counter)
outer_loop:
    bge t0, a1, end_ins   # if i >= size, return
    mv t1, t0             # j = i (inner counter)
inner_loop:
    ble t1, zero, next_i  # if j <= 0, next i
    slli t2, t1, 2        # Byte offset (j * 4)
    add t2, a0, t2        # Address of array[j]
    addi t3, t2, -4       # Address of array[j-1]
    lw t4, 0(t2)          # Load array[j]
    lw t5, 0(t3)          # Load array[j-1]
    bge t4, t5, next_i    # If correct order, break inner
    sw t5, 0(t2)          # Perform Memory Shift
    sw t4, 0(t3)
    addi t1, t1, -1       # j--
    j inner_loop
next_i:
    addi t0, t0, 1        # i++
    j outer_loop
end_ins:
    ret