.data 
mensajePorPantalla: .ascii "Ingrese dos digitos para sumar \n"
cadenaVacia: .word 0
.text 
.global main
main:   mov r7, #4      /* mostrar por standar output*/
        mov r0, #1      /*ingreso string*/
        mov r2, #100    /* Tamaño string RANDOM*/
        ldr r1, =mensajePorPantalla
        swi 0

operandoUno:mov r7, #3
            mov r0, #0
            mov r2, #10
            ldr r1, =cadenaVacia
            swi 0

            mov r7, #4
            mov r0, #1
            mov r2, #100 
            ldr r1, =cadenaVacia
            ldr r3,[r1]
            swi 0

fin:    mov r7, #1
        swi 0