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

## Modules in Verilog
In Verilog, a module is a self-contained design unit that describes a digital circuit. A module can have inputs, outputs, and internal logic. To use a module in another design, you create an instance of that module.

An instance of a module is created using the keyword module_name instance_name ( .port_name (signal_name), .port_name (signal_name), ...);

Where:

module_name is the name of the module you want to instantiate
instance_name is a unique name you give to this instance of the module
port_name is the name of a port of the module
signal_name is the name of the signal that connects to that port.
For example, to create an instance of a register module with the name reg1, you would write:

    register reg1(clk, clr, enable, D, Q);

This creates an instance named reg1 of the register module and connects the clk, clr, enable, D, and Q signals to the corresponding ports of the module.

Once you have created an instance of a module, you can treat it as a single block, hiding the internal details of the module from the rest of the design. This allows you to create reusable design components and simplify the overall design.

You can also create multiple instances of the same module, with different input and output signals connected to each instance. This is useful for creating arrays of identical components, such as memory arrays or digital filters.

Also, keep in mind that if the module you are instantiating has parameters you can set them during the instance creation.

    module_name #(parameter_value1, parameter_value2, ...) instance_name (...);

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

### "?"
In Verilog, the ? operator is the ternary operator, also known as the conditional operator. It is used to perform a conditional operation on two expressions, and returns one of the two expressions based on the value of a condition. The syntax for the ternary operator is as follows:

    condition ? expression_1 : expression_2

Here, 'condition' is a Boolean expression that evaluates to either '1' or '0'. If the condition is true (evaluates to '1'), then 'expression_1' is returned. If the condition is false (evaluates to '0'), then 'expression_2' is returned.

In the above example, the line 'sel ? D1 : D2' uses this ternary operator. This line means that if the 'sel' is true, then the output of the multiplexer is 'D1' and if the 'sel' is false, then the output of the multiplexer is 'D2'. This output is then passed to the input of the 'reg_instance'.

It can be used in many ways as an shorthand for if-else statements. It can also be used in expressions, assignments and to select between inputs or arguments of a module.

## Questions
Are the inputs to the 32 to 5 encoder 32-bits? (Probably not but just make sure)

## Things to do
Add bullet points in the read me to collborators
Make read me nicer
Data path
