.data
input_usuario: .asciz "       "            
mensajeDeBienvenida: .asciz "Hola, ¿Como estas?, Ingrese una operacion: "                                                                 
mensaje_error:  .asciz "Lo siento, mis respuestas son limitadas \n"
text_result: .asciz ""
posicion: .asciz "0"
operacion: .byte 0
num1: .int 0
num2: .int 0
resultado: .int 0
resto: .int 0
mensaje_despedida: .asciz "Adios! \n"
.text
.global main

/*----------------------MAIN/INPUT------------------------------------------------- */
main:   push {r0,r1,r2,r4,r7}
        mov r7, #4      
        mov r0, #1      
        mov r2, #45 
        ldr r1, =mensajeDeBienvenida 
		swi 0
        pop {r0,r1,r2,r4,r7}
        bal in_us

in_us:  push {r0,r2,r7}
        mov r7, #3
        mov r0, #0
        mov r2, #10
        ldr r1, =input_usuario
		swi 0
        pop {r0,r2,r7}
		bal sv
        bx lr
/*----------------------------------------------------------------------- */

/*---------------------GUARDAR VALORES-------------------------------------------------- */		
sv:		push {r0,r1,r2,r4,r5,r6}
		ldr r0,=num1
		ldr r6,=num2
		ldrb r7,[r6] /*Preparo la variable num2. NUM2 esta en R7*/
		ldrb r3,[r0] /*Preparo la variable num1. NUM1 esta en R3*/
		mov r4,#0 /*Para saber si es el primer digito del numero*/
		mov r5,#10 /*Para multiplicar*/
		bal loop
	
loop: 	ldrb r2,[r1] /*Elemento actual*/
		cmp r2,#00 /*Comparo si termine de leer la cadena*/
	        beq sign /*Salgo del programa*/
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
		add r3,r3,r2 /*Se lo agrego a NUM1*/
		add r1,r1,#1 /*Paso al elemento siguiente*/
		b loop /*Vuelvo al loop*/
		bx lr
		
s_pos:	add r1,r1,#3 /*Le sumo 3 posiciones para pasar al segundo operando*/
		mov r4,#4 /*Muevo 4 para pasar a la segunda subrutina*/
		bal loop /*Vuelvo al loop*/

s_seg:	sub r2,#0x30 /*Convierto el ASCII a entero*/ 
		add r7,r7,r2 /*Se lo agrego a NUM2*/
		add r1,r1,#1 /*Paso al elemento siguiente*/
		b loop /*Vuelvo al loop*/
		bx lr			

s_dig:	sub r2,#0x30
		mla r7,r2,r5,r7 /*R7=(R2*10)+R7*/
		mov r4,#6 /*Le paso un 6 a R4, solamente para que el programa sepa que ya no estoy en el primer elemento*/
		add r1,r1,#1 /*Paso al elemento siguiente*/
		bal loop /*Vuelvo al loop*/

p_dig:	cmp r2,#'-'
		beq neg
		sub r2,#0x30
		mla r3,r2,r5,r3 /*R3=(R2*10)+R3*/
		add r4,#1 /*Le paso un 1 a R4, solamente para que el programa sepa que ya no estoy en el primer elemento*/
		add r1,r1,#1 /*Paso al elemento siguiente*/
		bal loop /*Vuelvo al loop*/
		
neg:	mov r11,#1
		add r1,r1,#1
		bal loop
		
/*----------------------------------------------------------------------- */

/*----------------------------RECO_SIGNO------------------------------------------- */		
sign:	pop {r0,r1,r2,r4,r5,r6}
		mov r0,#0
		mov r1,#0
		push {r0,r1,r4,r5,r6}
		ldr r1, =input_usuario
		bal lo_si
	
lo_si: 	ldrb r2,[r1] /*Elemento actual*/
		cmp r2,#00 /*Comparo si termine de leer la cadena*/
	        beq salir /*Salgo del programa*/
		cmp r2, #'+'
			beq suma
		cmp r4,#0  
	        beq pr_dig
		cmp r2,#'-'	
			beq resta
		cmp r2, #'*'
			beq mult
		cmp r2, #'/'
			beq divi
		/*Si nada de lo anterior sucede, solamente le suma a valor el ultimo digito*/
		add r1,r1,#1 /*Paso al elemento siguiente*/
		b lo_si /*Vuelvo al loop*/
		bx lr
			
pr_dig:	add r1,r1,#1 /*Paso al elemento siguiente*/
		mov r4,#1
		b lo_si

/*----------------------------------------------------------------------- */

/*----------------------------SUMA------------------------------------------- */
suma:	cmp r11, #1
		beq su_neg
		mov r2,r3
		add r2,r7
		b g_re
		bx lr
		
su_neg:	mov r5,#-1
		mul r2,r3,r5
		add r2,r7
		b g_re
/*----------------------------------------------------------------------- */


/*-------------------------RESTA---------------------------------------------- */
resta:	cmp r11, #1
		beq re_neg
		mov r2,r3
		sub r2,r7
		b g_re
		bx lr
		
re_neg:	mov r5,#-1
		mul r2,r3,r5
		sub r2,r7
		b g_re
/*----------------------------------------------------------------------- */

/*--------------------------------MULT--------------------------------------- */

mult:	mul r2,r3,r7
		b g_re
		bx lr
/*----------------------------------------------------------------------- */



/*--------------------------------DIVISION--------------------------------------- */
divi:	cmp r3,r7
			blt g_div 
		subs r3,r7
		add r9,r9,#1
		bal divi
/*----------------------------------------------------------------------- */	

g_div:	ldr r1,=resultado
		ldr r4,=resto
		strb r9,[r1]
		strb r3,[r4]
		
		ldrb r10,[r4]
		b salir


g_re:	ldr r1,=resultado
		strb r2,[r1]
		b salir

salir:	pop {r0,r1,r4,r5,r6}
		b despedida
		
		
		
despedida: 	push {r0,r1,r2,r4,r7}
        	mov r7, #4      
        	mov r0, #1      
        	mov r2, #92   
        	ldr r1, =mensaje_despedida
			swi 0
        	pop {r0,r1,r2,r4,r7}
			mov r7, #1
			swi 0
