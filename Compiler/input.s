initBlock:
mov R1,#71
ld R2, R1
cmp R2,#0
beq initBlock

firstWrite:
mov R8,#80

mov R1,#5
mov R2,#7
mov R3,#13
mov R4,#19
mov R5,#23
mov R6,#24
mov R7,#0
b writeRoutine

secondWrite:
mov R1,#2
mov R2,#4
mov R3,#6
mov R4,#7
mov R5,#9
mov R6,#33
mov R7,#1

writeRoutine:
str R1,R8
add R8,R8,#1
str R2,R8
add R8,R8,#1
str R3,R8
add R8,R8,#1
str R4,R8
add R8,R8,#1
str R5,R8
add R8,R8,#1
str R6,R8
add R8,R8,#1
cmp R7,#1
beq readVectors
b secondWrite

readVectors:
movv R8,#80
ldv R1,R8
addv R8, R8, #6
ldv R2,R8
addv R3,R1,R2
addv R8, R8, #20
strv R3,R8

end:
mov r1,#0
b end

