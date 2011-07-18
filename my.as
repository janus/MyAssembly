# Title case
.section .data
.equ EMPTY, ' '
.equ FIRSTCH, 'a'
.equ LASTCH, 'z'
.equ CONVERSION, 'A' - 'a'
.equ END, '0'
mystring:
.ascii "this is emeka, my world starts off here\n0"
mystring_end:
.equ mystring_len, mystring_end - mystring
.equ LINUX_SYSCALL, 0x80

.section .text
.globl _start
_start:


movl $0, %edi

movb mystring(,%edi,1), %cl
jmp start_checking
#Jumping from one character to another
my_start:
movb mystring(,%edi,1), %cl
cmpb $END, %cl
je my_end
cmpb $EMPTY, %cl
je Next_Capital
incl %edi
jmp my_start
Next_Capital:
incl %edi
movb mystring(,%edi,1), %cl
start_checking:
cmpb $END, %cl
je my_end
cmpb $FIRSTCH , %cl
jge Continue_Check
incl %edi
jmp my_start
 Continue_Check:
cmpb $LASTCH , %cl
jle touppercase
incl %edi
jmp my_start

touppercase:
 addb $CONVERSION, %cl
movb %cl, mystring(,%edi,1)
incl %edi
jmp my_start


my_end:
movl $4 , %eax
movl $1 , %ebx
movl $mystring, %ecx
movl $mystring_len , %edx
int $LINUX_SYSCALL 

movl $0, %ebx
movl $1 , %eax
int $LINUX_SYSCALL

