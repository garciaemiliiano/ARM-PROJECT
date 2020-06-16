.data
mensaje: .asciz "Hola + mundo"
posicion: .asciz "0"
.text
.global mainEspacios
/*Encuentra espacios */
main:   ldr r0,=mensaje
        ldr r1,=posicion
        ldrb r4, [r1]

loop:   mov r5, #0
        ldrb r5, [r0]
        cmp r5, #00
        beq fin
        cmp r5,#0x20
        beq sumar
        bne avanzo

vuelve: add r0,r0,#1
        add r4,r4,#1
        b operando

sumar:  /*Avanzo uno mas para comparar si el que le sigue es un signo + */
        add r6,r6,#1
        b vuelve

operando: cmp r5,#'+'
          beq mover      

mover:  mov r8,#10
        b loop

fin: nop


/*Encuentra espacios */
   
