.data
Selection:    .asciiz " \n Choose an option between 1 and 4 \n"
Choices:      .asciiz "1.) Convert Binary to Hexadecimal and Decimal \n2.) Convert Hexadecimal to Binary and Decimal \n3.) Convert Decimal to Binary and Hexadecimal \n4.) "
userInput:    .space 32
Binary:       .asciiz " Binary Number is:  " 
Decimal:      .asciiz " Decimal Number is:  "
Hexadecimal:  .asciiz " Hexadecimal Number is:  "
invalidhex:   .asciiz "Invalid Hexadecimal Input"
invalidBinary:.asciiz "Invalid Binary Input"
invalidDec:   .asciiz "Invalid Decimal Input "
enterDec:     .asciiz "Enter Decimal Number: "
invalidOption: .asciiz "Invalid option, please try again.\n"
menuPrompt: .asciiz "Enter your choice: "

        .text 
main: 
    jal Menu
    
    li $v0,10
    syscall
    
    
Menu:  

    addi    $sp, $sp, -4    # push $s0
    sw    $ra, 0($sp)
    # Menu 
Mloop:
    la $a0, Selection
    li $v0, 4 
    syscall
    la $a0, Choices
    li $v0, 4 
    syscall

    la $a0, menuPrompt
    li $v0, 4
    syscall

    li $v0, 8
    la $a0, userInput
    li $a1, 32
    syscall

    jal validateMenuChoice
    move $t7, $v0
    
    beq $t7, $t1, BHD
    beq $t7, $t2, HBD
    beq $t7, $t3, DBH
    beq $t7, $t4, end
    j invalidChoice
    
validateMenuChoice:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $t1, 1
    li $t2, 2
    li $t3, 3
    li $t4, 4
    li $t5, 0x30  # ASCII '0'

    lb $t0, 0($a0)
    sub $t0, $t0, $t5

    beq $t0, $t1, validChoice
    beq $t0, $t2, validChoice
    beq $t0, $t3, validChoice
    beq $t0, $t4, validChoice

    li $v0, 0
    j returnValidate

validChoice:
    move $v0, $t0

returnValidate:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

BHD: 
    jal bhd
    j Mloop
    
HBD: 
    jal hbd
    j Mloop
DBH:    
    jal dbh
    j Mloop 
end:
    lw    $ra, 0($sp)    # pop $s0
    addi    $sp, $sp, 4
    jr     $ra

invalidChoice:
    la $a0, invalidOption
    li $v0, 4
    syscall
    j Mloop

   
    
bhd:
    addi    $sp, $sp, -4    # push $s0
    sw    $ra, 0($sp)
    #Binary
    li $v0,4
    la $a0,Binary
    syscall
    #String input from user
    li $v0,8
    la $a0,userInput
    li $a1,32
    syscall 
    la $a0,userInput
    
    jal BtoD
    bnez  $v1,inva
    # Decimal 
    move $s1,$v0
    la $a0,Decimal
    li $v0,4
    syscall 
    move $a0,$s1
    li $v0,1
    syscall
    
    #Hexadecimal
    la $a0,Hexadecimal
    li $v0,4
    syscall 
    move $a0,$s1
    li $v0,34
    syscall
inva:
    lw    $ra, 0($sp)    # pop $s0
    addi    $sp, $sp, 4
    jr     $ra



hbd:
    addi    $sp, $sp, -4    # push $s0
        sw    $ra, 0($sp)
    
    #Hexadecimal
    la $a0,Hexadecimal
    li $v0,4
    syscall 
    #String input from user
    li $v0,8
    la $a0,userInput
    li $a1,32
    syscall 
    la $a0,userInput
    
    jal HtoD
    bnez  $v1,inv
    # Decimal 
    move $s1,$v0
    la $a0,Decimal
    li $v0,4
    syscall 
    
    move $a0,$s1
    li $v0,1
    syscall
    
    #Binary
    li $v0,4
    la $a0,Binary
    syscall
    
    move $a0,$s1
    li $v0,35
    syscall
     
inv:
    lw    $ra, 0($sp)    # pop $s0
    addi    $sp, $sp, 4
    jr     $ra

