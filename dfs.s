.data
adj_list:   .word node1, node2, 0    
node1:      .word 1                     
node2:      .word 2                    

visited:    .zero 64                    # 64-byte visited array 
size:       .word 16                    # Number of nodes
msg:        .string "DFS Traversal Completed.\n"

.text
.globl main
main:
    li a0, 0             
    jal ra, dfs          

    li a7, 4
    la a0, msg
    ecall                

    # Exit Program
    li a7, 10
    ecall

dfs:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)         

    mv s0, a0           

    la t0, visited
    add t1, t0, s0      
    li t2, 1
    sb t2, 0(t1)         

dfs_done:
    lw ra, 12(sp)
    lw s0, 8(sp)
    addi sp, sp, 16
    ret