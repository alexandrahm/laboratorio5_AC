org 100h

    section .text
    xor AX, AX
    xor SI, SI
    xor BX, BX
    XOR CX, CX
    xor DX, DX

    MOV SI, 0
    MOV DI, 0d

    MOV DH, 10 ;primera fila donde esta el cursor
    MOV DL, 20 ;primera columna donde esta el cursor

    call modotexto

;Iteracion principal
    ITERAR:
        call movercursor ;mover cursor
        MOV CL, [cadena+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Escribir caracter
        INC SI ; SE SUMA 1 A SI 
        INC DL ; SE SUMA 1 A DL
        INC DI ; contador para terminar la ejecución del programa en 10

        CMP DI, 34d ; Comparación de DI con 10d
        JB ITERAR ; si DI < 10 = que siga iterando

        jmp esperartecla ; else: que salte a esperar tecla

    modotexto: 
        ;Modotexto (parametro1)
        ;parametro1= AL (modo gráfico deseado)
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ;modo gráfico deseado
        INT 10h
        RET
    movercursor:
        ;MoverCursor(parametro1, parametro2, parametro3,...)
        ;Donde: Parametro1 = DH (fila del cursor), parametro2 = DL (columna del cursor), parametro 3 = BH (número de página)
        MOV AH, 02h ; posiciona el cursor en pantalla.
        MOV BH, 0h

        ;comparacion para  primer nombre
        CMP DI, 10d
        JE incrementardh

        ;comparacion para segundo nombre
        CMP DI, 18d
        JE incrementardh

        ;comparacion para  primer apellido
        CMP DI, 18d
        JE incrementardh

        ;comparacion para segundo apellido
        CMP DI, 25d
        JE incrementardh

        INT 10h
        RET
    escribircaracter:
        ;EscribirCaracter(parametro1, parametro2, parametro3,...)
        ;Donde: parametro1 = AL (caracter), parametro2 = BH (número de página), parametro3 = BL (estilo del texto en 8 bits)...
        MOV AH, 0Ah ; escribe caracter en pantalla según donde este el cursor
        MOV AL, CL ; denotamos el caracter a escribir en pantalla
        MOV BH, 0h ; número de página
        MOV CX, 1h ; número de veces a escribir el caracter
        INT 10h
        RET

    incrementardh:
        INC DH
        INC DH
        MOV DL, 19
        RET

    esperartecla:
    ;Se espera que el usuario presione una tecla
        MOV AH, 00h 
        INT 16h
    exit:
        int 20h



    section .data

    cadena DB 'Alexandra Maria Henriquez Miranda'