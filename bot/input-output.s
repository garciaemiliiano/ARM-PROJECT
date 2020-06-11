.data 

mensaje: .ascii ""
.text 

.global main

main: 
    mov r7, #3
    mov r0, #0
    mov r2, #10
    ldr r1, =mensaje
    swi 0

_escribir:
    mov r7, #4
    mov r0, #1
    mov r2, #6 /*Numero de letras */
    ldr r1, =mensaje
    swi 0

fin: 
    mov r7, #1 /*AA */
    swi 0