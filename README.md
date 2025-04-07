<img src="https://fonts.freepik.com/api/render?variantId=11811&fontSize=72&text=Tasks+for+VSD+Squadron+FM">
<p><img src="https://fonts.freepik.com/api/render?variantId=11255&fontSize=24&text=This%20repo%20is%20created%20by%20Axat%20Gadhwal%20oF%20Gra"><img src="https://fonts.freepik.com/api/render?variantId=11255&fontSize=24&text=de%207th%20of%20APS%20Varanasi"></p>
<details><summary><img src="https://fonts.freepik.com/api/render?variantId=12086&fontSize=48&text=Task%201%20%3A%20Verilog%20code%20and%20PCF%20File%20Analysis"></summary>

<details><summary><H2>⚠Precautions and Steps before starting</H2></summary>

We need to make sure several things...

 <H3> - @ First refer to Datasheet and make sure that all steps are performed correctly.</H3>
           + Refer to <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Project/commit/364cd6ba9da9dd026fda9a84b65e62c78609b679"> Datasheet</a>

> Make sure that all steps in the datasheet are performed correctly{installation, setup, etc.....}

## Let's begin...😲😲

After starting The Virtual Machine, it should look as follows :-
<br><Img Src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(257).png?raw=true">

### Open the terminal
<Img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(264).png?raw=true">

### Navigate to `VSDSquadron_FM` directory because all projects are located there.
> Later navigating to the `blink_led` directory because all the things required to flash led like Makefile, ASC Code
<Img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(266).png?raw=true">

### Seeing the contents of the blink_led....
<Img Src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(267).png?raw=true">

## Now we have made the base... Learning about these in later documents...

</details>

<details><summary><H2>Navigating files needed to execute the RGB Led Blinking Program</H2></summary>

## Till now we had seen the contents of the "blink_led" directory. Studing in deeper about them now....

> Use `nano` to see the files in a text editor called **nano**. Such as `nano Makefile` to see the Makefile, etc....

## Contents of "blink_led":-

### 1. Makefile
<br>`nano Makefile` to see the Makefile
<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(268).png?raw=true">
<br>Makefile Content
<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(269).png?raw=true">

### 2. Verilog Code{rgb_blink.v}
> `.v` stands for verilog
<p>`nano rgb_blink.v` to see the  Verilog file</p>
<img src="![image](https://github.com/user-attachments/assets/5bd39a72-a6c6-4a13-aef2-31487a2f1aa3)">
 <p>Verilog file content</p>
<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(271).png?raw=true">

### 3. PCF File{VSDSquadronFM.pcf}
> `.pcf` stands for PCF file format such as `.txt`.
<p>`nano VSDSquadronFM.pcf` to see the PCF File</p>
<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(272).png?raw=true">
<br>PCF File Content
<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(273).png?raw=true">

### 4. JSON Code{rgb_blink.json}
> `.json` stands for **json** file format.
<p>JSON File Content</p>
<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(274).png?raw=true">

### 5. ASC Code{rgb_blink.asc}
> `.asc` for **asc** file format.
<p>`nano rgb_blink.asc` to see the ASC File</p>
<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(275).png?raw=true">
> Unable to show the `asc` file's content. See later topics to see that...

### 6. Module Timings{rgb_blink.timings}
> `.timings` for **Module Timings**.
<P>`nano rgb_blink.timings` to see the Module Timings' file.</P>
<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(276).png?raw=true">
<br> Module Timings File Content
<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(277).png?raw=true">

</details>

<details><summary><H2> Step 1 - Understanding the Verilog code</H2></summary>
  


