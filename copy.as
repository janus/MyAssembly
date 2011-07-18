.section .data
my_string:
   .asciz "Hello World\n0"
.equ END, '0'
.equ ENDWELL, '\n'
#Copy from one location to another    

.section .bss
#Allocating memory space that would be used later
.equ BUFFER_SIZE, 13
.lcomm BUFFER_DATA, BUFFER_SIZE

.section .text

.globl _start

_start:

movl $0, %edi
movl $0, %esi

myLoop:
movb my_string(,%esi,1),%cl
cmpb $END, %cl
je my_end
movb %cl, BUFFER_DATA(,%edi, 1)
incl %edi
incl %esi
jmp myLoop

my_end:
#incl %edi
#movb $ENDWELL, BUFFER_DATA(,%edi, 1)
movl $4, %eax
movl $1, %ebx
movl $BUFFER_DATA, %ecx
movl $BUFFER_SIZE, %edx

int $0x80

movl $1, %eax
movl $0, %ebx
int $0x80

