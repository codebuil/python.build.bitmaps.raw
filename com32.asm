bits 32
org 101000h
mov eax,21cd4cffh
mov ax,0
mov ds,ax
mov ax,01720h
mov ebx,0b8000h
mov ecx,2000
call fill16
call starmem
mov ecx,32
mov esi,ARRAY1
arrays:
push esi
mov edi,100
call getmems
pop esi
ds
mov [esi],edi
add esi,4
push esi
mov esi,hello
call copy 
mov eax,0
mov al,'A'
add al,cl
mov esi,hello3
ds
mov [esi],eax
call cat
pop esi
dec ecx
cmp ecx,0
jnz arrays
mov ebx,ARRAY1
mov edi,0b8000h
mov ecx,32
arrays2:
mov ah,017h
call copymem 
ds
mov esi,[ebx]
add ebx,4
add edi,80
dec ecx
cmp ecx,0
jnz arrays2
ret
setmem:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
		mov esi,eax
		push ecx		
		mov eax,edx
		mov edx,0
		mov ecx,0
		mov ebx,160
		clc
		mul ebx
		pop ebx
		clc
		add eax,ebx
		add eax,ebx
		inc eax
		mov ebx,eax
		add ebx,0b8000h
		mov eax,esi
		ds
		mov [ebx],al
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ret
fill16:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	fill161:
		ds
		mov [ebx],ax
		inc ebx
		inc ebx
		dec ecx
		jnz fill161	
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ret
copymem:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	copymem1:
	ds
	mov al,[esi]
	ds
	mov [edi],ax
	inc edi
	inc edi
	inc esi
	cmp al,0
	jnz copymem1
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ret
getm:
	push ebx
	mov ebx,getmem
	ds
	mov edi,[ebx]
	pop ebx
ret
setm:
	push ebx
	mov ebx,getmem
	ds
	mov [ebx],edi
	pop ebx
ret

starmem:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	mov edi,endF
	add edi,257
	call setm
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ret
getmems:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	call getm
	pop esi
	push edi
	add edi,esi
	call setm
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ret
copy:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	copy1:
	ds
	mov al,[esi]
	ds
	mov [edi],ax
	inc edi
	inc esi
	cmp al,0
	jnz copy1
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ret
len:
	push eax
	push ebx
	push edx
	push edi
	mov eax,0
	len1:
	ds
	mov al,[esi]
	inc ecx
	inc esi
	cmp al,0
	jnz len1
	dec esi
	pop edi
	pop edx
	pop ebx
	pop eax
ret
cat:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push esi
	mov esi,edi
	call len 
	mov edi,esi
	pop esi
	call copy
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ret

getmem dd 0
ARRAY1 dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hello db "hello world....",0
hello3 dd 0,0,0,0,0
hello2 db "there....",0
endF db 0 

