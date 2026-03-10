.data
node1:      .word 1
node2:      .word 2
adj_list:   .word node1, node2, 0

visited:    .zero 64                  
size:       .word 16                 
msg:        .string "DFS Traversal Completed. Check Stack for recursion depth.\n"

.text
.globl main
main:
    li a0, 0            
    jal ra, dfs       

    # Print Status to Console
    li a7, 4
    la a0, msg
    ecall                

    # Exit Program
    li a7, 10
    ecall
dfs:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)         # Current node

    mv s0, a0            # s0 = current node

    # Mark as Visited
    la t0, visited
    add t1, t0, s0       # visited[s0]
    li t2, 1
    sb t2, 0(t1)         # Store Byte: visited[s0] = 1

dfs_done:
 
    lw ra, 12(sp)
    lw s0, 8(sp)
    addi sp, sp, 16
    ret
