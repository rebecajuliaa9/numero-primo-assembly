#esse programa identifica qual numero vai dar resto zero
#os registradores na sintaxe do gas sao acessados com %rax
#sessao de data e usada para declarar dados
.section .data
  entrada: #nome da variavel
    .int 4 #tipo e valor da variavel
 
  primo:
    .ascii "e um numero primo\n"
  final_primo:
    .equ tamanho_primo, final_primo - primo

  nao_primo:
    .ascii "nao e um numero primo\n"
  final_nao_primo:
    .equ tamanho_nao_primo, final_nao_primo - nao_primo

#sessao de texto e usada para manter o codigo que vai ser executado
.section .text 
  .globl _start #informa ao kernel onde vai começar
    _start:
	# quando fazemos o or entre a e b estamos comparando duas coisas e igual por isso e 0
	# %rax or %rax = 0
      xor %rax, %rax #definindo o registrador %rax como 0
      xor %rbx, %rbx #definindo o registrador %rbx como 0
      xor %rcx, %rcx #definindo o registrador %rcx como 0
      xor %rdx, %rdx #definindo o registrador %rdx como 0
      xor %rdi, %rdi #definindo o registrador %rdx como 0

      mov entrada, %eax #copia o valor da variavel entrada para o registrador %eax
      mov entrada, %ebx #copia o valor da variavel entrada para o registrador %ebx
      mov entrada, %ecx #copia o valor da variavel entrada para o registrador %ecx
      jmp repeticao #ocorre um salto para um rotulo

   #rotulo e como se fosse a definicao do que esse codigo vai fazer
   repeticao: #rotulo de repeticao
	#%ecx = 5
      cmp $0, %ecx #compara os valores entre o registrador e o numero 0
      je verifica_numero_primo #se os valores comparado acima forem iguais, ele vai fazer um salto e vai chamar o rotulo fim  

	#%edx = 0

      xor %edx, %edx # comparando os valores entre o registrados %edx, se forem iguais o valor em %edx vai ser 0 se não 1

      #o div vai realizar uma divisao entre %eax/%ecx ou seja  5/5 = 1, quociente ou resultado e igual a 1 e o resto igual a 0
	#%eax = 5 , %ecx = 5, %edx = 0
      div %ecx

      #o resto da divisao e armazenada no %edx e o resultado no %eax   
	# %edx = 0
      cmp $0, %edx #comparando se o valor do %edx que e 0 e igual a 0 
      je contar #se os valores comparados acima forem iguais ele faz um salto para outro rotulo
      dec %ecx #diminui em 1 o valor do registrador %ecx
      mov %ebx, %eax #copiando o valor do %ebx para o %eax
      jne repeticao #se for diferente de 0 ele chama o rotulo de repeticao dnv
 
    contar: # rotulo para contar
       # xor %rdi, %rdi #definindo o valor de %rdi para 0
       inc %rdi # adicionar/incrementa em 1 o %rdi e como o i++
       dec %ecx #decrementar em 1 o %ecx = 4
       mov %ebx,%eax #copiar o valor de %ebx para %eax
       cmp $0, %ecx 
       push %rdi
       jmp repeticao #chama outro rotulo

     verifica_numero_primo:
        pop %rdi
        cmp $2, %rdi #se forem iguais significa que é primo 
        je numero_primo# se forem iguais ele chama o rotulo numero primo  
        jne numero_nao_primo #se forem diferentes ele chama o rotulo não primo
	
     numero_primo:
	    movl $4, %eax
      	movl $1, %ebx
      	movl $primo, %ecx
      	movl $tamanho_primo, %edx
      	int $0x80
      	call funcao_fim

     numero_nao_primo:
	    movl $4, %eax
      	movl $1, %ebx
      	movl $nao_primo, %ecx
      	movl $tamanho_nao_primo, %edx
      	int $0x80
      	call funcao_fim

     funcao_fim: #funcao de finalizar
	    movl $0, %ebx #copia o valor 0 para o registrador %ebx
         movl $1, %eax #copia o valor 1 para o registrador %eax
	    int $0x80 #interrupcao da execucao
	    ret