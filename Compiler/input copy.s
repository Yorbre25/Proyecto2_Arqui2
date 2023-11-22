initBlock:
mov R1,#15
mov r2,#76
loop:
str r1,r2,r0
add r2,r2,#1
b loop

