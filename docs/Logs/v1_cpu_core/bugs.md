Day 3 : 15/06/2026
## Bug #1: 
    alu gives carry of 1 (borrow of zero) for SUB(4,5) in commit : faa0e44157416a2e4847ee17b75e9f786ce9fc7f
Cause:
    error in logic for calculation of carry(!borrow)\
Fix:  rewrite logic

## Bug #2:
    Register File showed updates only at changes of read addresses, even when read data of the addresses changed
Cause:
    used (read_addr1, read_addr) in sensitivity, that is why updation lagged
Fix: 
    use * instead, 
Why:    I was threatened by the error   and took a hasty decision!
    -rtl/registerFile.v:13: warning: @* is sensitive to all 32 words in array 'regs'.

## Bug #3:     
### Reported by teacher
    BLT always falls through (never branches). BGE always branches regardless of operands.
Cause:
    used "negative" flag in BJL module, while BLT/BGE output 1 or 0, which should use the "zero" flag
Fix:
    change flag in bjl.v to zero, 
    change ports in cpu.v(optional)
Why: 
    Due to haste and inexperience, test case was missed in waveform, added testbest case
