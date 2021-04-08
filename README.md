# TRISC-Processor
Digital Logic TRISC (Tiny Reduced Instruction Set Computer) Processor designed in Alter Quartus

## 1 Introduction

### 1.1 Project Overview

For this Term Project I was assigned to design and implement a TRISC processor which is able to perform basic operation such as Load, Store, Add, Increment, Clear, and Jump. The design must be made in Quartus II and must be tested on the DE1 development board. The design will consist of a provided TRISC RAM module, but all other parts must be constructed by myself.

### 1.2 Project Status

I have completed all required sections of the project and my processor design is capable of running all of the required operations. I plan to add some addition operations such as Subtract, XOR, Jump if 0, Jump > 0, and Halt. These additions would complete the design and would only require a little bit of changes to the design to complete.

### 1.3 Report Overview

This report will consist of six primary section witch can be found in the table of contents. The report will include a full System design, Controller design details, Alternative design considerations, and Integration and Test Plan section among the Introduction and conclusion.

## 2 System Design

### 2.1 System-level description and diagrams

To simplify my design, I have utilized five bus lines to wrap around the entire processor to better assist the design, Figure 1. The bus lines consist of the Control bus (C[16.]) illustrated in Black. This bus contains all of the control signals including the Clock and the System Start signal. The next bus is the Address bus (A[3.]) illustrated in Blue. This bus contains the primary working address for the RAM module. The MDI (Memory data In) bus (MDI[7.]) is used to load information into the provided RAM module. The MDO (Memory data Out) but (MDO[7.]) is the output of the RAM module. I added one other bus called the ALU bus (ALU[3.]) to simplify the design and also provide a good path between the ALU out and the ACC input.

This following section will consist of one subsection for each part of the system design. Please refer to Figure 1 as a visual guide for these parts. (Left to Right)

### 2.2 System-level description and diagrams

#### 2.2.1 TRISC-RAM Module

This ram module was provided to hold the program that will be performed and holds all values that are being accessed in memory. Data is stored into a 8 bit section where I later split this up into two 4 bit sections. Figure 2.
The TRISC RAM module needs to have a 2x4 MUX added to the data in lines to allow for the device to be able to change what location of the processor it gets its address from. This could be either the past addressed data out or could be the PC. Figure 2.

#### 2.2.2 PC (Program Counter)

The PC performs a very simple task of being an Up-Counter this is needed to keep track of what word in the RAM module should be accessed. The PC can jump to a new address and continue counting from there. Figure 3.
The PC Counter consists of a 74193 IC (4-bit Up Down Counter) where I have connected the UP line to a Not gate to turn into and active low signal. Figure 3.

#### 2.2.3 ACC (Accumulator)

The ACC allows for us to select what kind of data is being accessed at that time. It is Up-Counter with an added MUX (Multiplexer) to allow for the selection and incrementing of two Inputs going to one output.   Figure 4.
The ACC consists of the same PC counter circuit with the addition of MUX (Multiplexer) so that you can switch the input of the counter between the BUS lines and the ALU. Figure 4.




#### 2.2.4 ALU (Arithmetic Logic Unit)

The ALU is used to perform all math operations such as add, subtract, and XOR. This unit takes in two 4 bit inputs to be used as the operands, and takes in a 2 bit input that is used to determine what operation needs to take place. To stop the output from jumping around when the inputs are still being inputed I have added a buffer to the output of the ALU to only perform the operation when it is requested.
The ALU Consists of 4 main subsections. The Adder-Subtractor, AND, XOR, and selector. The Adder-Subtractor, AND , and XOR work in parallel. All possible answers are calculated simultaneously were the selector then takes the proper answer given the request and outputs that. Figure 5.
The Selector is essentially a 3x4 MUX for the 3 subsection outputs, this takes in the 2 operation bits and determines what section should be outputted. It also will output an OVR (Overflow) and a COUT (Carry out) for the Adder-Subtractor if selected. Figure 6.
The ALU Adder-Subtractor is fully written in two verilog modules, It simulates multiple Full-Adders in parallel to allow for a simple design that is compact and simple. The system is able to subtract by using the complement of the number and adding that together. Figure 7.
The ALU AND section simply runs the AND operand on each input but giving the output to the selector. Figure 8.

The ALU XOR section is exactly like the AND section with the only difference being the operation it performs. Figure 9.

#### 2.2.5 Controller

The Controller translates the OP Code that is stored in the TRISC RAM module as a single binary input that feeds the main control module. In here, it uses a finite state machine to translate that command into a set of instructions that it will send to each of the component over the Control Bus. As the process for designing this section of the Processor is quite complicated, I have dedicated a full section to this part.



### 2.3 Hierarchical Design Structure
The overall design of the TRISC Processor is as seen in Figure 10. This allows for a better image of what connects to what with the large number of busses and small NOT gates.

### 2.4 Operating Procedures.

