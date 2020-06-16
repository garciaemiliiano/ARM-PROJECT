.data
input_usuario: .asciz ""                                                                             
mensaje_error:  .asciz "Lo siento, mis respuestas son limitadas \n"
text_result: .asciz "##########"
operacion: .byte 0
num1: .int 0
num2: .int 0
resultado: .int 0
resto: .int 0
mensaje_despedida: .asciz "Adios! \n"

.text
.global main

leer_input_usuario: mov r7, #3
                    mov r0, #0
                    mov r2, #10
                    ldr r1, =input_usuario
                    swi 0


/*Encuentra espacios */
mainEspacios:   ldr r0,=input_usuario
                ldr r1,=posicion
                ldrb r4, [r1]

loopEs: mov r5, #0
        ldrb r5, [r0]
        cmp r5, #00
        beq fin
        cmp r5,#0x20
        beq sumar
        bne avanzo

avanzo: add r0,r0,#1
        add r4,r4,#1
        b loopEs

sumar:  add r6,r6,#1
        b avanzo
fin: nop
/*Encuentra espacios */
   