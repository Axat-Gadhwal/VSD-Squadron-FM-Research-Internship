# Tasks for VSD Squadron FM
This repo is created by Axat Gadhwal oF Grade 7th of APS Varanasi
<details><summary>Task 1 - </summary>

<details><summary>Understanding the Verilog code</summary>
  
  ### Access the verilog code :- https://github.com/thesourcerer8/VSDSquadron_FM/blob/main/led_blue/top.v

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
<details><summary>Purpose</summary>

  ### The purpose of this Verilog code is that it controls the RGB Led based on the Clock Inputs

  </details>

   <details><summary> Explanation of Verilog code </summary>
     
<p>We need to understand this verilog code :-</p>


   
       module top (
      // outputs
      output wire led_red  , // Red
      output wire led_blue , // Blue
      output wire led_green , // Green
      input wire hw_clk,  // Hardware Oscillator, not the internal oscillator
      output wire testwire
     );






<details><summary> Module Declaration </summary>

<p>The line module top ( begins the definition of a module named top. In Verilog, a module is a fundamental building block that encapsulates a design or a part of a design</p>





</details>

<details><summary>Ports</summary>

<p>The ports are defined within the parentheses. Ports are the inputs and outputs of the module that allow it to interact with other modules or external signals.</p>

<details><summary>Output Ports</summary>
 
  ### output wire led_red:
  This declares an output port named led_red, which is a wire type. It is intended to control the red component of an RGB LED.

  ### output wire led_blue:
  This declares an output port named led_blue, which controls the blue component of the RGB LED.

### output wire led_green:
This declares an output port named led_green, which controls the green component of the RGB LED.

</details>

<details><summary>Input Port</summary>

### input wire hw_clk:
This declares an input port named hw_clk, which is a wire type. It represents the hardware oscillator clock input. This clock signal is used to synchronize operations within the module.







</details>

<details><summary>Additional Output Port</summary>

### output wire testwire:
This declares another output port named testwire. The purpose of this port is typically for testing or debugging purposes, allowing you to output a signal that can be monitored externally.








</details>

<details><summary> Summary</summary>

<p>The top module is designed to control an RGB LED with three output ports (for red, blue, and green) and takes a hardware clock input. It also includes an additional output for testing purposes. The actual functionality of how these outputs are driven would be defined in the rest of the module's code, which is not included in this snippet.</p>





</details>


</details>



</details>


<details><summary>Internal Logic Components Analysis</summary>


<details><summary>Internal Oscillator (SB_HFOSC) instantiation</summary>

       SB_HFOSC #(.CLKHF_DIV ("0b10")) u_SB_HFOSC (
          .CLKHFPU(1'b1), // Power-up the oscillator
          .CLKHFEN(1'b1), // Enable the oscillator
          .CLKHF(int_osc) // Output clock signal
      );



</details>








</details>




</details>


</details>
