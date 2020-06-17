.data
input_usuario: .asciz ""            
mensajeDeBienvenida: .asciz "Hola, ¿Como estas?, Seleccione una opcion \n1)Suma \n2)Resta \n3)Multiplicacion \n4)Division \n"                                                                 
mensaje_error:  .asciz "Lo siento, mis respuestas son limitadas \n"
text_result: .asciz "##########"
posicion: .asciz "0"
operacion: .byte 0
num1: .int 0
num2: .int 0
resultado: .int 0
resto: .int 0
mensaje_despedida: .asciz "Adios! \n"
.text
.global main
main:  push {r0,r1,r2,r4,r7}
        mov r7, #4      
        mov r0, #1      
        mov r2, #92   
        ldr r1, =mensajeDeBienvenida
        swi 0  
        pop {r0,r1,r2,r4,r7}
        b leer_input_usuario
leer_input_usuario:     push {r0,r1,r2,r7}
                        mov r7, #3
                        mov r0, #0
                        mov r2, #10
                        ldr r1, =input_usuario
                        swi 0
                        pop {r0,r1,r2,r7}

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
   