.data
dato: .asciz "123"
valor: .int 0
.text
.global main

main:   ldr r1,=dato
        mov r0, #1
        mov r10,#10
        
ciclo:  ldrb r5,[r1]
        cmp r5,#00
        beq fin
        add r1,#1
        sub r5,#0x30
        cmp r0, #1
        bne siguiente
        mov r2,r5
        add r0,#1
        bal ciclo

siguiente:  mul r2, r10
            add r2,r5
            add r0,#1
            bal ciclo
fin: nop
