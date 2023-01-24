# Important Things to Note

## Data Types in Verilog
Wires are constant, regs act more like variables.

### Wires in Verilog
Wires are used for connecting different elements. They can be treated as physical wires. 
They can be read or assigned. No values get stored in them. 
They need to be driven by either continuous assign statement or from a port of a module.

### Reg in Verilog
Contrary to their name, regs do not necessarily correspond to physical registers. 
They represent data storage elements in Verilog. 
They retain their value till next value is assigned to them (not through assign statement). 
They can be synthesized to FF, latch or combinatorial circuit. (They might not be synthesizable).

## Questions
Are the inputs to the 32 to 5 encoder 32-bits? (Probably not but just make sure)