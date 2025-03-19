

 # Tasks for VSD Squadron FM
This repo is created by Axat Gadhwal oF Grade 7th of APS Varanasi
<details><summary><H1>Task 1 - Verilog Code and PCF File Analysis</H1></summary>

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
<details><summary><H3>Purpose</H3></summary>

  ### The purpose of this Verilog code is that it controls the RGB Led based on the Clock Inputs

  </details>

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






<details><summary><H4> Module Declaration </H4></summary>

<p>The line module top ( begins the definition of a module named top. In Verilog, a module is a fundamental building block that encapsulates a design or a part of a design</p>





</details>

<details><summary><H4>Ports</H4></summary>

<p>The ports are defined within the parentheses. Ports are the inputs and outputs of the module that allow it to interact with other modules or external signals.</p>

<details><summary><H5>Output Ports</H5></summary>
 
  ### output wire led_red:
  This declares an output port named led_red, which is a wire type. It is intended to control the red component of an RGB LED.

  ### output wire led_blue:
  This declares an output port named led_blue, which controls the blue component of the RGB LED.

### output wire led_green:
This declares an output port named led_green, which controls the green component of the RGB LED.

</details>

<details><summary><H5>Input Port</H5></summary>

### input wire hw_clk:
This declares an input port named hw_clk, which is a wire type. It represents the hardware oscillator clock input. This clock signal is used to synchronize operations within the module.







</details>

<details><summary><H5>Additional Output Port</H5></summary>

### output wire testwire:
This declares another output port named testwire. The purpose of this port is typically for testing or debugging purposes, allowing you to output a signal that can be monitored externally.








</details>

<details><summary><H5>Summary</H5></summary>

<p>The top module is designed to control an RGB LED with three output ports (for red, blue, and green) and takes a hardware clock input. It also includes an additional output for testing purposes. The actual functionality of how these outputs are driven would be defined in the rest of the module's code, which is not included in this snippet.</p>





</details>


</details>



</details>


<details><summary><H3>Internal Logic Components Analysis</H3></summary>


<details><summary><H4>Internal Oscillator (SB_HFOSC) instantiation</H4></summary>

#### The internal oscillator in the Verilog code is instantiated using the SB_HFOSC module, which generates a high-frequency clock signal for the design. Here’s a brief overview of its instantiation:

       SB_HFOSC #(.CLKHF_DIV ("0b10")) u_SB_HFOSC (
          .CLKHFPU(1'b1), // Power-up the oscillator
          .CLKHFEN(1'b1), // Enable the oscillator
          .CLKHF(int_osc) // Output clock signal
      );

<details><summary><H5>Purpose</H5></summary>

<p>Generates a high-frequency clock signal (int_osc).</p>







</details>

<details><summary><H5>Parameters</H5></summary>

#### CLKHF_DIV ("0b10"): 
Divides the output frequency by 2.







</details>

<details><summary><H5>Connections{Control Signals}</H5></summary>

<details><summary><H6>CLKHFPU</H6></summary>

<p>This connection basically powers up the oscillator</p>







</details>

<details><summary><H6>CLKHFEN</H6></summary>

<P>This connection basically enables the Oscillator</P>










</details>

<details><summary><H6>CLKHF</H6></summary>


<p>Output connected to internal int_osc signal</p>








</details>






</details>

<details><summary><H4>Summary</H4></summary>

<p>This oscillator provides the clock signal used by the frequency counter and other components in the design.</p>



</details>









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

    
    
<details><summary><H6>**Instantiation**</H6></summary>

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




</details>

<details><summary><H6> **Parameters** </H6></summary>

<details><summary><H6>RGBLEDEN</summary>

<p>This signal enables the RGB LED driver. It must be set to 1 for the driver to function.</p>



</details>

<details><summary><H6>RGB0PWM, RGB1PWM, RGB2PWM</H6></summary>

These signals control the ` PWM ` for the **red**, **green**, and **blue** channels, respectively. A value of 1 means the LED is on, while 0 means it is ` off `.



</details>

<details><summary><H6> Curren </H6> </summary>

 This signal enables the current for the ` RGB LED `. It must be set to 1 for the LED to receive power.



</details>

<details><summary><H6>RGB0, RGB1, RGB2</H6></summary>

These are the actual output connections to the ` RGB LED ` for the **red, green, and blue** channels.



</details>










</details>

<details><summary><H6>**Functionality**</H6></summary>

- The ` RGB LED ` driver takes the **PWM** signals and controls the brightness of each color channel of the RGB LED.
+ By adjusting the **PWM** signals, you can create different colors by mixing the intensities of red, green, and blue light.
* In the provided code, the driver is configured to turn on the blue LED (**RGB2PWM** is set to 1) while keeping the red and green LEDs off (RGB0PWM and RGB1PWM are set to 0).








</details>

<details><summary><H6>** Current Settings ** </H6></summary>

    defparam RGB_DRIVER.RGB0_CURRENT = "0b000001"; // Red current
    defparam RGB_DRIVER.RGB1_CURRENT = "0b000001"; // Green current
    defparam RGB_DRIVER.RGB2_CURRENT = "0b000001"; // Blue current

  <p>These parameters set the current levels for each color channel. The values can be adjusted to change the brightness of each LED color.</p>

> Current settings: All LEDs set to "0b000001" (minimum current)


</details>

<details><summary><H6>** Output connections ** </H6></summary>


    RGB0 → led_red
    RGB1 → led_green
    RGB2 → led_blue





</details>



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

<details><summary><H5>Current-Controlled Outputs</H5></summary>

<p>Each color channel is configured with a minimum current setting of "0b000001," ensuring proper brightness levels.</p>


</details>

<details><summary><H5>PulseWidth Modulation(PWM)</H5></summary>

The driver utilizes PWM control for each color channel, allowing for dynamic adjustments in brightness and color mixing.


</details>

<details><summary><H5>Fixed Configuration</H5></summary>

- The blue LED is configured to operate at maximum brightness (RGB2PWM = 1'b1), providing a vibrant blue output.
+ The red and green LEDs are set to minimum brightness (RGB0PWM = RGB1PWM = 1'b0), effectively turning them off.

#### This configuration enables the module to deliver precise control over the RGB LED's color output, ensuring stable operation while facilitating easy testing and monitoring capabilities.







</details>







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



<details><summary><H5>Pin Name</H5></summary>

<p>The name of the physical pin on the FPGA</p>


</details>

<details><summary><H5>Signal Name</H5></summary>

**The corresponding signal from the Verilog code.**





</details>

<details><summary><H5>Direction</H5></summary>

Indicates whether the pin is an input or output.







</details>











</details>

<details><summary><H4>Pin Assignments explained</summary>

**Each line in the PCF file corresponds to a specific pin assignment:** 


<details><summary><H5>set_io led_red 39</H5></summary>


This line assigns the `led_red` output from the Verilog module to physical pin 39 on the FPGA. The ability to control the red LED is essential for color mixing in the RGB LED. By adjusting the PWM signal for this pin, the brightness of the red light can be varied, allowing for a wide range of colors when combined with green and blue.





</details>

<details><summary><H5>set_io led_blue 40</summary>

This line assigns the `led_blue` output to pin 40. Similar to the red LED, the blue LED's brightness is controlled via PWM. This pin is crucial for producing colors that require blue light, such as purple when mixed with red or cyan when mixed with green.



</details>

<details><summary><H5>set_io led_green 41</H5></summary>

This line assigns the `led_green` output to pin 41. The green LED is vital for creating a full spectrum of colors. By varying the PWM signal on this pin, the intensity of the green light can be adjusted, enabling the creation of colors like yellow (when mixed with red) and white (when all colors are combined).


</details>

<details><summary><H5>set_io hw_clk 20</H5></summary>

This line assigns the `hw_clk input` to pin 20. Provides the clock signal for synchronization. The clock signal is fundamental for the operation of digital circuits. It ensures that all components of the Verilog module operate in sync, particularly the frequency counter that drives the timing for the RGB LED driver.


</details>

<details><summary><H5>set_io testwire 17</H5></summary>


This line assigns the `testwire output` to pin 17. This pin is important for debugging and verifying the functionality of the design. By monitoring the state of the testwire, developers can ensure that the internal oscillator and frequency counter are working correctly, which is critical for the overall performance of the RGB LED controller.



</details>






</details>

<details><summary><H4>Conclusion</H4></summary>

**These assignments ensure that the signals from the Verilog code are correctly routed to the appropriate pins on the FPGA for proper operation.**




</details>









</details>








</details>

<details><summary><H2>Step 3 - Integrating with the VSDSquadron FPGA Mini Board</H3></summary>

### Useful Links

- <a href="https://github.com/Axat-Gadhwal/VSD-Squadron-FM-Project/commit/f53f6b8b4bd87fa402332f3ed64dfd91651656b4">Access Makefile Here</a>
+ <a href="




</details>





</details>





