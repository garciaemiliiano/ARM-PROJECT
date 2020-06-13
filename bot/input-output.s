.data 

mensaje: .ascii ""
.text 

.global main

main: /*Lo muestra por pantalla */
    mov r7, #3
    mov r0, #0
    mov r2, #10
    ldr r1, =mensaje
    swi 0

_escribir: /*Guarda lo que se esta escribiendo */
    mov r7, #4
    mov r0, #1
    mov r2, #6 /*Numero de letras */
    ldr r1, =mensaje
    swi 0

fin: 
    mov r7, #1
    swi 0