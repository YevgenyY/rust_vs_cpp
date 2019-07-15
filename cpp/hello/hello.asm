
hello:     file format elf64-x86-64


Disassembly of section .init:

00000000004006a0 <_init>:
  4006a0:	48 83 ec 08          	sub    $0x8,%rsp
  4006a4:	48 8b 05 4d 09 20 00 	mov    0x20094d(%rip),%rax        # 600ff8 <_DYNAMIC+0x1e0>
  4006ab:	48 85 c0             	test   %rax,%rax
  4006ae:	74 05                	je     4006b5 <_init+0x15>
  4006b0:	e8 8b 00 00 00       	callq  400740 <_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@plt+0x10>
  4006b5:	48 83 c4 08          	add    $0x8,%rsp
  4006b9:	c3                   	retq   

Disassembly of section .plt:

00000000004006c0 <_ZNSt8ios_base4InitC1Ev@plt-0x10>:
  4006c0:	ff 35 42 09 20 00    	pushq  0x200942(%rip)        # 601008 <_GLOBAL_OFFSET_TABLE_+0x8>
  4006c6:	ff 25 44 09 20 00    	jmpq   *0x200944(%rip)        # 601010 <_GLOBAL_OFFSET_TABLE_+0x10>
  4006cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004006d0 <_ZNSt8ios_base4InitC1Ev@plt>:
  4006d0:	ff 25 42 09 20 00    	jmpq   *0x200942(%rip)        # 601018 <_GLOBAL_OFFSET_TABLE_+0x18>
  4006d6:	68 00 00 00 00       	pushq  $0x0
  4006db:	e9 e0 ff ff ff       	jmpq   4006c0 <_init+0x20>

00000000004006e0 <__libc_start_main@plt>:
  4006e0:	ff 25 3a 09 20 00    	jmpq   *0x20093a(%rip)        # 601020 <_GLOBAL_OFFSET_TABLE_+0x20>
  4006e6:	68 01 00 00 00       	pushq  $0x1
  4006eb:	e9 d0 ff ff ff       	jmpq   4006c0 <_init+0x20>

00000000004006f0 <__cxa_atexit@plt>:
  4006f0:	ff 25 32 09 20 00    	jmpq   *0x200932(%rip)        # 601028 <_GLOBAL_OFFSET_TABLE_+0x28>
  4006f6:	68 02 00 00 00       	pushq  $0x2
  4006fb:	e9 c0 ff ff ff       	jmpq   4006c0 <_init+0x20>

0000000000400700 <_ZNSt8ios_base4InitD1Ev@plt>:
  400700:	ff 25 2a 09 20 00    	jmpq   *0x20092a(%rip)        # 601030 <_GLOBAL_OFFSET_TABLE_+0x30>
  400706:	68 03 00 00 00       	pushq  $0x3
  40070b:	e9 b0 ff ff ff       	jmpq   4006c0 <_init+0x20>

0000000000400710 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@plt>:
  400710:	ff 25 22 09 20 00    	jmpq   *0x200922(%rip)        # 601038 <_GLOBAL_OFFSET_TABLE_+0x38>
  400716:	68 04 00 00 00       	pushq  $0x4
  40071b:	e9 a0 ff ff ff       	jmpq   4006c0 <_init+0x20>

0000000000400720 <_ZNSolsEPFRSoS_E@plt>:
  400720:	ff 25 1a 09 20 00    	jmpq   *0x20091a(%rip)        # 601040 <_GLOBAL_OFFSET_TABLE_+0x40>
  400726:	68 05 00 00 00       	pushq  $0x5
  40072b:	e9 90 ff ff ff       	jmpq   4006c0 <_init+0x20>

0000000000400730 <_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@plt>:
  400730:	ff 25 12 09 20 00    	jmpq   *0x200912(%rip)        # 601048 <_GLOBAL_OFFSET_TABLE_+0x48>
  400736:	68 06 00 00 00       	pushq  $0x6
  40073b:	e9 80 ff ff ff       	jmpq   4006c0 <_init+0x20>

Disassembly of section .plt.got:

