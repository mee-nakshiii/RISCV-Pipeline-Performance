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