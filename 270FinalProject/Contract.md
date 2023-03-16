ARM Assembly Function Caller/Callee Contract 
("What Happens in Vegas Stays in Vegas")

I _________ do solemnly swear, as a function caller:
- to put arguments into registers `r0` through `r3`
- to look for return values in registers `r0` and `r1`
- to put my return address into register `lr`(`r14`) via the `bl` instruction

I _________ do solemnly swear, as a function callee:
- to look for arguments in registers `r0` through `r3`
- to put my return values in registers `r0` and `r1`
- to return to my caller's return address with `bx lr`
- to leave the state of all preserved registers `r4` through `r11`, as well as `sp`(`r13`) the way I found them.

Signature: _________X 

Date: _________X

