.data
numero: .asciz "25 + 26"
num1: .int 0
num2: .int 0
.text
.global main
main:	ldr r0,=numero
		ldr r1,=num1
		ldr r6,=num2
		ldrb r7,[r6] /*Preparo la variable num2. NUM2 esta en R7*/
		ldrb r3,[r1] /*Preparo la variable num1. NUM1 esta en R3*/
		mov r4,#0 /*Para saber si es el primer digito del numero*/
		mov r5,#10 /*Para multiplicar*/
	
loop: 	ldrb r2,[r0] /*Elemento actual*/
		cmp r2,#00 /*Comparo si termine de leer la cadena*/
			beq salir /*Salgo del programa*/
		cmp r4,#0  /*Comparo para ver si es el primer digito del numero*/
			beq p_dig /* Si es el primer digito, me voy a esta subrutina*/
		cmp r4,#4 /*Cuando esto este en 4, el programa sabe que es el segundo operando*/
			beq s_dig
		cmp r2,#0x20 /*Comparo si el elemento actual es un ESPACIO*/
			beq s_pos /*Si es un espacio, salteo 3 LINEAS*/
		cmp r4,#6	/* */
			beq s_seg
		/*Si nada de lo anterior sucede, solamente le suma a valor el ultimo digito*/
		sub r2,#0x30 /*Convierto el ASCII a entero*/ 
		add r3,r3,r2 /*Se lo agrego a valor*/
		add r0,r0,#1 /*Paso al elemento siguiente*/
		b loop /*Vuelvo al loop*/
		bx lr
		
s_pos:	add r0,r0,#3 /*Le sumo 3 posiciones para pasar al segundo operando*/
		mov r4,#4 /*Muevo 4 para pasar a la segunda subrutina*/
		bal loop /*Vuelvo al loop*/

s_seg:	sub r2,#0x30 /*Convierto el ASCII a entero*/ 
		add r7,r7,r2 /*Se lo agrego a NUM2*/
		add r0,r0,#1 /*Paso al elemento siguiente*/
		b loop /*Vuelvo al loop*/
		bx lr			

s_dig:	sub r2,#0x30
		mla r7,r2,r5,r7 /*R7=(R2*10)+R7*/
		mov r4,#6 /*Le paso un 6 a R4, solamente para que el programa sepa que ya no estoy en el primer elemento*/
		add r0,r0,#1 /*Paso al elemento siguiente*/
		bal loop /*Vuelvo al loop*/

p_dig:	sub r2,#0x30
		mla r3,r2,r5,r3 /*R3=(R2*10)+R3*/
		add r4,#1 /*Le paso un 1 a R4, solamente para que el programa sepa que ya no estoy en el primer elemento*/
		add r0,r0,#1 /*Paso al elemento siguiente*/
		bal loop /*Vuelvo al loop*/

salir:	bx lr