##  We need to understand this verilog code:-
     //----------------------------------------------------------------------------
    //                                                                          --
    //                         Module Declaration                               --
    //                                                                          --
    //----------------------------------------------------------------------------
    module top (
      // outputs
      output wire led_red  , // Red
      output wire led_blue , // Blue
      output wire led_green , // Green
      input wire hw_clk,  // Hardware Oscillator, not the internal oscillator
      output wire testwire
    );
    
      wire        int_osc            ;
      reg  [27:0] frequency_counter_i;
    
      assign testwire = frequency_counter_i[5];
     
      always @(posedge int_osc) begin
        frequency_counter_i <= frequency_counter_i + 1'b1;
      end
    
    
    //----------------------------------------------------------------------------
    //                                                                          --
    //                       Counter                                            --
    //                                                                          --
    //----------------------------------------------------------------------------
    
    //----------------------------------------------------------------------------
    //                                                                          --
    //                       Internal Oscillator                                --
    //                                                                          --
    //----------------------------------------------------------------------------
      SB_HFOSC #(.CLKHF_DIV ("0b10")) u_SB_HFOSC ( .CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
    
    
    //----------------------------------------------------------------------------
    //                                                                          --
    //                       Instantiate RGB primitive                          --
    //                                                                          --
    //----------------------------------------------------------------------------
      SB_RGBA_DRV RGB_DRIVER (
        .RGBLEDEN(1'b1                                            ),
        .RGB0PWM (1'b0), // red
        .RGB1PWM (1'b0), // green
        .RGB2PWM (1'b1), // blue
        .CURREN  (1'b1                                            ),
        .RGB0    (led_red                                       ), //Actual Hardware connection
        .RGB1    (led_green                                       ),
        .RGB2    (led_blue                                        )
      );
      defparam RGB_DRIVER.RGB0_CURRENT = "0b000001";
      defparam RGB_DRIVER.RGB1_CURRENT = "0b000001";
      defparam RGB_DRIVER.RGB2_CURRENT = "0b000001";
    
    endmodule
## Purpose

  ### The purpose of this Verilog code is that it controls the RGB Led based on the Clock Inputs

  
   <details><summary><H3> Explanation of Verilog code </H3></summary>
     
<p>We need to understand this verilog code :-</p>


   
       module top (
      // outputs
      output wire led_red  , // Red
      output wire led_blue , // Blue
      output wire led_green , // Green
      input wire hw_clk,  // Hardware Oscillator, not the internal oscillator
      output wire testwire
     );






## Module Declaration

<p>The line module top ( begins the definition of a module named top. In Verilog, a module is a fundamental building block that encapsulates a design or a part of a design</p>







## Ports

<p>The ports are defined within the parentheses. Ports are the inputs and outputs of the module that allow it to interact with other modules or external signals.</p>

### Output Ports
 
   **output wire led_red:**
  This declares an output port named led_red, which is a wire type. It is intended to control the red component of an RGB LED.

  **output wire led_blue:**
  This declares an output port named led_blue, which controls the blue component of the RGB LED.

 **output wire led_green:**
This declares an output port named led_green, which controls the green component of the RGB LED.



### Input Ports

**input wire hw_clk:**
This declares an input port named hw_clk, which is a wire type. It represents the hardware oscillator clock input. This clock signal is used to synchronize operations within the module.









### Additional Output Port

**output wire testwire**
This declares another output port named testwire. The purpose of this port is typically for testing or debugging purposes, allowing you to output a signal that can be monitored externally.







### Summary

<p>The top module is designed to control an RGB LED with three output ports (for red, blue, and green) and takes a hardware clock input. It also includes an additional output for testing purposes. The actual functionality of how these outputs are driven would be defined in the rest of the module's code, which is not included in this snippet.</p>










</details>


<details><summary><H3>Internal Logic Components Analysis</H3></summary>


<details><summary><H4>Internal Oscillator (SB_HFOSC) instantiation</H4></summary>

#### The internal oscillator in the Verilog code is instantiated using the SB_HFOSC module, which generates a high-frequency clock signal for the design. Here’s a brief overview of its instantiation:

       SB_HFOSC #(.CLKHF_DIV ("0b10")) u_SB_HFOSC (
          .CLKHFPU(1'b1), // Power-up the oscillator
          .CLKHFEN(1'b1), // Enable the oscillator
          .CLKHF(int_osc) // Output clock signal
      );

## Purpose

<p>Generates a high-frequency clock signal (int_osc).</p>





## Parameters

#### CLKHF_DIV ("0b10"): 
Divides the output frequency by 2.








## Connections{Control Signals}

### CLKHFPU
<p>This connection basically powers up the oscillator</p>








### CLKHFEN

<P>This connection basically enables the Oscillator</P>










### CLKHF


<p>Output connected to internal int_osc signal</p>















## Summary

<p>This oscillator provides the clock signal used by the frequency counter and other components in the design.</p>










</details>






<details><summary style="font-size: 34em;"><H4>Frequency Counter Logic</H4></summary>
 
- A 28-bit register (frequency_counter_i) counts clock cycles from the internal oscillator.
* It increments on each rising edge of int_osc.

  <br>The 5th bit of the counter is assigned to testwire, which can be used for testing.

<p><A href="https://en.wikipedia.org/wiki/Frequency_counter#:~:text=Most%20frequency%20counters%20work%20by%20using%20a%20counter%2C,display%2C%20and%20the%20counter%20is%20reset%20to%20zero.">Explained briefly</A></p>

</details>


<details><summary><H4>RGB Led Driver (SB_RGBA_DRV) Overview</H4></summary>

<p>In the provided Verilog code, the RGB LED driver is instantiated using the SB_RGBA_DRV module. This module is specifically designed to control RGB LEDs, allowing for the adjustment of color and brightness through PWM (Pulse Width Modulation) signals.</p>

<details><summary><H5>Key components of the RGB Led Driver</H5></summary>

    
    
### Instantiation

    SB_RGBA_DRV RGB_DRIVER (
            .RGBLEDEN(1'b1), // Enable the RGB LED driver
            .RGB0PWM (1'b0), // Red PWM signal
            .RGB1PWM (1'b0), // Green PWM signal
            .RGB2PWM (1'b1), // Blue PWM signal
            .CURREN  (1'b1), // Enable current for the RGB LED
            .RGB0    (led_red),   // Connect to the red LED output
            .RGB1    (led_green), // Connect to the green LED output
            .RGB2    (led_blue)   // Connect to the blue LED output
        );




## Parameters

### RGBLEDEN

<p>This signal enables the RGB LED driver. It must be set to 1 for the driver to function.</p>



### RGB0PWM, RGB1PWM, RGB2PWM

These signals control the ` PWM ` for the **red**, **green**, and **blue** channels, respectively. A value of 1 means the LED is on, while 0 means it is ` off `.




### Curren
 This signal enables the current for the ` RGB LED `. It must be set to 1 for the LED to receive power.




#### RGB0, RGB1, RGB2

These are the actual output connections to the ` RGB LED ` for the **red, green, and blue** channels.














### Functionality

- The ` RGB LED ` driver takes the **PWM** signals and controls the brightness of each color channel of the RGB LED.
+ By adjusting the **PWM** signals, you can create different colors by mixing the intensities of red, green, and blue light.
* In the provided code, the driver is configured to turn on the blue LED (**RGB2PWM** is set to 1) while keeping the red and green LEDs off (RGB0PWM and RGB1PWM are set to 0).









### Current Settings

    defparam RGB_DRIVER.RGB0_CURRENT = "0b000001"; // Red current
    defparam RGB_DRIVER.RGB1_CURRENT = "0b000001"; // Green current
    defparam RGB_DRIVER.RGB2_CURRENT = "0b000001"; // Blue current

  <p>These parameters set the current levels for each color channel. The values can be adjusted to change the brightness of each LED color.</p>

> Current settings: All LEDs set to "0b000001" (minimum current)



### Output Connections

    RGB0 → led_red
    RGB1 → led_green
    RGB2 → led_blue








</details>














</details>








</details>


<details><summary><H3>Summary of Part 1 </H3></summary>

<details><summary><H4>Purpose</H4></summary>

This Verilog module serves as an RGB LED controller, integrating an internal oscillator and a frequency counter to facilitate precise management of RGB LED outputs. By providing a stable internal clock source, the module ensures reliable timing for LED operations while incorporating a dedicated test signal for external monitoring. This design is particularly well-suited for embedded systems that require consistent LED performance with minimal reliance on external components.








</details>

<details><summary><H4>Internal Logic and Oscillator</summary>

At the heart of the module is a high-frequency oscillator (SB_HFOSC), which acts as the internal timing source. The output from this oscillator drives a 28-bit frequency counter that increments with each clock cycle. This counter not only tracks timing information but also outputs its 5th bit to the ` testwire ` , enabling external observation of the counter's state. This setup allows for effective monitoring and debugging of the module's timing behavior.




</details>

<details><summary><H4>RGB Led Driver Functionality</summary>


The RGB LED driver (SB_RGBA_DRV) is responsible for controlling the LED outputs with the following key features:

### Current-Controlled Outputs

<p>Each color channel is configured with a minimum current setting of "0b000001," ensuring proper brightness levels.</p>


### Pulse Width Modulation

The driver utilizes PWM control for each color channel, allowing for dynamic adjustments in brightness and color mixing.



### Fixed Configuration

- The blue LED is configured to operate at maximum brightness (RGB2PWM = 1'b1), providing a vibrant blue output.
+ The red and green LEDs are set to minimum brightness (RGB0PWM = RGB1PWM = 1'b0), effectively turning them off.

#### This configuration enables the module to deliver precise control over the RGB LED's color output, ensuring stable operation while facilitating easy testing and monitoring capabilities.














</details>


</details>








</details>

<details><summary><H2>Step 2 - Creating the PCF File</H2></summary>

### That's the PCF File

    set_io  led_red	39
    set_io  led_blue 40
    set_io  led_green 41
    set_io  hw_clk 20
    set_io  testwire 17

<details><summary><H3>Overview of the PCF File</H3></summary>

 #### The PCF (Physical Constraints File) is used to define the physical pin assignments for the FPGA design. It specifies which physical pins on the FPGA correspond to the input and output ports defined in the Verilog code.

<details><summary><H4>Purpose</H4></summary>

#### The purpose of the PCF file is to map the logical signals defined in the Verilog module to the physical pins of the FPGA. This mapping is crucial for ensuring that the hardware behaves as intended when the design is implemented on the FPGA.


</details>

<details><summary><H4>Structure of the PCF File</H4></summary>

### The PCF file consists of pin assignments that specify the following:


### Pin Name

<p>The name of the physical pin on the FPGA</p>



### Signal Name

**The corresponding signal from the Verilog code.**





### Direction

Indicates whether the pin is an input or output.



















</details>

<details><summary><H4>Pin Assignments explained</summary>

**Each line in the PCF file corresponds to a specific pin assignment:** 


## set_io led_red 39

This line assigns the `led_red` output from the Verilog module to physical pin 39 on the FPGA. The ability to control the red LED is essential for color mixing in the RGB LED. By adjusting the PWM signal for this pin, the brightness of the red light can be varied, allowing for a wide range of colors when combined with green and blue.




## set_io led_blue 40
This line assigns the `led_blue` output to pin 40. Similar to the red LED, the blue LED's brightness is controlled via PWM. This pin is crucial for producing colors that require blue light, such as purple when mixed with red or cyan when mixed with green.



## set_io led_green 41

This line assigns the `led_green` output to pin 41. The green LED is vital for creating a full spectrum of colors. By varying the PWM signal on this pin, the intensity of the green light can be adjusted, enabling the creation of colors like yellow (when mixed with red) and white (when all colors are combined).


## set_io hw_clk 20
This line assigns the `hw_clk input` to pin 20. Provides the clock signal for synchronization. The clock signal is fundamental for the operation of digital circuits. It ensures that all components of the Verilog module operate in sync, particularly the frequency counter that drives the timing for the RGB LED driver.


## set_io testwire 17


This line assigns the `testwire output` to pin 17. This pin is important for debugging and verifying the functionality of the design. By monitoring the state of the testwire, developers can ensure that the internal oscillator and frequency counter are working correctly, which is critical for the overall performance of the RGB LED controller.








</details>


<details><summary><H4>Conclusion</H4></summary>

**These assignments ensure that the signals from the Verilog code are correctly routed to the appropriate pins on the FPGA for proper operation.**




</details>










</details>






</details>

<details><summary><H2>Step 3 - Integrating with the VSDSquadron FPGA Mini Board</H3></summary>

### Useful Links

- <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/Makefile">Access Makefile Here</a>
+ <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/VSDSquadronFMDatasheet.pdf">Access Datasheet Here</a>
* <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/ASC%20Code">Access ASC Code Here</a>
- <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/JSON%20Code">Access JSON Code Here</a>
+ <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/Module%20Timings">Access Module Timings Here</a>


<details><summary><H3>Steps to follow</H3></summary>

## We need to follow the following steps for flashing the RGB Led:-

<details><summary><H3>1. Review the FPGA Squadron FM <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/VSDSquadronFMDatasheet.pdf"> Datasheet</H3></summary>

#### To Understand its Features and Pinout


</details>

<details><summary><H3>2. Correlate Connections</H3></summary>

#### Use the datasheet to correlate the physical board connections with the PCF file and Verilog code




</details>

<details><summary><H3>3. Connect the Board to the Computer</H3></summary>

 #### Follow the instructions in the datasheet (e.g., using USB-C and ensuring FTDI connection).

> After connecting the board, Type `lsusb` to see if the board is connected or not...
> <img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(278).png?raw=true">
> If you see something like `Future Technology Devices International...` something. You can conclude that the FPGA Board is connected.

### After connecting the board using USB-C, the board should look as follows:-

> Red light make us conclude that the board is connected.

<img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/IMG-20250321-WA0018.jpg?raw=true">



</details>

<details><summary><H3>4. Follow the Makefile for Building and Flashing the Verilog Code:</H3></summary>

1. Run `make clean` to clear any previous builds.
   
2. Run `make build` to compile the Design.
  <img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(279).png?raw=true">
3. Run `sudo make flash` to program the **FPGA** Board.
   <img src="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/Screenshot%20(280).png?raw=true">

</details>

<details><summary><H3>5. Observe the Behaviour of RGB Led</H3></summary>

<p>Confirm successful programming by checking that the RGB LED blinks on the board.</p>

> After Running `make clean`, the board should appear as follows...
> <img src ="https://github.com/Axat-Gadhwal/Images-VSD-Internship/blob/main/IMG-20250321-WA0020.jpg?raw=true">





</details>

<details><summary><H3>Final Expected Behaviour</H3></summary>

 



### After "sudo make flash" the board should look as follows

https://github.com/user-attachments/assets/c7c5b021-d3b8-4a99-b1d9-c037566a84ae
 
 
</details>




</details>





</details>

<details><summary><H2>Step 4 - Final Documentation</H2></summary>

### This is a comprehensive report of all the 3 steps 


<details><summary><H3>Summary of Verilog Code Functionality</summary>

The Verilog code implements an RGB LED controller that utilizes an internal oscillator and a frequency counter to manage the RGB LED outputs. It allows for dynamic control of the LED colors based on clock inputs, enabling various color combinations through PWM (Pulse Width Modulation).






</details>

<details><summary><H3>Pin Mapping Details</H3></summary>

 #### The following pin assignments are defined in the PCF file:

<br>`led_red`--> Pin 39: Controls the red LED component.
<br>`led_blue`--> Pin 40: Controls the blue LED component.
<br>`led_green`--> Pin 41: Controls the green LED component.
<br>`hw_clk`--> Pin 20: Provides the clock signal for synchronization.
<br>`testwire`--> Pin 17: Outputs a test signal for monitoring.


</details>

<details><summary><H3>Integration Steps:</H3></summary>

- Reviewed the FPGA Mini board datasheet for features and pinout.
+ Mapped physical connections to the PCF file and Verilog code.
* Connected the board to the computer via USB-C.
- Followed the Makefile to build and flash the design.
     - Executed `make clean`, `make build`, and `sudo make flash`.
* Observed the RGB LED behavior to confirm successful programming.
- Observed the Final behaviour as :-
https://github.com/user-attachments/assets/c7c5b021-d3b8-4a99-b1d9-c037566a84ae  



</details>

<details><summary><H3>Challenges faced and Solutions Implemented</H3></summary>

### Faced challenges. But there were not many challenges. Main challenges were :

- The Oracle Virtual Box, sometimes frustrated me... I downloaded the `Extension File{ext.}` and when I tried to open Virtual Box. It showed problems, So I just opened the Extension File and luckily, then it worked, Like A **Hack** !!
+ Was very hard to understand things - just googled it and got hints....

**This is neither a Problem nor Solution, I just wanted that please add some projects similar to that of the VSD Squadron MINI like Smart Door, etc using Servo Motor.... Please**






</details>

</details>

</details>

<details><summary><p><Img src="https://fonts.freepik.com/api/render?variantId=12086&fontSize=48&text=Task%202%20%3A%20Implementing%20a%20Uart%20Loopback%20Mecha"><img src="https://fonts.freepik.com/api/render?variantId=12086&fontSize=48&text=nism"></p></summary>


<details><summary><H2>Objective</H2></summary>

The objective of this task is to implement a UART (Universal Asynchronous Receiver-Transmitter) loopback mechanism. This mechanism allows transmitted data to be immediately received back, facilitating the testing of UART functionality. By routing the transmitted data from the TX (Transmit) pin directly to the RX (Receive) pin, we can verify that the UART communication is functioning correctly without the need for external devices.



</details>

<details><summary><H2>Step 1 : Study the Existing Code</summary>

### UART is a widely used hardware communication protocol that enables serial communication between devices. It operates using two primary data lines:

- **TX(Transmit)** - The line used to send data from the device.
+ **RX(Recieve)**  - The line used to receive data into the device.

## Understanding the UART Loopback Mechanism

<p> A UART loopback mechanism is a diagnostic feature that allows the system to test its own communication capabilities. In this mode, any data sent to the TX pin is routed back to the RX pin of the same module. This setup is particularly useful for verifying that both the TX and RX lines are functioning correctly.</p>


## Existing Code:  
<p>The code for the UART loopback mechanism can be found in the repository <a href="https://github.com/thesourcerer8/VSDSquadron_FM/tree/main/uart_loopback">here</a>. This code includes the necessary Verilog modules to implement the UART protocol and the loopback functionality.</p>


<details><summary><H3>Analysis of the Existing code</H3></summary>


 The existing code for the UART loopback mechanism is designed to facilitate serial communication between the FPGA and external devices. It consists of two main components: the top module and the UART transmission module. Below is a detailed analysis of each component.


## 1. Top Module (top.v)

### The top module integrates the UART functionality and controls the RGB LEDs. Key features include:

- Module Declaration:

       module top (
        output wire led_red,   // Red LED output
        output wire led_blue,  // Blue LED output
        output wire led_green, // Green LED output
        output wire uarttx,    // UART Transmission pin
        input wire uartrx,     // UART Reception pin
        input wire hw_clk      // Hardware clock input
       );

     - This section declares the inputs and outputs of the top module. The `uart tx` pin is used for transmitting data, while the uartrx pin is used for receiving data. The RGB LEDs provide visual feedback based on the UART activity.

+ Internal Oscillator

The internal oscillator generates the clock signal for UART operation:

    SB_HFOSC #(.CLKHF_DIV ("0b10")) u_SB_HFOSC ( .CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc

**This oscillator is configured to run at a specific frequency, which is essential for timing the UART communication.**..

* Loopback Logic:

The TX output is connected to the RX input, enabling loopback:

    assign uarttx = uartrx;


- RGB LED Control:

The RGB LED driver provides visual feedback based on the RX data:

     SB_RGBA_DRV RGB_DRIVER (
       .RGBLEDEN(1'b1),
       .RGB0PWM(uartrx),
       .RGB1PWM(uartrx),
       .RGB2PWM(uartrx),
       .CURREN(1'b1),
       .RGB0(led_green),
       .RGB1(led_blue),
       .RGB2(led_red)
     );


## 2. . UART Transmission Module (`uart_tx_8n1.v`)

This module handles the transmission of data over UART using the 8N1 format.

- Module Declaration:

      module uart_tx_8n1 (
          clk,        // input clock
          txbyte,     // outgoing byte
          senddata,   // trigger tx
          txdone,     // outgoing byte sent
          tx          // tx wire
      );

+ State Machine:

The module uses a state machine to manage the transmission process:

     parameter STATE_IDLE=8'd0;
     parameter STATE_STARTTX=8'd1;
     parameter STATE_TXING=8'd2;
     parameter STATE_TXDONE=8'd3;


* Transmission Logic:

The logic for sending data is implemented in an always block that triggers on the clock's rising edge:

     always @ (posedge clk) begin
         // Start sending?
         if (senddata == 1 && state == STATE_IDLE) begin
             state <= STATE_STARTTX;
             buf_tx <= txbyte;
             txdone <= 1'b0;
         end
         // Additional logic for sending bits...
     end




</details>




</details>


<details><summary><H2>Step 2 : Design Documentation</H2></summary>

<details><summary><H3>Block Diagram Illustrating the UART Loopback Architecture.</H3></summary>

## How to create Block Diagram ?🤔🤔

Block Diagrams are specific diagrams used to represent a flow or structure in an easy way..

Hints for creating the block diagram!!😣

- The internal oscillator (SB_HFOSC) implements a high - frequency oscillator.
     - Also generates internal clock signal(int_osc)
     - **Basically this means that the internal clock signal(int_osc) will be a high frequency oscillator.**
+ Also there is a 28 bit frequency counter(frequency_counter_i) which implements on every positive edge of internal oscillator(int_osc)
* The TX and RX {Transmit and Recieve} pins are connected directly with loopback.
* The RGB LED Driver {SB_RGBA_DRV} controls the three ports or channels :- led_red, led_blue, and led_green.
* Control Signals include RGB_LEDEN and Curren.

### With the help of the following hints, our Block Diagram will look as :-


![Screenshot (308)](https://github.com/user-attachments/assets/2af6f60c-cc63-4521-bb95-829e131f537a)
 

 



</details>

<details><summary><H3>Detailed circuit diagram showing connections between the FPGA and any Peripheral Devices used</H3></summary>

In the UART loopback mechanism, peripheral devices play a crucial role in enhancing the functionality of the FPGA. They allow for data input, output, and communication, making the system more versatile. The loopback feature itself is a testing mechanism that can be used to verify the functionality of these peripheral devices by ensuring that data sent from the TX pin is correctly received on the RX pin, allowing for immediate feedback and validation of the communication path.

## Types of Peripheral Devices

1️. Input Devices – Send data to the system
<br>🔹 Examples: Keyboard, Mouse, Microphone, Joystick, Scanner, Camera

2️.  Output Devices – Display or transmit information from the system
<br>🔹 Examples: Monitor, Speaker, Printer, LED Display, Buzzer

3️.  Storage Devices – Store data permanently or temporarily
<br>🔹 Examples: Hard Drive (HDD), Solid State Drive (SSD), USB Flash Drive, SD Card

4️.  Communication Devices – Enable data transfer between systems
<br>🔹 Examples: Wi-Fi Adapter, Ethernet Card, Bluetooth Module, UART Module

## 📌 Key Components & Their Functions

1️. Power Supply (VCC & GND)
+ Provides 3.3V power to the FPGA and peripherals.

- VCC (3.3V) → Supplies power to FPGA and USB-UART Bridge.

* GND (Ground) → Common ground connection for all components.

2️. FPGA Core (ICE40UP5K)
+ The main processing unit.

- Handles UART communication, LED control, and timing generation.

3️. USB-UART Bridge (FTDI FT232H)

+ Connects the FPGA to the PC for serial communication.

- TX (FPGA Pin 14) → RX (USB-UART Bridge)

* RX (FPGA Pin 15) → TX (USB-UART Bridge)

+ Powered by 3.3V & GND.

4️. UART Interface & UART Loopback

+ TX (Transmitter) and RX (Receiver) are connected internally to form a loopback.

- This means any data sent from the PC to the FPGA is immediately echoed back.

* Used for testing UART functionality.

5️. Internal Oscillator (int_osc)

+ Provides a clock signal for the FPGA.

- Connected to FPGA Pin 20.

* Used for timing UART operations.

6️. Frequency Counter (frequency_counter_i)

 + Generates a 9600Hz clock needed for UART baud rate.

- Takes input from int_osc and divides the frequency.

7️. RGB LEDs & RGB LED Driver

+ LEDs provide visual feedback on UART activity.

- Connected to FPGA Pins 39 (Red), 40 (Green), and 41 (Blue).

* LED Driver ensures proper current flow and brightness control.

## Circuit Diagram will look as follows:-
> © Drawn in draw.io

![Screenshot (310)](https://github.com/user-attachments/assets/d1efe0fd-bb97-47ab-8e7b-9046ed294381)



</details>

</details>

<details><summary><H2>Step 3 : Implementation</H2></summary>

<details><summary><H3>Steps to Transmit Code to the FPGA Board</H3></summary>

1. First run the Virtual Machine with the help of <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/VSDSquadronFMDatasheet.pdf"> Datasheet</a>.
2. Now create a folder and name it `uart_loopback_project` in desktop as follows:

![Screenshot (311)](https://github.com/user-attachments/assets/856d53f3-b5af-4feb-8a39-41f93450c98e)

3. Now open the terminal create the following files:-
<br>i.<a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/Task%202%20%20necessary%20files/Makefile">Makefile</a>
<br>ii.<a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/Task%202%20%20necessary%20files/VSDSquadronFM.pcf">PCF File</a>
<br>iii.<a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/Task%202%20%20necessary%20files/top.v"> top module{verilog} file</a>
<br>iv.<a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/Task%202%20%20necessary%20files/uart_trx.v"> uart verilog file</a>

## Steps needed to follow for creating the above files:-

<br>**1**. Open Firefox in your Virtual Machine
<br>**2**. Sign in into the web browser and access the Gmail link of the <a href="https://github.com/thesourcerer8/VSDSquadron_FM/tree/main/uart_loopback">uart_loopback</a>project.
<br>**3**. Now follow the following steps:-
<br>(a). Open the terminal and navigate into the `uart_loopback_project` directory created earlier.

![Screenshot (312)](https://github.com/user-attachments/assets/7006ba8d-47ed-478c-851c-dd0e9f53bfb5)

<br>(b) i. Now type `nano Makefile` so that a new file named **Makefile** gets created in the **Nano** editor.

![Screenshot (313)](https://github.com/user-attachments/assets/f695928a-50e8-4115-8ced-0b6f274cf238)

<br>    ii. Now enter the Makefile content and then press Ctrl+`x` and then Ctrl+`y` and then `Enter` to save and exit.

![Screenshot (325)](https://github.com/user-attachments/assets/0df24cf1-f8a3-4a5c-9609-6b6bf42a387a)

<br>(c) i. Now type `nano top.v` to create the Verilog file.

![Screenshot (314)](https://github.com/user-attachments/assets/a6fc1760-1530-428f-b99f-700b8bc90e12)

<br>    ii. Now enter the Verilog File Content and then save it.

![Screenshot (315)](https://github.com/user-attachments/assets/f7a3189e-6ae3-460f-a975-c5bf29aadc98)

<br>(d) i. Now type `nano uart_trx.v` to create the uart_trx verilog file.

![Screenshot (316)](https://github.com/user-attachments/assets/76ca75e4-4fbb-4f0e-b5ce-ca90d35f11b4)

<br>    ii. Now enter the Verilog File Content and Save it.

![Screenshot (317)](https://github.com/user-attachments/assets/3c1e4f56-f869-4248-9382-968d4d6f063a)

<br>(e) i. Now type `VSDSquadronFM.pcf` to create the PCF File.

![Screenshot (318)](https://github.com/user-attachments/assets/2fa3b2e1-e955-49a0-bf6a-6171707d0d36)

<br>    ii. Now enter the PCF File content and save it.

![Screenshot (326)](https://github.com/user-attachments/assets/19a1b520-d79f-4c1b-a1e1-25343a7371e0)

## Steps to transmit the code

1. Now type `ls -ltr` to see the File Contents.

![Screenshot (319)](https://github.com/user-attachments/assets/ae1ee586-8f9a-40d7-91bf-ede7d2c8333f)

> As we can see that all the files we need are created.

2. Now connect the FPGA Board with the help of <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/blob/main/VSDSquadronFMDatasheet.pdf">Datasheet</a>.
3. Type `lsusb` to ensure that the board is connected.
     - If you see something as " Future Technologies...." ; This means that the FPGA Board is connected successfully and the computer system is recognising it.

![Screenshot (320)](https://github.com/user-attachments/assets/b2b3043e-7bf8-4b30-939e-d4aea3f44157)

4. Now type `make clean` to clear any previous build.

![Screenshot (320)](https://github.com/user-attachments/assets/b2b3043e-7bf8-4b30-939e-d4aea3f44157)

5. Now type `make build` to compile builds.

![Screenshot (321)](https://github.com/user-attachments/assets/b06dcbeb-d17a-4daa-8fcb-d4456e048aeb)

6. Now type `sudo make flash` to flash the FPGA Board.

![Screenshot (322)](https://github.com/user-attachments/assets/50fce659-f2cb-4df8-bbbb-c8db98e1aac9)




</details>




























</details>

<details><summary><H2>Step 4 : Testing and Verification</H2></summary>

## Using Picocom for Testing and Verification

1. Open the Virtual Machine.
2. Now navigate to the `uart_loopback_project` file created earlier.
3. Then type `sudo apt install picocom` to install the picocom.
4. Type `picocom --version` to check the **Picocom**'s version and ensure that if it is downloaded correctly.
5. Connect the FPGA Board.
6. Now type `make terminal`.

![Screenshot (327)](https://github.com/user-attachments/assets/ea495e87-ec2d-4a65-94ef-0d9b16d756f7)

7. Now you can see that whatever you type is recieved back called "loopback".

![Screenshot (328)](https://github.com/user-attachments/assets/a596bf35-7f2e-4b4b-98f2-d90fe0993cba)
 
8. Now press CTRL + `a` +`x` to exit the **Picocom** terminal.

![Screenshot (329)](https://github.com/user-attachments/assets/58890221-f085-4971-a359-714120462f06)





</details>

<details><summary><H2>Step 5 : Documentation</H2></summary>

# Summary of the Report

## Objective

<p>The main goal of this project was to set up and test a Universal Asynchronous Receiver-Transmitter (UART) loopback system using an FPGA board. In this setup, data that is sent out is immediately received back, making it a useful way to check if UART communication is working properly. The project involved learning the theory, designing the system, building the hardware, and testing the UART loopback function on the VSDSquadron FPGA Mini.</p>

<details><summary><H3>Step 1 : Study the existing code</H3></summary>

**Conceptual Framework**: UART is a fundamental serial communication protocol employing distinct TX (Transmit) and RX (Receive) channels for bidirectional data transmission.

**Loopback Mechanism**: The implementation of a loopback entails directly connecting the TX and RX pins, thereby enabling autonomous communication testing.

**Code Analysis**:

- **Top Module (top.v)**: Governs UART operations and LED-based visual feedback.

+ **Internal Oscillator (int_osc)**: Synthesizes high-frequency clock signals essential for timing control.

* **Loopback Logic**: Implements a direct assignment of TX to RX to establish the loopback mechanism.

- **RGB LED Driver**: Facilitates status indication via LED illumination corresponding to received data signals.

+ **UART Transmission Module (uart_tx_8n1.v)**: Employs a finite state machine (FSM) approach to manage UART data transmission.











</details>

<details><summary><H3>Step 2 : Design Documentation</H3></summary>

## Block Diagram illustrating the UART loopback architecture.

![Screenshot (308)](https://github.com/user-attachments/assets/2af6f60c-cc63-4521-bb95-829e131f537a)

## Detailed Circuit Diagram showing connections between the FPGA and any peripheral devices used.

![Screenshot (310)](https://github.com/user-attachments/assets/d1efe0fd-bb97-47ab-8e7b-9046ed294381)








</details>

<details><summary><H3>Step 3: Implementation</H3></summary>

## Development & File Structure:

- **Established essential project files (`Makefile`, `PCF file`, `top.v`, `uart_trx_.v`)**.

+ **Configured a virtualized development environment for FPGA synthesis and deployment.**

## Flashing Procedure:

- `make build` - Invoked to compile the Verilog HDL code.

+ `sudo make flash` - Executed to program the FPGA with the synthesized bitstream.

* `lsusb` - Utilized to confirm hardware detection and interface recognition.








</details>

<details><summary><H3> Step 4 : Testing and Verification</H3></summary>

**UART Communication Analysis via Picocom:**

- Installed and configured **picocom** to establish serial communication with the FPGA.

 + Conducted real-time loopback validation by transmitting characters and observing their reception.

* Addressed potential misconfigurations related to baud rate mismatches and hardware connectivity

**Functional Validation:**

- Confirmed data integrity—ensuring transmitted symbols were identically received via the loopback.

+ Verified visual indications through LED state transitions, corresponding to UART activity.





</details>




</details>

</details>

<details><summary><H1>s</H1></summary>





## Objective

<p>The purpose of this project is to develop and validate a UART transmitter module using an FPGA. This module enables serial communication by sending data from the FPGA to an external device, such as a computer or another microcontroller, through the Universal Asynchronous Receiver-Transmitter (UART) protocol.

This documentation provides a detailed breakdown of the code, hardware setup, implementation process, and testing procedures.

</p>

## Understanding Uart Transmission

UART is a widely used serial communication protocol that enables data exchange between devices. The protocol consists of two main lines:

- Tx(Transmit): Sends data from the transmitting device.
+ Rx(Recieve): Recieves data at the recieving device.

### Data Frame in UART(8N1 Configuration)

- **Each byte of data is transmitted in the 8N1 format, meaning:**
      + Data Bits
* No Parity Bit
* 1 Stop Bit

A typical UART data frame consists of:

1. Start Bit (1 bit, Low)

2. Data Bits (8 bits, Least Significant Bit first)

3. Stop Bit (1 bit, High)

The baud rate (speed of transmission) for this project is 9600 bps.






<details><summary><H2>Step 1 : Study the Existing Code</H2></summary>



## **`top.v` (Top-Level Module)**

This file acts as the main control module, integrating various components of the UART transmitter.

### **Module Declaration**

```verilog
module top (
  output wire led_red,  // Red LED Output
  output wire led_blue, // Blue LED Output
  output wire led_green, // Green LED Output
  output wire uarttx, // UART Transmission Pin
  input wire hw_clk  // FPGA Clock Input
);
```

- **`led_red, led_blue, led_green`** – Indicate the system’s status.
- **`uarttx`** – Transmit pin for sending serial data.
- **`hw_clk`** – Hardware clock input for timing control.

### **Clock Frequency Counter**

```verilog
reg [27:0] frequency_counter_i;
reg clk_9600 = 0;
reg [31:0] cntr_9600 = 32'b0;
parameter period_9600 = 625;
```

- **`frequency_counter_i`** – 28-bit counter for timing operations.
- **`clk_9600`** – Generated clock signal for UART (9600 Hz).
- **`cntr_9600`** – Counter to achieve the correct baud rate.
- **`period_9600`** – Determines when to toggle `clk_9600`.

### **UART Transmission Instantiation**

```verilog
uart_tx_8n1 DanUART (
  .clk(clk_9600),
  .txbyte("D"),
  .senddata(frequency_counter_i[24]),
  .tx(uarttx)
);
```

- **`clk(clk_9600)`** – Supplies the 9600 Hz clock.
- **`txbyte("D")`** – Sends the character `'D'` continuously.
- **`senddata(frequency_counter_i[24])`** – Controls when data is sent.
- **`tx(uarttx)`** – Connects to the UART TX pin.

### **Clock Division for 9600 Baud Rate**

```verilog
always @(posedge int_osc) begin
  frequency_counter_i <= frequency_counter_i + 1'b1;
  cntr_9600 <= cntr_9600 + 1;
  if (cntr_9600 == period_9600) begin
    clk_9600 <= ~clk_9600;
    cntr_9600 <= 32'b0;
  end
end
```

- This logic ensures **clk_9600 toggles** at the correct rate for UART transmission.

---

## **`uart_trx.v` (UART Transmission Logic)**

This module implements the **8N1 UART transmission protocol**.

### **State Machine for Transmission**

```verilog
parameter STATE_IDLE=8'd0;
parameter STATE_STARTTX=8'd1;
parameter STATE_TXING=8'd2;
parameter STATE_TXDONE=8'd3;
```

- Defines **four states** for handling transmission.

### **Transmission Control Logic**

```verilog
always @ (posedge clk) begin
  if (senddata == 1 && state == STATE_IDLE) begin
    state <= STATE_STARTTX;
    buf_tx <= txbyte;
    txdone <= 1'b0;
  end
  else if (state == STATE_IDLE) begin
    txbit <= 1'b1;
    txdone <= 1'b0;
  end
```

- On `senddata` trigger, the system moves to **STATE_STARTTX**.
- It loads the byte to be transmitted (`buf_tx`).

### **Sending Start Bit (Low)**

```verilog
if (state == STATE_STARTTX) begin
  txbit <= 1'b0;
  state <= STATE_TXING;
end
```

- The start bit (`0`) is sent.

### **Transmitting 8 Data Bits**

```verilog
if (state == STATE_TXING && bits_sent < 8'd8) begin
  txbit <= buf_tx[0];
  buf_tx <= buf_tx>>1;
  bits_sent = bits_sent + 1;
end
```

- Bits are shifted **one by one** into `txbit`.

### **Stop Bit and Completion**

```verilog
else if (state == STATE_TXING) begin
  txbit <= 1'b1;
  bits_sent <= 8'b0;
  state <= STATE_TXDONE;
end
if (state == STATE_TXDONE) begin
  txdone <= 1'b1;
  state <= STATE_IDLE;
end
```

- Sends the **stop bit (`1`)**.
- **Returns to IDLE state** after completion.

---


</details>

<details><summary><H2>Step 2 : Design Documentation</H2></summary>

To ensure a clear understanding of the UART transmitter module, we need to create two essential diagrams:

# 1. Block diagram detailing the UART transmitter module.

## 1. Identify the Key Components

Every UART transmitter has these core blocks:

## UART Transmitter Block Components

This table summarizes the key components of the UART transmitter module:

| Section             | Function                                    | Example Variable Names (Verilog) |
|---------------------|---------------------------------------------|----------------------------------|
| **Input Signals**   | Provide data, clock, and trigger           | `txbyte`, `clk (int_osc)`, `senddata` |
| **Data Processing** | Stores data and tracks bit transmission    | `buf_tx`, `bits_sent`, `txbit`  |
| **State Machine Control** | Controls the transmission process   | `state`, `Next State Logic`     |
| **Output Signals**  | Provides serial output and status flag     | `tx`, `txdone`                  |

### How to Use This Table
- **Input Signals:** These initiate the transmission process.
- **Data Processing:** Manages storing and shifting the data bits.
- **State Machine Control:** Handles different states of transmission.
- **Output Signals:** Final transmitted data and status indicator.

<img src="https://github.com/user-attachments/assets/8fd1707c-9554-4d2e-98ab-0f3aeb79b644" Height=500 Weidth=400>






# 2. Develop a circuit diagram illustrating the FPGA's UART TX pin connection to the receiving device:

## 1. Identify Key Components
To ensure a complete circuit diagram, you need the following components:

<br>✅ FPGA Board (e.g., Lattice iCE40, Xilinx, or Intel FPGA)
<br>✅ UART-Compatible Device (e.g., PC, microcontroller, USB-to-UART adapter)
<br>✅ Voltage Level Shifter (if required, e.g., FPGA operates at 3.3V and the receiver at 5V)
<br>✅ Decoupling Capacitors (optional but recommended for signal stability)
<br>✅ Common Ground Connection (ensures proper data transmission)

## Circuit Diagram:-

![image](https://github.com/user-attachments/assets/cd24bc96-226d-4858-ad64-76666d7d7f80)













</details>

<details><summary><H2>Step 3 : Implementation</H2></summary>

Till this we created several files in the VM itself. But now we will transmit the code by cloning the repository, thus those files will be created/added automatically to the VM.

## Steps to clone the repository

1. Open the Virtual Machine.
2. On GitHub, navigate to the main page of the repository.
3. Above the list of files, click  Code.

![image](https://github.com/user-attachments/assets/c6f9de06-8be4-47f9-a451-204a3b0a8ed5)
> Screenshot of the list of files on the landing page of a repository. The "Code" button is highlighted with a dark orange outline.
4. Copy the URL for the repository.
     - To clone the repository using HTTPS, under "HTTPS", click .
     - To clone the repository using an SSH key, including a certificate issued by your organization's SSH certificate authority, click SSH, then click .
     - To clone a repository using GitHub CLI, click GitHub CLI, then click .

![image](https://github.com/user-attachments/assets/56d427e3-1e04-4a91-9e67-2f48c54f39a3)
> Screenshot of the "Code" dropdown menu. To the right of the HTTPS URL for the repository, a copy icon is outlined in dark orange.
4. Open Git Bash.
8. Change the current working directory to the location where you want the cloned directory.
9. Type git clone, and then paste the URL you copied earlier.

     git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY

## Transmitting the code to the FPGA Board

Till now we have cloned the Github repo. This basically means that we doesn't need to create files for transmission.

Access the necessary files in this <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/tree/main/Task%203%20necessary%20files"> folder</a>.

1. Create a folder named **`uart_transmitter_module`**.

![Screenshot (334)](https://github.com/user-attachments/assets/2f4e3c45-ddcb-4bef-bb5b-82ac9359d758)

2. Now recall the cloning step. Ensure that before cloning, you are in the correct file/directory in which you want the file to be installed.
3. Your repo file will be created in that file.

![Screenshot (341)](https://github.com/user-attachments/assets/9e5c07b4-a167-4f55-b138-ae642e13692c)

4. Now open the Terminal and navigate to our `uart_transmitter_module` file create earlier.

![Screenshot (342)](https://github.com/user-attachments/assets/f206b718-64a2-4f65-be0f-db550eb05bea)

5. Now type :-

       cd `VSD-Squadron-FM-Research-Internship` \ This is because that's my cloned repository name which is now a folder
       cd `'Task 3 necessary files` \ Files storing the necessary codes

![Screenshot (344)](https://github.com/user-attachments/assets/bd26c4c3-dd80-49f1-9428-8e6db04dad59)

 6. Now type `ls-ltr` to see the file contents.{For the repo}

![Screenshot (343)](https://github.com/user-attachments/assets/b9fdc3f2-7cbc-4ea5-896a-cf2930495fce)

7. Now type `ls-ltr` to see the file contents.{For the codes' file}

![Screenshot (344)](https://github.com/user-attachments/assets/bd26c4c3-dd80-49f1-9428-8e6db04dad59)

8. Now type `lsusb` to ensure if the FPGA Board is connected or not.

![Screenshot (345)](https://github.com/user-attachments/assets/9e51a852-ddc0-42ae-a023-68f51fc67bbc)

9. `make clean` to clear any previous builds.

![Screenshot (346)](https://github.com/user-attachments/assets/a5d3ac62-a01a-4272-83e2-efe6b3ebd6fe)

9. Now type `make build` to compile builds.

![Screenshot (347)](https://github.com/user-attachments/assets/30209715-c513-4111-83ba-bb8281a0512d)



10. Now type `sudo make flash` to transmit the code.

![Screenshot (348)](https://github.com/user-attachments/assets/02f58861-38c6-4eb6-a2f3-c7faa113f8fb)



## Now we have transmitted the code to the fpga board. 



https://github.com/user-attachments/assets/47720077-bb51-4747-b3ce-786cc8081268







</details>

<details><summary><H2>Step 4 : Testing and Verification</H2></summary>

1. First install putty on your host device.
2. Now run puTTY{after transmitting the code to the FPGA Board.
> Ensure that the Board is disconnected from the Virtual Machine so that the codes remain transmitted.
3. After starting puTTY, a user interface will come. Select he **Serial** and then change the port to **COM3**.

![Screenshot (357)](https://github.com/user-attachments/assets/00d78223-9089-460f-9954-9f0e908e5dce)

## Final Behaviour

https://github.com/user-attachments/assets/9c62f82d-9216-45dd-82f2-3e4ed478d57e






</details>

<details><summary><H2>Step 5 : Summary</H2></summary>

<details><summary><H3>Step 1: Understanding UART Transmission & Analyzing the Code</H3></summary>

## UART Basics

- UART consists of two main lines.
      - **TX(Transmit)**: Sends Data
      - **RX(Recieve)**: Recieves Data
+ 8N1 Data Frame Format:-
     - 1 Start Bit (Low)
     - 8 Data Bits
     - 1 Stop Bit (High)
     - Baud Rate: 9600 bps

 ##  Code Analysis

 - **top.v** (Top-Level Module):
     - Controls the Entire UART Transmission process.
     - Key Variables: `uarttx` (TX Pin), `hw_clk` (Clock), `led_red/blue/green` (Status LED's).
     - Implements clock division to generate a 9600 Hz clock signal for UART.
- **uart_trx.v** (UART Transmission Logic):
     - Implements a FSM(Finite State Machine) with four states:
          1. IDLE: Waits for Transmission Trigger
          2. STARTTX: Sends the start bit (0)
          3. TXING: Sends 8 data bits
          4. TXDONE: Sends the stop bit(1) and returns to IDLE
     - Uses bitwise shifts to transmit the data serially.
    







</details>

<details><summary><H3>Step 2 : Design Documentation</H3></summary>


## Block diagram detailing the UART transmitter module.

<img src="https://github.com/user-attachments/assets/8fd1707c-9554-4d2e-98ab-0f3aeb79b644" Height=500 Weidth=400>

## Develop a circuit diagram illustrating the FPGA's UART TX pin connection to the receiving device:

![image](https://github.com/user-attachments/assets/cd24bc96-226d-4858-ad64-76666d7d7f80)




</details>

<details><summary><H3>Step 3 : Implementation (Code Transmission to FPGA Board)</H3></summary>

- Cloned the repository for codes
+ Codes for transmitting the code to the FPGA Board:
     - `make clean`
     - `make build`
     - `sudo make flash`
 
</details>


<details><summary><H3>Step 4 : Testing and Verification</H3></summary>

### Used Putty for testing and Verification








</details>

</details>



</details>

<details><summary><H1>w</H1></summary>

# Objective

The goal of this project is to implement a UART transmitter that communicates real-time sensor data from an FPGA to an external device. This enables the FPGA to relay information gathered from sensors, facilitating data monitoring and analysis.

# Understading UART Transmission

### UART (Universal Asynchronous Receiver-Transmitter) is a serial communication protocol that allows for asynchronous data transmission between devices. It operates using two primary lines:

- **Tx (Transmit)**: The line used to send data from the transmitter.
+ **Rx (Receive)**: The line used to receive data at the receiving end.
 # Data Frame Structure in UART (8N1 Configuration)
### In the 8N1 configuration, each data byte is structured as follows:

- **Start Bit**: 1 bit (Low) indicating the beginning of transmission.
+ **Data Bits**: 8 bits of actual data, sent least significant bit first.
* **Stop Bit**: 1 bit (High) indicating the end of transmission.

> The standard baud rate for this project is set to 9600 bps.

<details><summary><h2>Step 1: Study the Existing Code</h2></summary>

## **`top.v`(Top Level Module)**

This module integrates the sensor input and the UART transmitter, managing the flow of data from the sensor to the UART output.

### Module Declaration

     module top (
       output wire led_status, // Status LED Output
       output wire uart_tx,    // UART Transmission Pin
       input wire hw_clk,      // FPGA Clock Input
       input wire sensor_input  // Sensor Data Input
     );


- `led_status`: Indicates the operational status of the system.
- `uart_tx`: The pin used for UART transmission.
- `hw_clk`: The clock signal for the FPGA.
- `sensor_input`: The data input from the sensor.

reg [7:0] sensor_data; // Register to hold the sensor data

### Sensor Data Handling

- `sensor_data`: Stores the latest reading from the sensor.

### UART Transmission Instantiation

     uart_tx_8n1 uart_transmitter (
       .clk(clk_9600),
       .txbyte(sensor_data),
       .senddata(trigger_send),
       .tx(uart_tx)
     );



- `txbyte(sensor_data)`: Sends the sensor data through UART.
+ `trigger_send`: A signal that initiates the transmission when the sensor data is ready.

### Clock Division for UART Baud Rate

     always @(posedge hw_clk) begin
       // Logic to generate a 9600 Hz clock for UART transmission
     end

- This section ensures that the clock frequency is suitable for UART communication.

## **`uart_tx_8n1.v`** (UART Transmission Logic)

This module implements the UART transmission protocol, specifically the 8N1 format.

### State Machine Definition

    parameter STATE_IDLE=8'd0;
    parameter STATE_STARTTX=8'd1;
    parameter STATE_TXING=8'd2;
    parameter STATE_TXDONE=8'd3;

- The state machine consists of four states to manage the transmission process.

### Transmission Control Logic

    always @ (posedge clk) begin
      if (senddata == 1 && state == STATE_IDLE) begin
        state <= STATE_STARTTX;
        buf_tx <= txbyte;
        txdone <= 1'b0;
      end
      else if (state == STATE_IDLE) begin
        txbit <= 1'b1; // Idle state is high
        txdone <= 1'b0;
      end
    

 - The system transitions to STATE_STARTTX when data is ready to be sent.

### Sending the Start Bit

    if (state == STATE_STARTTX) begin
      txbit <= 1'b0; // Start bit is low
      state <= STATE_TXING;
    end

- The start bit is transmitted first

### Data Bit Transmission

    if (state == STATE_TXING && bits_sent < 8'd8) begin
      txbit <= buf_tx[0]; // Send the least significant bit
      buf_tx <= buf_tx >> 1; // Shift the buffer
      bits_sent = bits_sent + 1;
    end

- Each Data Bit is sent sequentially

### Stop Bit and State Reset

    else if (state == STATE_TXING) begin
      txbit <= 1'b1; // Stop bit is high
      bits_sent <= 8'b0;
      state <= STATE_TXDONE;
     end
    if (state == STATE_TXDONE) begin
      txdone <= 1'b1; // Transmission complete
      state <= STATE_IDLE; // Return to idle state
    end






</details>


<details><summary><H2>Step 2 : Design Documentation</H2></summary>


![image](https://github.com/user-attachments/assets/cb3894a3-8c65-41ae-b42a-cd2561de83f8)












</details>


<details><summary><H2>Step 3 : Implementation</H2></summary>


1. Create the following <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Research-Internship/tree/main/Task%204%20necessary%20files"> files.</a>
2. Now once again clone the github repository
3. `make clean` to clear any previous builds
4. `make build` to compile builds
5. `sudo make flash` to transmit the code to the FPGA Board

### That's all, the code is transmitted

> Refer to this <a href="https://r.search.yahoo.com/_ylt=AwrPrtC7O_NnhtMJzBLnHgx.;_ylu=Y29sbwMEcG9zAzEEdnRpZAMEc2VjA3Ny/RV=2/RE=1744022587/RO=10/RU=https%3a%2f%2fwww.technipages.com%2fhow-to-clone-a-git-repository-in-linux%2f/RK=2/RS=ChEvN_Y4JzvIr4JaBw1eynoJXHI"> page</a> for more info on cloning git repo.

## Behaviour after transmitting















</details>







</details>






































































