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
	
	@se pone el pin 18 como entrada para el boton

	mov r0,#18
	mov r1,#0
	bl SetGpioFunction
	
	inicio:
	
	push {r0-r12}
	ldr r0,=formatoD
	ldr r1,=halconX
	ldr r1,[r1]
	bl printf
	push {r0-r12}
	
	push {r0-r12}
	//ldr r0,=pixelAddr 
	bl pintarFondo			//Pinta el fondo
	pop {r0-r12}



	@si esta en 10 el contador lo regresa a 1 	
	cmp r4,#10
	moveq r4,#1	
	
	render1:
		
		x	  .req r4
		y         .req r9
		colour 	  .req r3
		addrPixel .req r5
		countByte .req r6
		ancho	  .req r7
		alto	  .req r8
		
		xPos	  .req r1
		yPos	  .req r2
		
		/******************************************************************************/
		
		mov countByte,#0 				//Contador que cuenta la cantidad de bytes dibujados
		ldr ancho,=halcon1Ancho
		ldr ancho,[ancho]
		ldr alto,=halcon1Alto
		ldr alto,[alto]
		ldr y,=0
		ldr yPos, =200 //740
		//Ciclo que dibuja filas
		drawRow1:
			ldr x,=0
			ldr r12, =halconX
			ldr xPos,[r12] //820
			drawPixel1:
				cmp x,ancho				//comparar x con el ancho de la imagen
				bge end1
				
				ldr addrPixel,=halcon3	//Obtenemos la direccion de la matriz con los colores
				ldrb colour,[addrPixel,countByte]	//Leer el dato de la matriz.
				
				ldr r0,=pixelAddr
				ldr r0,[r0]
				
				ldr r11,=0
				cmp colour,r11
				 
				push {r0-r12}
				blne pixel				//Dibujamos el pixel. r1=x,r2=y,r3=colour
				pop {r0-r12}
				
				add countByte,#1 		//Incrementamos los bytes dibujados
				add x,#1 				//Aumenta el contador del ancho de la imagen
				add xPos,#1 
				
				b drawPixel1
				
			
		
		end1:	
			// aumentamos y
			add y,#1
			add ypos,#1 
						
			//Revisamos si ya dibujamos toda la imagen.
			teq y,alto
			bne drawRow1
		
		push {r0-r12}
				ldr r0,=500
				bl esperar			//Esperamos
				pop {r0-r12}
		
		push {r0-r12}
	bl pintarFondo			//Pinta el fondo
	bl boton
	/*ldr r0,=halconX
		ldr r0,[r0]
		add r0,#10
	ldr r1,=halconX
	str r0,[r1]
	
	ldr r0,=formatoD
	ldr r1,=halconX
	ldr r1,[r1]
	bl printf*/
	pop {r0-r12}
	
	
		
		/******************************************************************************/
		
		
		
		mov countByte,#0 				//Contador que cuenta la cantidad de bytes dibujados
		ldr ancho,=halcon2Ancho
		ldr ancho,[ancho]
		ldr alto,=halcon2Alto
		ldr alto,[alto]
		ldr y,=0
		ldr yPos, =200 //740
		//Ciclo que dibuja filas
		drawRow2:
			ldr x,=0
			ldr r12, =halconX
			ldr xPos,[r12] //820
			drawPixel2:
			
				cmp x,ancho				//comparar x con el ancho de la imagen
				bge end2
				
				ldr addrPixel,=halcon2	//Obtenemos la direccion de la matriz con los colores
				ldrb colour,[addrPixel,countByte]	//Leer el dato de la matriz.
				
				ldr r0,=pixelAddr
				ldr r0,[r0]
				
				ldr r11,=0
				cmp colour,r11
				//beq drawPixel2
				 
				push {r0-r12}
				blne pixel				//Dibujamos el pixel. r1=x,r2=y,r3=colour
				pop {r0-r12}
				
				add countByte,#1 		//Incrementamos los bytes dibujados
				add x,#1 				//Aumenta el contador del ancho de la imagen
				add xPos,#1 
				
				b drawPixel2
		end2:	
			// aumentamos y
			add y,#1
			add ypos,#1 
						
			//Revisamos si ya dibujamos toda la imagen.
			teq y,alto
			bne drawRow2
			
	push {r0-r12}
				ldr r0,=500
				bl esperar			//Esperamos
				pop {r0-r12}
	
	push {r0-r12}
	bl pintarFondo			//Pinta el fondo
	bl boton
	
	/*ldr r0,=halconX
	ldr r0,[r0]
		add r0,#10
	ldr r1,=halconX
	str r0,[r1]		
	
	ldr r0,=formatoD
	ldr r1,=halconX
	ldr r1,[r1]
	bl printf*/
	
	pop {r0-r12}
						
				
	
	/******************************************************************************/
		
		mov countByte,#0 				//Contador que cuenta la cantidad de bytes dibujados
		ldr ancho,=halcon3Ancho
		ldr ancho,[ancho]
		ldr alto,=halcon3Alto
		ldr alto,[alto]
		ldr y,=0
		ldr yPos, =200 //740
		//Ciclo que dibuja filas
		drawRow3:
			ldr x,=0
			ldr r12, =halconX
			ldr xPos,[r12] //820
			drawPixel3:
				cmp x,ancho				//comparar x con el ancho de la imagen
				bge end3
				
				ldr addrPixel,=halcon1	//Obtenemos la direccion de la matriz con los colores
				ldrb colour,[addrPixel,countByte]	//Leer el dato de la matriz.
				
				ldr r0,=pixelAddr
				ldr r0,[r0]
				
				ldr r11,=0
				cmp colour,r11
				 
				push {r0-r12}
				blne pixel			//Dibujamos el pixel. r1=x,r2=y,r3=colour
				pop {r0-r12}
				
				add countByte,#1 		//Incrementamos los bytes dibujados
				add x,#1 				//Aumenta el contador del ancho de la imagen
				add xPos,#1 
				
				b drawPixel3
		end3:	
			// aumentamos y
			add y,#1
			add ypos,#1 
						
			//Revisamos si ya dibujamos toda la imagen.
			teq y,alto
			bne drawRow3
	
	push {r0-r12}
			ldr r0,=500
			bl esperar			//Esperamos
			pop {r0-r12}
			
	push {r0-r12}
	bl pintarFondo			//Pinta el fondo
	bl boton
	/*ldr r0,=halconX
	ldr r0,[r0]
		add r0,#10
	ldr r1,=halconX
	str r0,[r1]
	
	ldr r0,=formatoD
	ldr r1,=halconX
	ldr r1,[r1]
	bl printf*/
	
	pop {r0-r12}
	
	
	
	

	.unreq x		  
	.unreq	y         
	.unreq	colour 	  
	.unreq	addrPixel 
	.unreq	countByte 
	.unreq	ancho	  
	.unreq	alto	  
	
	.unreq	xPos	
	.unreq	yPos	

	b inicio
	
.data
.global pixelAddr, halconX
pixelAddr: .word 0

halconX: .word 500

formatoD: .asciz "%d \n"

/***************************************************************************/
//BOTON

.global boton
boton:
	mov r0,#18
	bl GetGpio
	cmp r0,#0
	bne modificar
	mov r0,#300
	//bl esperar

	modificar:
		mov r0,#0
		ldr r0,=halconX
		ldr r0,[r0]
		add r0,#50
		ldr r1,=halconX
		str r0,[r1]
.global GetGpio
GetGpio:
	push {lr}
	push {r5-r8}
	mov r8,r0
	
	ldr r6,=myloc
	ldr r0,[r6]
	ldr r5,[r0,#0x34]
	
	mov r7,#1
	lsl r7,r8
	and r5,r5,r7
	cmp r5,#0
	moveq r0,#0
	movgt r0,#1

	pop {r5-r8}
	pop {pc}
	
/***************************************************************************/

