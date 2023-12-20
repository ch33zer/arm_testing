// SRC: https://smist08.wordpress.com/2021/01/08/apple-m1-assembly-language-hello-world/
// Build:
//   as -o hello_world.o hello_world.s
//   ld -macos_version_min 14.0.0 -o hello_world hello_world.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64
// Assembler program to print "Hello World!"
// to stdout.
//
// X0-X2 - parameters to linux function services
// X16 - linux function number
//
.text
.global _start             // Provide program starting address to linker
.align 4

// Setup the parameters to print hello world
// and then call Linux to do it.

_start: mov X0, #1     // 1 = StdOut
				mov X3, #5
				cmp X3, #6
				beq p
        adrp X1, helloworld@PAGE // string to print
        add X1, X1, helloworld@PAGEOFF
        mov X2, #13     // length of our string
        b cl
        p:
        adrp X1, penis@PAGE // string to print
        add X1, X1, penis@PAGEOFF
        mov X2, #6     // length of our string
        cl:
        mov X16, #4     // MacOS write system call
        svc 0     // Call linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.

        mov     X0, #0      // Use 0 return code
        mov     X16, #1     // Service command code 1 terminates this program
        svc     0           // Call MacOS to terminate the program

.data
helloworld:      .ascii  "Hello World!\n"
penis: .ascii "Penis\n"