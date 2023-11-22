readVectors:
movv R8,#80
ldv R1,R8
addv R8, R8, #6
ldv R2,R8
addv R3,R1,R2
addv R8, R8, #6
strv R3,R8