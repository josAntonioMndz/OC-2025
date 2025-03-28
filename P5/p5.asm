%include "../LIB/pc_iox.inc"

section .data

section .bss
    N resw 1

section .text
    global _start

_start:

    ; INCISO a
    mov ebx, 0x5C4B2A60

    ; Sumar mi matrícula 0x1280062 a EBX
    add ebx, 0x01280062

    mov eax, ebx
    call pHex_dw

    call SDL

    ; INCISO b
    ; Colocar los 16 bits menos significtativos de EBX en la pila
    push bx

    ; INCISO c
    ; Multiplicar Bl por 8 y guardar el valor en la variable N
    mov al, bl
    mov cl, 8
    mul cl
    mov word [N], ax

    ; Desplegar el valor de la variable N
    mov word ax, [N]
    call pHex_w

    call SDL

    ; INCISO d
    ; Incrementar en 1 el valor de la variable N
    inc word [N]

    ; Se despliega ese valor
    mov word ax, [N]
    call pHex_w

    call SDL

    ; INCISO e
    ; Dividir el valor almacenado en BX entre 0xFF
    mov ax, bx
    mov cx, 0xFF
    div cx

    ; Se despliegan residuo y cociente
    call pHex_b
    mov al, dl
    call pHex_b

    call SDL

    ; INCISO f
    ; Se suma N con el residuo de la división anterior
    add [N], dx

    ; Se decrementa N
    dec word[N]

    ; Se despliega el valor de N
    mov ax, [N]
    call pHex_w

    call SDL

    ; Desplegar el registro de banderas
    pushf
    popf
    call pHex_w
    ; FIN DEL INCISO f

    call SDL

    ; INCISO g
    ; Sacar un dato de 16 bits de la pila
    pop ax
    call pHex_w

    ; El registro de banderas tiene un valor de 0x060A
    ; Este valor en binario es 0000 0110 0000 1010
    ; Las banderas activas son las banderas de dirección y de interrupción

    call SDL

    ; Salida del programa
    mov eax, 1          ; syscall: exit
    int 0x80            ; llamada al sistema

SDL:
    mov al, 10
    call putchar
    ret