0000000000400740 <.plt.got>:
  400740:	ff 25 b2 08 20 00    	jmpq   *0x2008b2(%rip)        # 600ff8 <_DYNAMIC+0x1e0>
  400746:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000400750 <_start>:
  400750:	31 ed                	xor    %ebp,%ebp
  400752:	49 89 d1             	mov    %rdx,%r9
  400755:	5e                   	pop    %rsi
  400756:	48 89 e2             	mov    %rsp,%rdx
  400759:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  40075d:	50                   	push   %rax
  40075e:	54                   	push   %rsp
  40075f:	49 c7 c0 40 09 40 00 	mov    $0x400940,%r8
  400766:	48 c7 c1 d0 08 40 00 	mov    $0x4008d0,%rcx
  40076d:	48 c7 c7 46 08 40 00 	mov    $0x400846,%rdi
  400774:	e8 67 ff ff ff       	callq  4006e0 <__libc_start_main@plt>
  400779:	f4                   	hlt    
  40077a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400780 <deregister_tm_clones>:
  400780:	b8 67 10 60 00       	mov    $0x601067,%eax
  400785:	55                   	push   %rbp
  400786:	48 2d 60 10 60 00    	sub    $0x601060,%rax
  40078c:	48 83 f8 0e          	cmp    $0xe,%rax
  400790:	48 89 e5             	mov    %rsp,%rbp
  400793:	76 1b                	jbe    4007b0 <deregister_tm_clones+0x30>
  400795:	b8 00 00 00 00       	mov    $0x0,%eax
  40079a:	48 85 c0             	test   %rax,%rax
  40079d:	74 11                	je     4007b0 <deregister_tm_clones+0x30>
  40079f:	5d                   	pop    %rbp
  4007a0:	bf 60 10 60 00       	mov    $0x601060,%edi
  4007a5:	ff e0                	jmpq   *%rax
  4007a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4007ae:	00 00 
  4007b0:	5d                   	pop    %rbp
  4007b1:	c3                   	retq   
  4007b2:	0f 1f 40 00          	nopl   0x0(%rax)
  4007b6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4007bd:	00 00 00 

00000000004007c0 <register_tm_clones>:
  4007c0:	be 60 10 60 00       	mov    $0x601060,%esi
  4007c5:	55                   	push   %rbp
  4007c6:	48 81 ee 60 10 60 00 	sub    $0x601060,%rsi
  4007cd:	48 c1 fe 03          	sar    $0x3,%rsi
  4007d1:	48 89 e5             	mov    %rsp,%rbp
  4007d4:	48 89 f0             	mov    %rsi,%rax
  4007d7:	48 c1 e8 3f          	shr    $0x3f,%rax
  4007db:	48 01 c6             	add    %rax,%rsi
  4007de:	48 d1 fe             	sar    %rsi
  4007e1:	74 15                	je     4007f8 <register_tm_clones+0x38>
  4007e3:	b8 00 00 00 00       	mov    $0x0,%eax
  4007e8:	48 85 c0             	test   %rax,%rax
  4007eb:	74 0b                	je     4007f8 <register_tm_clones+0x38>
  4007ed:	5d                   	pop    %rbp
  4007ee:	bf 60 10 60 00       	mov    $0x601060,%edi
  4007f3:	ff e0                	jmpq   *%rax
  4007f5:	0f 1f 00             	nopl   (%rax)
  4007f8:	5d                   	pop    %rbp
  4007f9:	c3                   	retq   
  4007fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400800 <__do_global_dtors_aux>:
  400800:	80 3d 69 09 20 00 00 	cmpb   $0x0,0x200969(%rip)        # 601170 <completed.7594>
  400807:	75 11                	jne    40081a <__do_global_dtors_aux+0x1a>
  400809:	55                   	push   %rbp
  40080a:	48 89 e5             	mov    %rsp,%rbp
  40080d:	e8 6e ff ff ff       	callq  400780 <deregister_tm_clones>
  400812:	5d                   	pop    %rbp
  400813:	c6 05 56 09 20 00 01 	movb   $0x1,0x200956(%rip)        # 601170 <completed.7594>
  40081a:	f3 c3                	repz retq 
  40081c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400820 <frame_dummy>:
  400820:	bf 10 0e 60 00       	mov    $0x600e10,%edi
  400825:	48 83 3f 00          	cmpq   $0x0,(%rdi)
  400829:	75 05                	jne    400830 <frame_dummy+0x10>
  40082b:	eb 93                	jmp    4007c0 <register_tm_clones>
  40082d:	0f 1f 00             	nopl   (%rax)
  400830:	b8 00 00 00 00       	mov    $0x0,%eax
  400835:	48 85 c0             	test   %rax,%rax
  400838:	74 f1                	je     40082b <frame_dummy+0xb>
  40083a:	55                   	push   %rbp
  40083b:	48 89 e5             	mov    %rsp,%rbp
  40083e:	ff d0                	callq  *%rax
  400840:	5d                   	pop    %rbp
  400841:	e9 7a ff ff ff       	jmpq   4007c0 <register_tm_clones>

0000000000400846 <main>:
  400846:	55                   	push   %rbp
  400847:	48 89 e5             	mov    %rsp,%rbp
  40084a:	48 83 ec 10          	sub    $0x10,%rsp
  40084e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  400851:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  400855:	be 55 09 40 00       	mov    $0x400955,%esi
  40085a:	bf 60 10 60 00       	mov    $0x601060,%edi
  40085f:	e8 ac fe ff ff       	callq  400710 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@plt>
  400864:	be 30 07 40 00       	mov    $0x400730,%esi
  400869:	48 89 c7             	mov    %rax,%rdi
  40086c:	e8 af fe ff ff       	callq  400720 <_ZNSolsEPFRSoS_E@plt>
  400871:	b8 00 00 00 00       	mov    $0x0,%eax
  400876:	c9                   	leaveq 
  400877:	c3                   	retq   

