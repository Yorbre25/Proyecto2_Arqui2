initBlock:
mov r4, 0
mov r7, #480
mov r5, #30
loop:
    cmp r4, r7
    bg exit
    mov r13, #3
    mult r15, r4, #640
    add r15, r15, r5
    add r15, r15, #76
    str r13, r15, r0 
    add r4, r4, #1   
    b loop
exit:
mov r0,#0
b exit