Once you have input a RAM module with the program you would like to execute, you can control the system on the DE1 with KEY0 (System Start), and KEY1 (Clock). To increment the clock and perform another task in the Controller, you need to only press the Clock button. If you would like to restart the program you can press the System Start button and it will Start from the beginning once again. The TRISC Processor outputs its data to the HEX outputs. HEX 0 is the MDI line. HEX 1 is the MDO bus with the address section of it. HEX 2 is the MDO bus with the OPCode section of it. HEX 3 is the PC Counter Address. The LEDs have been configured as debug lights to signal what control signals are being sent to the subsections.

## 3 Controller Design Details
### 3.1 Functional description and diagram showing I/O
The TRISC Controller is like the instruction manual. This unit allows for it to decode the 4-bit OP Codes that are stored in memory. It then is able to trigger controls signals in the correct order based on what OP Code is input so that the device can perform the correct action.
The Controller brings in its information from the IR (Instruction Register) where it is stored until the next code is needed. The Controller then splits the 4-bit signal into a single on or off bit in the controller. This allows for the controls to easily determine what Operation is needed. The Controls then outputs the correct signals to the Control Bus. Figure 11.

### 3.2 State Diagrams

An easy way to visualize what the Controller is performing is with a State diagram. The State diagram shows you the path that the commands follow. Each movement is triggered by a single clock pulse. Figure 12. State A Is used only to clear the Program Counter as that restarts the Program back at the beginning. States B through E are used to grab the next OP Code so that the device can read it and perform the Code specific tasks. All of the ends states go back to state B where it restart the OP Code Fetch.

### 3.3 Schematic Diagrams and Verilog Code

There are 3 main sections of the controller. The first is the IR (Instruction Register) Figure 11. This holds the current OP Code that is being worked on. This is just a simple 4-bit register that is able to be triggered by the Control Bus (C7). The Register is built on a 74175 IC that is able to store a 4-Bit value. Figure 14.
The second subsystems called the Controller ID where the system Decodes the OP Code into a single Bit output into the true Controller. Figure 15.
The actual controls was fully made using HDL (Hardware Description Language), Specifically Verilog. (The state names in the Verilog code are the same as the state diagram.) Figure 16.

### 3.4 DE1 Pin Assignments

The pins that I have assigned are simply enough to see the control signals that are being sent, as well as to allow for the KEY inputs and the HEX outputs. Figure 17.

## 4 Alternate Design Considerations

### 4.1 Alternatives Considered

During the process of creating the TRISC Processor I encountered many decisions that I needed to make. I ended up having to restart my design due to a file management issue and I think this ended up really helping me out because while I lost images of the original it brought up the better design of placing all of the components in the center of all of the Bus lines so that the design would look much neater and be more function to edit. I also had considered designing the ALU as a set of general circuits rather than Verilog HDL because that was a system that at the time I was more familiar with.

### 4.2 Reasons for Selection of Final Design

I ended up deciding to create my design based on the circular Bus design because in my first iteration of the design, I found things to not look very neat and I really wanted the final design to resemble the Hierarchical Design Structure that I was provided so that the overall design would be easier to troubleshoot. This ended up being a great decision for that step.

I also had to make the decision of making the ALU from Verilog and not a general schematic. This decision was very helpful in the end as the design was very easy to understand and gave me a much better understanding of Verilog.

## 5 Integration and Test Plan

### 5.1 Integration Strategy

This project was split into 2 parts which really helped to easily integrate things in an easy manner. I started by just interacting with the RAM module and the controller to make sure that I was able to communicate with it properly. This step required the PC, but did not require the ACC or ALU. I then added the ACC and the few commands associated with it. Once I finished that step I was able to easily integrate the ALU into the design giving the final design I have today. This way of incremental improvements to the design allowed for me to find errors in the design early on before I got to the finished product better allowing me to find issues in the design.

### 5.2 Test Strategy

For testing the design, I found it easiest to just use the DE1, as I found it difficult to create multiple timing diagrams and I prefer to see the large number of outputs on the HEX displays ratter then as binary outputs in the timing diagrams. I did find the Controller to be easier to design without the DE1 and for that part I did opt into using the timing diagrams to verify the design of the Controller.

## 6 Conclusion

### 6.1 Resolution of design

The first time I started to design the TRISC processor I decided to just go for it and get to the final design and while it did end up working out that was it took a log of troubleshooting and that was very time consuming. When I had to rebuild my design. I took a much better approach at splitting the problem up to better solve the sub problems.

A large number of the issues that I encountered where the order of the binary bitts as in I would flip the MSB and the LSB. This could cause some issues in the future that would not be visible in some of the earlier steps.

### 6.2 Lessons Learned

I think the biggest thing that I learned in this whole process was the use of Verilog. I did not feel confident in that design style and think that after designing the ALU and then the controller in that system it allowed for me to get a very good understanding of how that style can have many advantages over standard schematic methods.

I also found that I was able to largely improve my design process. This allowed for me to successfully design this project and allowed me to better split are large problem into smaller sub problems.
