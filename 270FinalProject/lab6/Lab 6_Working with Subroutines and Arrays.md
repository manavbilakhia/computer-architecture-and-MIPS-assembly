# Lab 6: Working with Subroutines and Arrays

# Setup

- Save the copy of the arrsum program that uses a subroutine. Run it to verify that it works (you can look in the "Memory" tab in cpulator to see the contents of the array), and then make the following changes in it:
- the `endarr` label, as discussed in lab, points to the end of the array in data memory. Modify the summing function in array-sum so that the second argument is the array length in words (the number of integers in it). Use that information, rather than the `endarr` address, to determine when to end the loop.
- **Note** Don't use a hard-coded "magic number" for the array size. Instead, in the main program you can calculate the array size after that declaration as: (endarr - array)/4. You should be able to accomplish this by loading the two address labels, performing sub on them, and then right shifting by two (to divide by four). You can then pass that value to the subroutine (in an argument register). The advantage of this method over a hard-coded "magic number" is that your calculated ASIZE will automatically change when you change the number of elements in the array.
- "Improve" the loop design so that the loop test is at the end of the loop, with an initial jump to it before entering the loop (it should still be a while-loop, allowing for a possibly empty array). Why is this better?
- Run the program and print a snapshot of the output window.

# Insertion Sort in Assembly

Make a copy of arrsum, and use the copy as a starting point implement insertion sort in ARM assembly language. The C++ code for insertion sort is a useful starting point. Translate it into assembly-language and test it.

Some notes:

- The isort routine must be a subroutine called from the main program, and the array address and the number of integers in it must be passed in registers.
- You can either use a counter to implement a for-loop or use pointer arithmetic. Both approaches are shown in the C code. The latter is probably simpler to write and test, provided you become comfortable with pointer arithmetic. In either case, you shouldn't need to declare any variables in memory other than the array itself. Everything else should be in a register.
- To implement the compound test in the while-loop, use two branch instructions. Assuming that you put the test at the end of the loop that does the element-copy and decrement of j, the pseudocode would be something like
- initialize your array with hand-picked random values, both positive and negative.
- When your routine works, which you can see by looking at the array after the call to sort it, such that the values are sorted inside data memory:
- Grab a snapshot of your output window before and after the run, and in each case, highlight the portion of the data area that holds the array. Grab a snapshot of the output of the console too.

# Extra Credit:

Implement this recursive implementation of insertion sort. I will have shared the Code

# Hand in:

- a PDF report containing a brief written description of each of your programs, alongside before-and-after screenshots
- your modified array-sum
- your isort.asm
- optionally your recursive insertion sort

