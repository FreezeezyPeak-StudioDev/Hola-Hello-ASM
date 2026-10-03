global main
extern printf
extern fflush
extern system

section .data
    msg db 0x1B, "[92m"
        db "  **************************************", 13, 10
        db "  *      Hola mundo desde GitHub!      *", 13, 10
        db "  *      Hola claud, lo logre :D       *", 13, 10
        db "  **************************************", 13, 10
        db 0x1B, "[0m", 13, 10, 0
    cmdPause db "pause", 0

section .text
main:
    sub rsp, 40
    lea rcx, [rel msg]
    call printf

    xor ecx, ecx
    call fflush

    lea rcx, [rel cmdPause]
    call system

    xor eax, eax
    add rsp, 40
    ret