0000000000400878 <_Z41__static_initialization_and_destruction_0ii>:
  400878:	55                   	push   %rbp
  400879:	48 89 e5             	mov    %rsp,%rbp
  40087c:	48 83 ec 10          	sub    $0x10,%rsp
  400880:	89 7d fc             	mov    %edi,-0x4(%rbp)
  400883:	89 75 f8             	mov    %esi,-0x8(%rbp)
  400886:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
  40088a:	75 27                	jne    4008b3 <_Z41__static_initialization_and_destruction_0ii+0x3b>
  40088c:	81 7d f8 ff ff 00 00 	cmpl   $0xffff,-0x8(%rbp)
  400893:	75 1e                	jne    4008b3 <_Z41__static_initialization_and_destruction_0ii+0x3b>
  400895:	bf 71 11 60 00       	mov    $0x601171,%edi
  40089a:	e8 31 fe ff ff       	callq  4006d0 <_ZNSt8ios_base4InitC1Ev@plt>
  40089f:	ba 58 10 60 00       	mov    $0x601058,%edx
  4008a4:	be 71 11 60 00       	mov    $0x601171,%esi
  4008a9:	bf 00 07 40 00       	mov    $0x400700,%edi
  4008ae:	e8 3d fe ff ff       	callq  4006f0 <__cxa_atexit@plt>
  4008b3:	90                   	nop
  4008b4:	c9                   	leaveq 
  4008b5:	c3                   	retq   

00000000004008b6 <_GLOBAL__sub_I_main>:
  4008b6:	55                   	push   %rbp
  4008b7:	48 89 e5             	mov    %rsp,%rbp
  4008ba:	be ff ff 00 00       	mov    $0xffff,%esi
  4008bf:	bf 01 00 00 00       	mov    $0x1,%edi
  4008c4:	e8 af ff ff ff       	callq  400878 <_Z41__static_initialization_and_destruction_0ii>
  4008c9:	5d                   	pop    %rbp
  4008ca:	c3                   	retq   
  4008cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000004008d0 <__libc_csu_init>:
  4008d0:	41 57                	push   %r15
  4008d2:	41 56                	push   %r14
  4008d4:	41 89 ff             	mov    %edi,%r15d
  4008d7:	41 55                	push   %r13
  4008d9:	41 54                	push   %r12
  4008db:	4c 8d 25 16 05 20 00 	lea    0x200516(%rip),%r12        # 600df8 <__frame_dummy_init_array_entry>
  4008e2:	55                   	push   %rbp
  4008e3:	48 8d 2d 1e 05 20 00 	lea    0x20051e(%rip),%rbp        # 600e08 <__init_array_end>
  4008ea:	53                   	push   %rbx
  4008eb:	49 89 f6             	mov    %rsi,%r14
  4008ee:	49 89 d5             	mov    %rdx,%r13
  4008f1:	4c 29 e5             	sub    %r12,%rbp
  4008f4:	48 83 ec 08          	sub    $0x8,%rsp
  4008f8:	48 c1 fd 03          	sar    $0x3,%rbp
  4008fc:	e8 9f fd ff ff       	callq  4006a0 <_init>
  400901:	48 85 ed             	test   %rbp,%rbp
  400904:	74 20                	je     400926 <__libc_csu_init+0x56>
  400906:	31 db                	xor    %ebx,%ebx
  400908:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40090f:	00 
  400910:	4c 89 ea             	mov    %r13,%rdx
  400913:	4c 89 f6             	mov    %r14,%rsi
  400916:	44 89 ff             	mov    %r15d,%edi
  400919:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  40091d:	48 83 c3 01          	add    $0x1,%rbx
  400921:	48 39 eb             	cmp    %rbp,%rbx
  400924:	75 ea                	jne    400910 <__libc_csu_init+0x40>
  400926:	48 83 c4 08          	add    $0x8,%rsp
  40092a:	5b                   	pop    %rbx
  40092b:	5d                   	pop    %rbp
  40092c:	41 5c                	pop    %r12
  40092e:	41 5d                	pop    %r13
  400930:	41 5e                	pop    %r14
  400932:	41 5f                	pop    %r15
  400934:	c3                   	retq   
  400935:	90                   	nop
  400936:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40093d:	00 00 00 

0000000000400940 <__libc_csu_fini>:
  400940:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000400944 <_fini>:
  400944:	48 83 ec 08          	sub    $0x8,%rsp
  400948:	48 83 c4 08          	add    $0x8,%rsp
  40094c:	c3                   	retq   
