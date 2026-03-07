module instruction_memory2(
    input [31:0] a,
    output [31:0] rd
);
    reg [31:0] instruction_memory[127:0];
    assign rd = instruction_memory[a[8:2]];
    
    integer i;
    
    initial begin
        // 1. Initialize all memory to 0
        for (i = 0; i < 128; i = i + 1)
            instruction_memory[i] = 32'b0;
            
// --- ADDRESS 0: INITIALIZATION ---
        instruction_memory[0] = 32'h00000093; // addi x1, x0, 0    (x1 = 0)
        instruction_memory[1] = 32'h00100113; // addi x2, x0, 1    (x2 = 1)
        
        // --- COUNTER SETUP (Loop 16 times -> Max 1597) ---
        instruction_memory[2] = 32'h01000213; // addi x4, x0, 16   (Counter = 16)

        // --- LOOP START (Index 3) ---
        instruction_memory[3] = 32'h002083B3; // add  x7, x1, x2   (Next Fib)
        instruction_memory[4] = 32'h00010093; // addi x1, x2, 0    (Shift x1)
        instruction_memory[5] = 32'h00038113; // addi x2, x7, 0    (Shift x2)
        instruction_memory[6] = 32'hFFF20213; // addi x4, x4, -1   (Decrement Counter)

        // --- BRANCH LOGIC ---
        // 1. If Counter (x4) == 0, Reset to Start
        // Offset: -28 bytes (Index 7 to Index 0) -> Hex: FE520063 (approx)
        // Let's use JAL for simplicity if BEQ is tricky.
        // Actually, let's just JUMP if x4 != 0.
        
        // If x4 != 0, Jump BACK to Loop (Index 3)
        // Offset -16 bytes.
        // As you saw before, BNE is tricky. Let's stick to the structure that worked:
        
        // If x4 == 0, Skip the backward jump
        instruction_memory[7] = 32'h00020463; // beq x4, x0, reset (Jump to Index 9)

        // Jump BACK to Loop (Index 3)
        instruction_memory[8] = 32'hFEC0006F; // jal x0, loop 

        // --- ADDRESS 9: RESET ---
        // Jump all the way back to 0
        // Offset: -36 bytes (Index 9 -> 0)
        instruction_memory[9] = 32'hFDDFF06F; // jal x0, start
/*// --- INITIALIZATION ---
        instruction_memory[0] = 32'h00000093; // addi x1, x0, 0    (x1 = 0)
        instruction_memory[1] = 32'h00100113; // addi x2, x0, 1    (x2 = 1)
        
        // --- COUNTER SETUP (Loop 16 times) ---
        // 16 decimal = 0x10 Hex
        instruction_memory[2] = 32'h01000213; // addi x4, x0, 16   (x4 = 16)

        // --- LOOP START (Index 3) ---
        instruction_memory[3] = 32'h002083B3; // add  x7, x1, x2   (x7 = Next Fib)
        instruction_memory[4] = 32'h00010093; // addi x1, x2, 0    (Shift x1)
        instruction_memory[5] = 32'h00038113; // addi x2, x7, 0    (Shift x2)
        instruction_memory[6] = 32'hFFF20213; // addi x4, x4, -1   (Decrement Counter)

        // --- BRANCH LOGIC ---
        // 1. If x4 == 0 (Counter empty), Jump to DONE
        instruction_memory[7] = 32'h00020463; // beq x4, x0, done  (Offset +8)

        // 2. Jump back to LOOP (Index 3)
        // Offset -20 bytes (Hex: FEC0006F)
        instruction_memory[8] = 32'hFEC0006F; // jal x0, loop

        // --- DONE (Infinite Loop) ---
        instruction_memory[9] = 32'h00000063; // beq x0, x0, done*/
      /*      // --- CHANGE IS HERE ---
        // 12 Decimal = C Hex
        instruction_memory[0]  = 32'h00C00393; // addi x7,  x0, 12  <-- Input 12
        
        instruction_memory[1]  = 32'h00038413; // addi x8,  x7, 0   (Copy to counter)
        instruction_memory[2]  = 32'h00100393; // addi x7,  x0, 1   (Set Accumulator to 1)

        // --- Outer Loop Check ---
        instruction_memory[3]  = 32'h02040463; // beq  x8,  x0, done

        instruction_memory[4]  = 32'h00000493; // addi x9,  x0, 0   (Reset temp sum)
        instruction_memory[5]  = 32'h00040513; // addi x10, x8, 0   (Inner counter)

        // --- Inner Loop (Multiply) ---
        instruction_memory[6]  = 32'h00050863; // beq  x10, x0, mul_done
        instruction_memory[7]  = 32'h007484B3; // add  x9,  x9,  x7
        instruction_memory[8]  = 32'hFFF50513; // addi x10, x10, -1
        instruction_memory[9]  = 32'hFF5FF06F; // jal  x0, inner

        // --- Multiply Done ---
        instruction_memory[10] = 32'h00048393; // addi x7,  x9, 0
        instruction_memory[11] = 32'hFFF40413; // addi x8,  x8, -1
        instruction_memory[12] = 32'hFDDFF06F; // jal  x0, outer

        // --- PROGRAM DONE (Infinite Loop) ---
        // This stops the processor so you can see the result
        instruction_memory[13] = 32'h00000063; // beq x0, x0, 0*/

     /*   // --- Initialization ---
        instruction_memory[0]  = 32'h00500393; // addi x7,  x0, 5   (Load 5 into Input Reg)
        instruction_memory[1]  = 32'h00038413; // addi x8,  x7, 0   (Copy 5 to Counter)
        instruction_memory[2]  = 32'h00100393; // addi x7,  x0, 1   (Set Accumulator to 1)

        // --- Outer Loop Start (Label: outer) ---
        // TARGET FOR JUMP: You must jump HERE, not to instruction 1
        instruction_memory[3]  = 32'h02040463; // beq  x8,  x0, done

        instruction_memory[4]  = 32'h00000493; // addi x9,  x0, 0   (Reset temp sum)
        instruction_memory[5]  = 32'h00040513; // addi x10, x8, 0   (Inner counter = Outer counter)

        // --- Inner Loop (Label: inner) ---
        instruction_memory[6]  = 32'h00050863; // beq  x10, x0, mul_done
        instruction_memory[7]  = 32'h007484B3; // add  x9,  x9,  x7 (Accumulate)
        instruction_memory[8]  = 32'hFFF50513; // addi x10, x10, -1 (Decrement inner)
        instruction_memory[9]  = 32'hFF5FF06F; // jal  x0, inner    (Jump back to instr 6)

        // --- Multiply Done ---
        instruction_memory[10] = 32'h00048393; // addi x7,  x9, 0   (Update Accumulator)
        instruction_memory[11] = 32'hFFF40413; // addi x8,  x8, -1  (Decrement Outer Counter)
        
        // --- FIX IS BELOW ---
        // Old: 32'hFd9FF06F (Jumps to Instr 1 -> BAD)
        // New: Jumps to Instr 3 (Offset -36 bytes instead of -44)
        // Note: You must recalculate this HEX for offset -36 (0xFFFFFFDC)
        instruction_memory[12] = 32'hFDDFF06F; // jal  x0, outer    (Jump back to instr 3)

        instruction_memory[13] = 32'h00000063; // nop*/
    end
endmodule
