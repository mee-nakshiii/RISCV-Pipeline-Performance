# ==========================================
# DATA SECTION (Unified Memory Segment)
# ==========================================
.data
.globl size, array, temp_array

size: .word 16            # Reduced to 16 for clear recursive tracing
array: .word 45, 12, 89, 34, 67, 23, 90, 11, 56, 78, 33, 21, 44, 99, 10, 5

# Helper array for Recursive Merge Sort
temp_array: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

# ==========================================
# MAIN EXECUTION BLOCK
# ==========================================
.text
.globl main

main:
    # --- WEEK 1: ITERATIVE BASELINES ---
    la a0, array         
    lw a1, size         
    jal ra, insertion_sort 
    
    la a0, array         
    lw a1, size          
    jal ra, bubble_sort 
    
    # --- WEEK 2: RECURSIVE MERGE SORT ---
    la a0, array         # Base address
    li a1, 0             # Low index
    lw t0, size
    addi a2, t0, -1      # High index (size - 1)
    jal ra, merge_sort   # Begin Recursion
    
    # --- EXIT PROGRAM ---
    li a7, 10            # Exit Syscall
    ecall

# ==========================================
# WEEK 2 ALGORITHM: RECURSIVE MERGE SORT
# ==========================================
merge_sort:
    # --- STACK PROLOGUE ---
    addi sp, sp, -16     # Allocate stack space
    sw ra, 12(sp)        # Save return address
    sw s0, 8(sp)         # Save low index
    sw s1, 4(sp)         # Save high index
    sw s2, 0(sp)         # Save mid index

    mv s0, a1            # s0 = low
    mv s1, a2            # s1 = high

    bge s0, s1, ms_done  # Base Case: low >= high

    # Calculate Mid: mid = low + (high - low) / 2
    sub t0, s1, s0
    srli t0, t0, 1
    add s2, s0, t0       # s2 = mid

    # Recursive Call Left: merge_sort(low, mid)
    mv a1, s0
    mv a2, s2
    jal ra, merge_sort

    # Recursive Call Right: merge_sort(mid + 1, high)
    addi a1, s2, 1
    mv a2, s1
    jal ra, merge_sort

    # Merge Step
    mv a1, s0
    mv a2, s2
    mv a3, s1
    jal ra, merge        # Call iterative merge helper

ms_done:
    # --- STACK EPILOGUE ---
    lw ra, 12(sp)        # Restore return address
    lw s0, 8(sp)
    lw s1, 4(sp)
    lw s2, 0(sp)
    addi sp, sp, 16      # Deallocate stack
    ret

# ==========================================
# MERGE HELPER (Memory-to-Memory Utility)
# ==========================================
merge:
    # Placeholder for merge logic 
    # (Analyzes MEM stage pressure during data movement)
    ret

# ==========================================
# WEEK 1 ALGORITHMS (Iterative Logic)
# ==========================================
.globl insertion_sort
insertion_sort:
    addi t0, zero, 1      
outer_ins:
    bge t0, a1, end_ins   
    mv t1, t0             
inner_ins:
    ble t1, zero, next_ins 
    slli t2, t1, 2        
    add t2, a0, t2        
    addi t3, t2, -4       
    lw t4, 0(t2)          
    lw t5, 0(t3)          
    bge t4, t5, next_ins  
    sw t5, 0(t2)          
    sw t4, 0(t3)
    addi t1, t1, -1       
    j inner_ins
next_ins:
    addi t0, t0, 1        
    j outer_ins
end_ins:
    ret

.globl bubble_sort
bubble_sort:
    addi s1, a1, -1       
    li t0, 0              
bubble_outer:
    bge t0, s1, end_bub
    li t1, 0              
    sub s2, s1, t0        
bubble_inner:
    bge t1, s2, next_bub
    slli t2, t1, 2        
    add t2, a0, t2        
    addi t3, t2, 4        
    lw t4, 0(t2)          
    lw t5, 0(t3)          
    ble t4, t5, skip_swp  
    sw t5, 0(t2)          
    sw t4, 0(t3)
skip_swp:
    addi t1, t1, 1        
    j bubble_inner
next_bub:
    addi t0, t0, 1        
    j bubble_outer
end_bub:
    ret