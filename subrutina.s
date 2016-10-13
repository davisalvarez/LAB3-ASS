/******************************************************************************
*	UVG
*	Taller de Assembler
*	LAB3 - Juego
*   Creado: 09/10/2016
*	Davis Alvarez - 15842
*	Jennifer Barillas -15307
*******************************************************************************/
 
 .global pintarFondo
pintarFondo:
	
		push {lr}
		
		x	  .req r1
		y         .req r2
		colour 	  .req r3
		addrPixel .req r5
		countByte .req r6
		ancho	  .req r7
		alto	  .req r8

		mov countByte,#0 				//Contador que cuenta la cantidad de bytes dibujados
		ldr ancho,=fondoPrincipalAncho
		ldr ancho,[ancho]
		ldr alto,=fondoPrincipalAlto
		ldr alto,[alto]
		mov y,#0
		//Ciclo que dibuja filas
		drawRow$:
			mov x,#0
			drawPixel$:
				cmp x,ancho				//comparar x con el ancho de la imagen
				bge end
				ldr addrPixel,=fondoPrincipal	//Obtenemos la direccion de la matriz con los colores
				ldrb colour,[addrPixel,countByte]	//Leer el dato de la matriz.
				
				ldr r0,=pixelAddr
				ldr r0,[r0] 
				push {r0-r12}
				bl pixel				//Dibujamos el pixel. r1=x,r2=y,r3=colour
				pop {r0-r12}
				add countByte,#1 		//Incrementamos los bytes dibujados
				add x,#1 				//Aumenta el contador del ancho de la imagen
			
				b drawPixel$
		end:	
			// aumentamos y
			add y,#1
						
			//Revisamos si ya dibujamos toda la imagen.
			teq y,alto
			bne drawRow$

	.unreq x		  
	.unreq	y         
	.unreq	colour 	  
	.unreq	addrPixel 
	.unreq	countByte 
	.unreq	ancho	  
	.unreq	alto
	
	pop {pc}
	/*****************************************************************************/
	
	
	
	/*****************************************************************************/
pintarHalcon:
	push {lr}
	
	x	  .req r4
	y         .req r9
	colour 	  .req r3
	addrPixel .req r5
	countByte .req r6
	ancho	  .req r7
	alto	  .req r8
		
	xPos	  .req r1
	yPos	  .req r2
	
	ldr r11,=nave
	ldr r11,[r11]
	
	cmp r11,#0
	beq pintarHalcon1
	cmp r11,#2
	beq pintarHalcon2
	cmp r11,#3
	beq pintarHalcon3
	
	pintarHalcon1:
		add r11,#1
		ldr r12,=nave
		str r11,[r12]
		
		
		
		b finPintarHalcon
		
	pintarHalcon2:
		add r11,#1
		ldr r12,=nave
		str r11,[r12]
		
		
		
		b finPintarHalcon
	
	pintarHalcon3:
		ldr r11,=0
		ldr r12,=nave
		str r11,[r12]
		
		
		
		b finPintarHalcon
	
		
	finPintarHalcon:
	
		.unreq x		  
		.unreq	y         
		.unreq	colour 	  
		.unreq	addrPixel 
		.unreq	countByte 
		.unreq	ancho	  
		.unreq	alto	  
	
		.unreq	xPos	
		.unreq	yPos	
	
		pop {pc}
	/*****************************************************************************/

.end
