/******************************************************************************
*	UVG
*	Taller de Assembler
*	LAB3 - Juego
*   Creado: 09/10/2016
*	Davis Alvarez - 15842
*	Jennifer Barillas -15307
*******************************************************************************/
 
 .text
 .align 2
 .global main
main:
	#-------------------------
	#get screen address
	#-------------------------
	bl getScreenAddr
	ldr r1,=pixelAddr
	str r0,[r1]
	
	ldr r0,=halconX
	ldr r0,[r0]
	ldr r1,=halconX
	str r0,[r1]
	
	inicio:
	
	push {r0-r12}
	//ldr r0,=pixelAddr 
	bl pintarFondo			//Pinta el fondo
	pop {r0-r12}
	
		
		/******************************************************************************/
		
		push {r0-r12}	
	bl pintarHalcon	
	pop {r0-r12}
		
		push {r0-r12}
				ldr r0,=500
				bl esperar			//Esperamos
				pop {r0-r12}
		
		push {r0-r12}
	bl pintarFondo			//Pinta el fondo
	
	ldr r0,=halconX
		ldr r0,[r0]
		add r0,#50
	ldr r1,=halconX
	str r0,[r1]

	pop {r0-r12}
	
	
		
		/******************************************************************************/
		
	push {r0-r12}	
	bl pintarHalcon	
	pop {r0-r12}	
	
			
	push {r0-r12}
				ldr r0,=500
				bl esperar			//Esperamos
				pop {r0-r12}
	
	push {r0-r12}
	bl pintarFondo			//Pinta el fondo
	ldr r0,=halconX
	ldr r0,[r0]
		add r0,#50
	ldr r1,=halconX
	str r0,[r1]		
	

	pop {r0-r12}
						
				
	
	/******************************************************************************/
	push {r0-r12}	
	bl pintarHalcon	
	pop {r0-r12}
	
	push {r0-r12}
			ldr r0,=500
			bl esperar			//Esperamos
			pop {r0-r12}
			
	push {r0-r12}
	bl pintarFondo			//Pinta el fondo
	ldr r0,=halconX
	ldr r0,[r0]
		add r0,#50
	ldr r1,=halconX
	str r0,[r1]
	
	
	
	pop {r0-r12}

/******************ESTRELLA*******************/
	estrella:
		
		
		push {r0-r12}	
		bl pintarEstrella	
		pop {r0-r12}
		
		push {r0-r12}
				ldr r0,=100
				bl esperar			//Esperamos
				pop {r0-r12}
				
		push {r0-r12}
		bl pintarFondo			//Pinta el fondo
		ldr r0,=estrellaY
		ldr r0,[r0]
			add r0,#50
		ldr r1,=estrellaY
		str r0,[r1]
		
		pop {r0-r12}
		
		@al llegar al final de la imagen
		ldr r0,=tamano
		ldr r1,[r0]
		sub r1,r1,#50
		str r1,[r0]
		
		cmp r1,#20
		ldrlt r0,=estrellaY
		movlt r1,#400
		strlt r1,[r0]
		
		b estrella

	b inicio
	
.data
.global pixelAddr, halconX, nave, formatoD
pixelAddr: .word 0
estrellaY: .word 0
halconX: .word 500
nave:	.word 0
tamano:	.word 664
estrellas:	.word 0

formatoD: .asciz "%d \n"


