# src/data.s - Managed by Evana
.data
.globl array
.globl size
.globl adj_matrix

# Task 1: 64-element unsorted array for Sorting Algorithms
array: 
    .word 54, 12, 87, 3, 45, 99, 10, 23, 67, 1, 8, 34, 56, 72, 19, 4
    .word 88, 2, 91, 15, 6, 42, 33, 77, 5, 11, 29, 63, 48, 82, 37, 21
    .word 9, 70, 51, 25, 14, 80, 41, 66, 30, 95, 13, 27, 44, 58, 76, 39
    .word 22, 49, 85, 2, 18, 60, 31, 74, 55, 69, 7, 90, 28, 52, 98, 36

size: .word 64

# Task 2: 8x8 Adjacency Matrix for BFS/DFS (Week 3)
# 1 represents a connection, 0 represents no connection
adj_matrix:
    .word 0, 1, 1, 0, 0, 0, 0, 0  # Node 0
    .word 1, 0, 0, 1, 1, 0, 0, 0  # Node 1
    .word 1, 0, 0, 0, 0, 1, 1, 0  # Node 2
    .word 0, 1, 0, 0, 0, 0, 0, 1  # Node 3
    .word 0, 1, 0, 0, 0, 0, 0, 1  # Node 4
    .word 0, 0, 1, 0, 0, 0, 0, 1  # Node 5
    .word 0, 0, 1, 0, 0, 0, 0, 1  # Node 6
    .word 0, 0, 0, 1, 1, 1, 1, 0  # Node 7