dbh:    
    addi    $sp, $sp, -4    # push $s0
    sw    $ra, 0($sp)
    #String input from user
    
    la $a0,enterDec
    li $v0,4
    syscall
    
    li $v0,8
    la $a0,userInput
    li $a1,32
    syscall 
    
    jal StoD 
    bnez  $v1,invalidd 
    move $s0,$v0
    la $a0,Decimal
    li $v0,4
    syscall 
    move $a0,$s0 
    li $v0,1
    syscall
    
    #Binary 
    li $v0,4
    la $a0,Binary
    syscall
    move $a0,$s0 
    li $v0,35
    syscall

    #hex 
    la $a0,Hexadecimal
    li $v0,4
    syscall 
    move $a0,$s0 
    li $v0,34 
    syscall
    
invalidd:
    lw    $ra, 0($sp)    # pop $s0
    addi    $sp, $sp, 4
    jr     $ra

# Methods 

StoD:
    addi    $sp, $sp, -4     
    sw    $s0, 0($sp)
    li     $s3,9
    li     $v1,0
    li    $v0,0
    li     $s4,0xA
    addi    $t5,$zero,0x30  #'0'
loop3:
    lb      $t0,0($a0)  
    beq     $t0,$s4,bre
    sub     $t1,$t0,$t5
    bltz     $t1,DecInvalid 
    bgt    $t1,$s3,DecInvalid
    
    mul     $t2,$v0,10      
    add     $v0,$t2,$t1    
    addi    $a0,$a0,1           
    j    loop3                           
bre:
    lw    $s0, 0($sp)    
    addi    $sp, $sp, 4
    jr      $ra                             
DecInvalid:
        la $a0,invalidDec
    li $v0,4
    syscall
    li $v1,1
    j bre

HtoD: 
    addi    $sp, $sp, -4    
    sw    $s0, 0($sp)
    li    $v0, 0
    li     $s4,0xA
    li     $v1,0
    
    # Initialize
    move    $v0,$zero
    li    $t3,6   
    li    $t4,10  
    
    li      $t5,0x30 #'0'
    li      $t6,0x41 #'A'
    li      $t7,0x61 #'a'
    
loop:
    lb      $t0,0($a0)  
    beq     $t0,$s4,branch  
         
    sub     $t1,$t0,$t5     # get digit value
    bltz    $t1,invalid             # <0 invalid
    
    sub     $t2,$t1,$t4         
    bltz    $t2,valid             # <0 valid
    
    sub     $t1,$t0,$t6     #'A':0x41
    bltz    $t1,invalid             # <0 invalid
    
    sub     $t2,$t1,$t3         # hex+10 value
    bltz    $t2,toHex           # <0  then +10
    
    sub     $t1,$t0,$t7     # 'a':0x61
    bltz    $t1,invalid             # invalid
    
    sub     $t2,$t1,$t3         # -6
    bltz    $t2,toHex           # check 
    
    j       invalid             
toHex:
    addi    $t1,$t1,10          #conversion
    
valid:
    sll     $t2,$v0,4       
    add     $v0,$t2,$t1     
    addi    $a0,$a0,1           
    j    loop  
    
branch:
    lw    $s0, 0($sp)    
    addi    $sp, $sp, 4
    jr  $ra                             

invalid:
    la $a0,invalidhex
    li $v0,4
    syscall
    li $v1,1
    j branch

BtoD: 
    li      $s2, 0xA
    li     $s3,1
    li     $v1,0
    addi    $sp, $sp, -4    
    sw    $s0, 0($sp)
    move    $v0,$zero  
loop2:
    lb    $s0, 0($a0)     # load next 
    beq     $s0, $s2, done2 
    sll    $v0, $v0, 1    # left-shift
    subi    $s0, $s0, 48    #  ascii '0'
    add    $v0, $v0, $s0    # add $s0 
    bltz    $s0,Bininv    #     <0 
    bgt    $s0,$s3,Bininv    #     >1
    addi    $a0, $a0, 1    # increment
    j    loop2

Bininv:
    la $a0,invalidBinary
    li $v0,4
    syscall
    li $v1,1
    j done2

done2:
    lw    $s0, 0($sp)    
    addi    $sp, $sp, 4
    jr    $ra        



