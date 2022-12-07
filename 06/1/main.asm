bits 32
global main    
extern printf

section	.text
main:	 
    ; open(char *path, int flags, mode_t mode);
    mov eax, 5              ; sys call open
    mov ebx, file_name      ; file name  
    xor ecx, ecx              ; read only
    mov edx, 0777           ; exe by all
    int 0x80
    mov [file_d], eax

    ; read(int fd, void *buf, size_t count);
    mov eax, 3              ; sys call read
    mov ebx, [file_d]       ; file descriptor
    mov ecx, buffer       
    mov edx, buffer_length
    int 0x80

    call get_processed_chars

    push eax
    push result_string
    call printf             ; print result on stdout

exit:
    mov eax, 1              ; exit(0)
    xor ebx, ebx
    int 0x80	
	

get_processed_chars:        ; get_processed_chars(int nchar)
    push ebp 
    mov ebp, esp
    sub esp, 8              ; allocate space for marker array
                            ; [esp] marker
                            ; [esp+4] chars processed
    push ebx                ; save registers
    push ecx
    push edx

    xor eax, eax            ; set current char to 0
    xor ecx, ecx            ; int i = 0

while:                      ; while  marker not found

    xor edx, edx            ; int j = 0
for:

    cmp edx, ecx                	; for j < i ; j++
    jge end_for_char_not_in_marker

    ; f**king segFault here while getting current char from buffer
    mov ebx, [esp+4]                ; get number of current char
    add ebx, buffer
    mov al, [ebx]            ; get current char
    
    cmp al, [esp+ecx]
    je for_set_marker_to_0       ; if equals set marker to 0 and [0] to char
    inc edx
    jmp for

end_for_char_not_in_marker:  ; char not in marker, adding to it
    mov [esp+ecx], al        ; marker[i] = current char
    inc dword [esp]          ; increment chars processed
    cmp ecx, 4               ; if marker is 4 chars long, we found it
    je marker_found
    inc ecx                  ; i++
    jmp while

for_set_marker_to_0:
    xor ecx, ecx                ; int i = 0
    cmp ecx, 4                  ; for k < 4
    je end_for_set_marker_to_0
    mov dword [esp+ecx], 0      ; marker[k] = 0
    inc ecx                     ; k++;
    jmp for_set_marker_to_0
end_for_set_marker_to_0:
    mov ecx, 1              ; i = 1
    mov [esp], al           ; marker[0] = current char
    jmp while


marker_found:
    mov eax, [esp]          ; return chars processed
    pop ebx                 ; restore registers
    pop ecx
    pop edx
    add esp, 8              ; free space from local vars
    mov esp, ebp
    pop ebp
    ret

section	.data
file_name db 'input.txt'
result_string db "N of char processed before first SOP marker: %d", 10, 0
test_string db "The character is %c",10, 0
buffer_length dw 4096

section .bss
file_d resd 1       ; file descriptor
buffer resb 4096    ; 4kb 
