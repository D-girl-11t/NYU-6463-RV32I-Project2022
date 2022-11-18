# NYU-6463-RV32I-Project2022
Advance Hardware Design Course 

ANDY DUNG: kd2649       DHANA LAXMI SIRIGIREDDY: ds6992


DECODER: 
My decoder has 1 input for the whole instruction, and it will pick what the ALU and IMMGEN should do base on what instruction it received. It's written in verilog with a 
single always block and a lot of case statement. Other signals will be controlled by the control unit, like the signals controlling the MUXs.

DECODER_testbench:
For the testbench, I just give it 3 instructions and see if it will return the correct ALU_op and imm_sel(for selecting immediate), there are just 3 instructions so I just 
manually check if it's correct.


ALU:
Based on what the decoder outputs, the ALU_op will decide what function the ALU will carryout, many instructions basically does the same thing, like 
JAL,JALR,LB,ADD,ADDI,.......,etc. They all add two inputs together, the differences are in what they are adding, and that is controlled by the IMMGEN and the MUXs, 
ALU just does the adding.

ALU_testbench:
I don't have IMMGEN hooked up right now, so I'll manully input the immediate right now, it first perform a SLL, shift 15 to left by 15, and then change the second input to 
32'hf000000f, so we can test the difference between signed and unsigned, the next command is BLT, 15>-268435441, so zero will return 0, then BLTU, it's unsigned so 
15<4026531855, zero should be 1. Last I tested the ADD(JAL,JALR,LB,LH,LBU,LHU,LW,SB,SH,SW,ADD,ADDI) function, and it turned out correct.


REG:
32 registers from r0 to r31, the inputs are clock, reset, write register, data for writing, and instruction, and output is rs1 and rs2. Wires to break up the instruction for accessing
the individual locations. There's also a signal sent out when the register is updated.

REG_testbench:
The testbench will see me use 2 ADD instructions, the first one 32'b000000000000_00110_00111_000_00010_0110011, rs1 = r6, rs2 = r7, rd = r2, there's nothing so rs1 and rs2 is still 0,
then I make write data to be 32'hffffffff, and because write enable is 1 and the rd of last instruction is r2, we can see 0xffffffff is wirtten into r2, then the second instruction,
32'b000000000000_00010_00100_000_00010_0110011, rs1 = r2, rs2 = r7, rd = r2, because rs1 is r2 we can see the output of rs1 become 0xffffffff, while output of rs2 is still 0.


DMEM:
My data memory is word addressed, so every address that goes in will be shifted to right by 2 to be divided by 4, other than the 4K locations for each word, I also have 2 
extra locations for the N numbers, DMEM also is responsibale for the byte, half word and word length difference, for storing and loading the data_type signal will decide  
what to do. Memory writing is clocked but read is not clocked, and the if statement at the begining is to ensure the address will be above 0x80000000, or for me 0x20000000.

DMEM_testbench:
First I access the special rom for my N number, I set all the memread and memwrite to 1 for convenience purpose, and then set write data to 32'h12345678 and data type to 1,
which is half word, then I try an invalid address, it outputted 0 as expected. I then change it to a valid address, as expected it wrote the halfword 5678 into the 4th 
location(DMEM[3]), then I change data type to 3 which is for LBU, it will store 32 bits to memory but output only 8 bits with 0 extended, which is 00....78.


IMEM:
Instruction memory have to be byte addressed, so I need to split them up to 4 blocks, IMEM0 to IMEM3, 2K is 2048 spread between 4 blocks so each of them have 512 locations, 0 to 511.
I wrote 2 test cases in the module for testing purposes, the final product will use the readmem function, and its just for testing so the second instruction I made it 0xffffffff. And
it does not support any pc count that is not aligned to 4. The if statment ensures the instruction starts at 0x01000000.

IMEM_testbench:
First I test it with a incorrect address with all 0s, and it returns instruction with all 0s. Then I test it with the correct starting address, which it correctly returns the testing
instruction that I put in, which is 32'b0000001000_00001_000_00010_0000011. Then I tested it with the last address 32'h010007fc, it returns the test instruction 0xffffffff. I set the 
instruction fetch to 0 so it will hold the output, then set it to 1 again and set the address to starting address, it returns the first test instruction as expected.


IMMGEN:
Input is the whole instruction and with a imm select signal we can select what type of imm to output, 0 is U type, 1 is J type, 2 is I type, 3 is B type, 4 is S type, this is according
to when they appear on the insturction list.

IMMGEN_testbench:
I tested each type of imm and one out of range to be sure. Each type I put 1 at the location of where the imm gets its bits from, for example for S type the imm is the combination of 
instruction[31:25] and [11:7] so I set them to 1 and the output will be apparent. For something like B type, I set the second bit of the imm to 1 so we can see it being shifting around.
For every type I also tested the sign extending function.


programcounter:
Mainly used to pass on the instruction count, reset the instruction counter, and send out the updated signal. The adding 4 function will be its output connect to another adder.

PC_testbench:
First reset and see the program counter counts at 0x01000000, then enable write and see it counts to 0, and change the count to 0xffffffff, then disable writing, and see it holds the
count but the updated will go to 0.


MUX2/MUX3:
Multiplexer for signal controlling.

MUX2/MUX3_testbench:
A total of 5 signals and 2 selection signals to test their function together.
