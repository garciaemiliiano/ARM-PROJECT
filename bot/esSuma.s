.data
mensajePorPantalla: .ascii "Ingrese un signo"
signoIngresado: .ascii ""
.text
.global main

main:
    mov r7, #4      /*mostrar por standar output*/
    mov r0, #1      /*ingreso string*/
    mov r2, #50    /*Tamaño string RANDOM*/
    mov r3, #'+'
    ldr r1, =mensajePorPantalla
    swi 0  
    b suma

suma:
    mov r7, #3
    mov r0, #0
    mov r2, #10
    ldr r8, =signoIngresado
    ldrb r9,[r8] 

    cmp r8, r3
    beq imprimir
    bne fin

imprimir:
    mov r7, #4
    mov r0, #1
    mov r2, #100 /*Numero de letras para escribir*/
    ldr r8, =signoIngresado
    b fin

fin:
    mov r7, #1
    swi 0