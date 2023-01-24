# Important Things to Note

## Data Types in Verilog
Wires are constant, regs act more like variables.

### Wires Type
Wires are used for connecting different elements. They can be treated as physical wires. 
They can be read or assigned. No values get stored in them. 
They need to be driven by either continuous assign statement or from a port of a module.

### Reg Type
Contrary to their name, regs do not necessarily correspond to physical registers. 
They represent data storage elements in Verilog. 
They retain their value till next value is assigned to them (not through assign statement). 
They can be synthesized to FF, latch or combinatorial circuit. (They might not be synthesizable).

## Symbols in Verilog

### "@*"
The "@*" in the always block tells the Verilog compiler to trigger the always block whenever any input signal changes. This is useful when you have a lot of input signals and it's hard to specify them all in the sensitivity list.

### "=" and "<="
In Verilog, the "=" sign is used for assignment, and the "<=" sign is used for non-blocking assignments. The difference between the two is in the way that the assignments are executed during the simulation.

When you use the "=" sign in the always block, it will execute the assignment immediately, and any subsequent assignments in the same always block will use the new value. This is known as blocking assignment.

When you use the "<=" sign in the always block, it will execute the assignment at the end of the current time step. Any subsequent assignments in the same always block will use the old value. This is known as non-blocking assignment.

So, whether you use "=" or "<=" in the always block depends on the behavior you want to achieve in your design.

If you want the output to update immediately after the input changes, use the "=" sign.
If you want the output to update at the end of the current time step, use the "<=" sign.
It's worth noting that in most cases, you will use non-blocking assignments in the always block, because it's more predictable, and it prevents meta-stability problem.

### "."
In Verilog, the "." symbol is used to specify the name of a port when connecting modules together. It is called "named port connection" and it allows to explicitly specify the name of the port to which a signal is connected.

When a module is instantiated, the order of the ports in the instantiation statement must match the order of the ports in the module definition. However, by using the "." notation, you can make connections between the ports of the instantiated module and the signals in the instantiating module regardless of the order of the ports.

## Questions
Are the inputs to the 32 to 5 encoder 32-bits? (Probably not but just make sure)

## Things to do
Add bullet points in the read me to collborators
Make read me nicer
Data path
