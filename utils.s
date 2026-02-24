# src/utils.s
.globl swap
.globl print_array

swap:
    lw t0, 0(a0)
    lw t1, 0(a1)
    sw t1, 0(a0)
    sw t0, 0(a1)
    ret

print_array:
    # a0 = array address, a1 = size
    mv t0, a0
    mv t1, a1
print_loop:
    beq t1, zero, print_end
    lw a0, 0(t0)
    li a7, 1      # Ripes syscall for print integer
    ecall
    li a0, 32     # Space character
    li a7, 11     # Ripes syscall for print char
    ecall
    addi t0, t0, 4
    addi t1, t1, -1
    j print_loop
print_end:
    li a0, 10     # Newline
    li a7, 11
    ecall
    ret