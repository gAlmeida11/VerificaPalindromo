.data
	#mensagens
	msg1: .asciiz "Digite um Numero: "
	msg2: .asciiz "Numero invalido, digite novamente: "
	msg3: .asciiz "Palindromo"
	msg4: .asciiz "Nao e Palindromo"
	msg5: .asciiz "\nDejesa testar outro numero ? (0/1)"
	msg6: .asciiz "Opcao invalida, tente de novo"
.text

#registradores 
#$t0 - numero
#$t1 - auxiliar
#$t2 - invertido
#$t3 - invertido * 10
#$t4 - auxiliar % 10
#$t5 - opção p/retornar

#codigo principal
main:
	#escrever msg1
		li $v0, 4
		la $a0, msg1
		syscall
		#ler numero
		li $v0, 5
		syscall
		#adicionar o numero em $t0
		add $t0, $v0, $zero
		
	#se $t0 < 1 ou > 10000, então
	blt $t0, 1, SeValidacao
	bgt $t0, 10000, SeValidacao
	#senao
	j FimSeValidacao
	
	SeValidacao:
		#loop p/ validar numero
		LoopValidacao:
		#escrever msg2
		li $v0, 4
		la $a0, msg2
		syscall
		#ler numero
		li $v0, 5
		syscall
		#adicionar o numero em $t0
		add $t0, $v0, $zero
		#condições do loop
		blt $t0, 1, LoopValidacao
		bgt $t0, 10000, LoopValidacao
		
	FimSeValidacao:
		#auxiliar = numero
		add $t1, $t0, $zero
		#invertido = 0
		add $t2, $t2, $zero
		
		#loop p/ espelhar o numero
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
			la $a0, msg3
			syscall
			j NovoNumero
			
		senao:
			li $v0, 4
			la $a0, msg4
			syscall
			
		NovoNumero:
		li $v0, 4
		la $a0, msg5
		syscall
		li $v0, 5
		syscall
		add $t5, $v0, $zero
		beq $t5, 0, fim
		beq $t5, 1, main
		
		RetornoValidacao:
			li $v0, 4
			la $a0, msg6
			syscall
			#ler numero
			li $v0, 5
			syscall
			#adicionar o numero em $t0
			add $t5, $v0, $zero
			#condições do loop
			blt $t5, 0, RetornoValidacao
			beq $t5, 0, fim
			beq $t5, 1, main
			bgt $t5, 1, RetornoValidacao
		
		fim:
		
		