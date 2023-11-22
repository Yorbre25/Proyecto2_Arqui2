initBlock:
mov r4, #5
mov r1, #76
loop:
str r4, r1, r0
add r1, r1, #1
b loop
