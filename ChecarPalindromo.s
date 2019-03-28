.data
	msg1: .asciiz "Digite um Numero: "
	msg2: .asciiz "Palindromo"
	msg3: .asciiz "Nao e Palindromo"
.text

#$t0 - numero
#$t1 - aux
#$t2 - invertido
#$t3 - invertido * 10
#$t4 - aux % 10

main:	
	#loop p/ validar numero
	LoopValidacao:
		#escrever msg1
		li $v0, 4
		la $a0, msg1
		syscall
		#ler numero
		li $v0, 5
		syscall
		#adicionar o numero em $t0
		add $t0, $v0, $zero
		#condições do loop
		# < 1
		blt $t0, 1, LoopValidacao
		bgt $t0, 10000, LoopValidacao
	
	#aux = numero
	add $t1, $t0, $zero
	#invertido = 0
	add $t2, $t2, $zero
	
	#loop p/ inverter numero
	LoopPalindromo:
		mul $t3, $t2, 10
		rem $t4, $t1, 10
		add $t2, $t3, $t4
		div $t1, $t1, 10
		bne $t1, 0, LoopPalindromo
	
	#apresentar resultado
	beq $t2, $t0, se
	j senao
	se:
		li $v0, 4
		la $a0, msg2
		syscall
		j fim
	senao:
		li $v0, 4
		la $a0, msg3
		syscall
		
	fim: