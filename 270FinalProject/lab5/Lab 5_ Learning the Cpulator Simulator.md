# Lab 5: Learning the Cpulator Simulator

This lab is an introduction to the simulator for the ARM processor. We're using cpulator with ARMv7, which is a recent release, and therefore has a few kinks which we have to work around. Thanks in advance for your patience.

1. Launch a browser, go to [https://cpulator.01xz.net/](https://cpulator.01xz.net/) . Select the ARMv7 architecture and then the ARMv7 generic system and click on go
2. Download the file sum.s, saving it to your Lab 5 directory, and open it up with a text editor.
   - The first thing you will notice is that comments begin with the @ sign or // sign for this simulator. Everything to the right of these on a line is ignored.
   - Next you'll notice that there is a .data section and a .text section. The .data section is how how specify data to load into data memory, and the .text section contains the relevant assembly code.
3. Load sum.s in the simulator by clicking the file tab and selecting open. Once you open the file, hit compile and load or press F5.
4. This automatically opens the Code disassembler. Here, you have your ARM code converted to the most basic version of ARM where all pseudo instructions are dismantled.
5. After you load the file, you can now toggle to the Memory tab at the bottom. Here you will see that your data section is now loaded into memory along with other things. Try to spot the numbers that loaded in the data section in this tab. You may have to switch the display of data from hex to decimal signed/unsigned in the settings at the bottom left.
6. On the left hand sider, you will see all your registers and a way to keep track of all of them and what value they hold.
7. Run the program and record the value that shows as the sum in the memory section.
8. Set breakpoints at every ldr and every add instruction (control-click), and then run the code using the continue button. You can also use the step in and step over button to run the code step by step. Set or remove breakpoints by clicking in the left-most gray column in the disassembly window, next to the instruction where you want the breakpoint. You can also remove all breakpoints using the *Clear* button in the Breakpoints panel. You'll notice that the value of your registers updates each time you hit a break point. Record the value of the registers at a couple of breakpoints by taking a screenshot (Use the screenshot app)
   - don't go crazy on screenshots. I just need to enough to know your register values are changing.
9. Edit a copy of sum.s (call it sum2.s), changing the three integers being summed, and rerun the program. Add breakpoints, run the code again and record the value of the registers before, during, after execution in order to demonstrate that it works. (again don't go crazy with screenshots, just show me it works)
10. Write a ARM assembly-language program (swap.s) that will swap the contents of two elements of an array, given the array and the indices of the elements to be swapped. Run the program and print screen snapshots of the data window before and after. Mark the variable locations whose contents have been exchanged. Some notes:
   - To declare an array, do something like the following:
   - array: .word -123, 548, 923, 431, 560, -348, 961 @a six-element array
      - note: the spaces after the commas are important!
   - For the indices, use two more integer variables declared in the data section with .word.
   - you will need to use the instruction "ldr" to load the address of a labeled variable into a register.  example:
   - ldr r0, =array

Hand In:

- your assembly files (sum2.s and swap.s)
- be sure your name is written on the top of each file!
- annotated screenshots of relevant portions above (enough to show me that registers change
- and your code is doing what you expect.

How I will test your code:

- I will run swap.s on a variety of different array inputs, and confirm correct behavior

