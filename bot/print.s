.data
resultado: .int -19
vacia: .asciz "     "
msj: .asciz "El resultado es:\n"
.text
.global main 
main:	push {r1,r3,r4,r5,r6,r7,r12}
		ldr r8,=vacia /*Cargo el registro con la cadena vacia*/
		ldr r1,=resultado /*Cargo el registro con el entero*/
		ldr r12,[r1] /*Cargo el registro con el entero R2=ENTERO*/
		mov r3,#10 /*Division*/
		mov r4,#0 /*Resultado*/
		mov r5,#'-'
		mov r11,#'\n'

		mov r9,#-1
		cmp r12,#0xFFFFFFFF
			bmi a_pos
		b divi_s

a_pos:	mul r12,r9,r12
		mov r10, #1 /*Flag*/
		bal divi_s

divi_s:	cmp r12,r3
			blt conv_enteroToAscii
		add r4,r4,#1 /*R4 =RESULTADO*/
		subs r12,r3   /*R2= RESTO*/
		bal divi_s

conv_enteroToAscii:	add r4,#0x30
					add r12,#0x30
					bal g_divi

/*Ya en esta etapa en R4=2 en ASCII R2=1 EN ASCII*/
g_divi:	cmp r10,#1
			beq signoNeg
		strb r4,[r8] /*Guardo el 2 en la primera posicion (?*/
		
		add r8,r8,#1
		strb r12,[r8] /*Guardo el 1 en la segunda posicion (?*/
		
		add r8,r8,#1
		strb r11,[r8]
		
		pop {r1,r3,r4,r5,r6,r7,r12}
		b show

signoNeg:	strb r5,[r8]
			add r8,r8,#1
			mov r10,#0
			bal g_divi

show: 	mov r7, #4      /*Imprimo*/
        mov r0, #1      
        mov r2, #24 
        ldr r1, =msj
		swi 0

		mov r7, #4      /*Imprimo*/
        mov r0, #1      
        mov r2, #5 
        ldr r1, =vacia
		swi 0
