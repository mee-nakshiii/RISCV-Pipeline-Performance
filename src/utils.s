.globl swap
swap:
    lw t0, 0(a0)          # Load value at addr1
    lw t1, 0(a1)          # Load value at addr2
    sw t1, 0(a0)          # Swap store
    sw t0, 0(a1)
    ret