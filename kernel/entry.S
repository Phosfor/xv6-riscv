        # qemu -kernel loads the kernel at 0x80000000
        # and causes each hart (i.e. CPU) to jump there.
        # kernel.ld causes the following code to
        # be placed at 0x80000000.
.section .text
.global _entry
_entry:
        # set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + (hartid * 4096)
        la sp, stack0
        # li a0, 1024*4
        # csrr a1, mhartid
        # addi a1, a1, 1
        # mul a0, a0, a1
        # add sp, sp, a0

        # tp should contain the hartid.
        # While we only support a single hart for now
        # we can already write it from a0
        # where OpenSBI passes it to us 
        mv tp, a0
        # li tp, 0
        # jump to start() in start.c
        # call main
        call start
spin:
        j spin
