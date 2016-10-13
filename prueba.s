 .text
 .align 2
 .global main
main:
	
	@se pone el pin 18 como entrada para el boton
	mov r0,#18
	mov r1,#0
	bl SetGpioFunction

	boton:
		mov r0,#18
		bl GetGpio
		cmp r0,#0
		bne imprimir
		beq boton
		@mov r0,#300
		@bl esperar

		imprimir:
			mov r0,#0
			ldr r0,=mensaje
			bl puts
		b boton
		
.data
mensaje:	.asciz "holis"
	
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

.global SetGpioFunction
SetGpioFunction:
    pinNum .req r0
    pinFunc .req r1
	cmp pinNum,#53
	cmpls pinFunc,#7
	movhi pc,lr

	push {lr}
	mov r2,pinNum
	.unreq pinNum
	pinNum .req r2
	@bl GetGpioAddress no se llama la funcion sino
	ldr r6, =myloc
 	ldr r0, [r6] @ obtener direccion 	
	gpioAddr .req r0

	functionLoop$:
		cmp pinNum,#9
		subhi pinNum,#10
		addhi gpioAddr,#4
		bhi functionLoop$

	add pinNum, pinNum,lsl #1
	lsl pinFunc,pinNum

	mask .req r3
	mov mask,#7					/* r3 = 111 in binary */
	lsl mask,pinNum				/* r3 = 11100..00 where the 111 is in the same position as the function in r1 */
	.unreq pinNum

	mvn mask,mask				/* r3 = 11..1100011..11 where the 000 is in the same poisiont as the function in r1 */
	oldFunc .req r2
	ldr oldFunc,[gpioAddr]		/* r2 = existing code */
	and oldFunc,mask			/* r2 = existing code with bits for this pin all 0 */
	.unreq mask

	orr pinFunc,oldFunc			/* r1 = existing code with correct bits set */
	.unreq oldFunc

	str pinFunc,[gpioAddr]
	.unreq pinFunc
	.unreq gpioAddr
	pop {pc}
	

/***************************************************************************/
