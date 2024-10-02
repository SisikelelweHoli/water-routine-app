.data
    morningPrompt:    .asciiz "Please enter the amount of water you took in the morning in ml:\n"
    afternoonPrompt:  .asciiz "Please enter the amount of water you took in the afternoon in ml:\n"
    eveningPrompt:    .asciiz "Please enter the amount of water you took in the evening in ml:\n"
    nightPrompt:      .asciiz "Please enter the amount of water you took at night in ml:\n"
    totalMessage:     .asciiz "The total water intake is "
    lessMessage:      .asciiz " ml less than the target\n"
    moreMessage:      .asciiz " ml more than the target\n"
    equalMessage:     .asciiz "You have reached your daily limit!!!\n"

.text
.globl main

main:
    # Prompt and read morning intake
    li $v0, 4                  
    la $a0, morningPrompt      
    syscall

    li $v0, 5                  
    syscall
    move $t0, $v0             

    # Prompt and read afternoon intake
    li $v0, 4
    la $a0, afternoonPrompt
    syscall

    li $v0, 5
    syscall
    move $t1, $v0              

    # Prompt and read evening intake
    li $v0, 4
    la $a0, eveningPrompt
    syscall

    li $v0, 5
    syscall
    move $t2, $v0              

    # Prompt and read night intake
    li $v0, 4
    la $a0, nightPrompt
    syscall

    li $v0, 5
    syscall
    move $t3, $v0             

    # Calculate total intake
    add $t4, $t0, $t1         
    add $t4, $t4, $t2        
    add $t4, $t4, $t3         

    # Print total intake
    li $v0, 4
    la $a0, totalMessage
    syscall

    li $v0, 1                 
    move $a0, $t4             
    syscall

    li $a0, 300               
    li $t5, 300              

    # Compare totalIntake with target
    blt $t4, $t5, less_than  
    bgt $t4, $t5, more_than    

equal:
    # Print "You have reached your daily limit!!!"
    li $v0, 4
    la $a0, equalMessage
    syscall
    b exit                   

less_than:
    # Print how much less water was consumed
    sub $t6, $t5, $t4         
    li $v0, 1
    move $a0, $t6
    syscall

    li $v0, 4
    la $a0, lessMessage
    syscall
    b exit                     # jump to exit

more_than:
    # Print how much more water was consumed
    sub $t6, $t4, $t5          
    li $v0, 1
    move $a0, $t6
    syscall

    li $v0, 4
    la $a0, moreMessage
    syscall

exit:
    li $v0, 10                 # system call for exit
    syscall