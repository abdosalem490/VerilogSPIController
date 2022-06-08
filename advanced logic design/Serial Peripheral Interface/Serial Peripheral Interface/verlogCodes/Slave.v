module Slave(reset, initialValue, slaveDataToSend, clk, cs, MOSI, MISO );
  
// Inputs & outputs //
  input reset;
  input [7:0] initialValue;
  output reg [7:0] slaveDataToSend;
  input clk;
  input cs;
  input MOSI;
  output reg MISO;

  //resvoir for the data
  reg [7:0] dataRegistered; 
  //temp resovoir for the data to be shifted & sent
  reg [7:0] tempDataRegistered; 
   
  // counter for counting 8 bits transmission till alowing for a new assigning
  reg [3:0]counter;
  assign counter = 8;

  // reg enabled to handle the problem of not assigning any data while transferring
  reg enable_for_storing;
  assign enable_for_storing = 1;

  wire CPHA=1;
  wire CPOL =0;

  // for reassigning temp resovoir to data be shifted & sent again
  always@(cs)
  begin
  counter = 0;
  tempDataRegistered = dataRegistered;
  end
  // for reseting the value stored in the slave
  always @(reset) begin
    if (reset == 1) begin
      if(enable_for_storing == 1)
        begin
        dataRegistered = 0;
        slaveDataToSend = 0;
        tempDataRegistered = 0;
      end
      end
  end
  // for changing the data stored in the slave
  always @(initialValue) begin
    if(enable_for_storing == 1)
    begin
    dataRegistered = initialValue;
    slaveDataToSend = dataRegistered;
    tempDataRegistered = dataRegistered;
    end
  end
  
  
  // At rising edge shift - sent//
  always @(posedge clk)
  begin
  if(cs == 0)
  begin
      enable_for_storing = 0;
      MISO = tempDataRegistered[0];
      tempDataRegistered = tempDataRegistered>>1;
  end
  else 
   MISO = 1'bz;
  end
  
  // At falling adge sampling - recieved //
  always @(negedge clk) begin 
  if(cs == 0)
  begin
    tempDataRegistered[7]=MOSI;
    slaveDataToSend = tempDataRegistered;
    counter = counter + 1;
    if(counter > 7)
     begin
     enable_for_storing = 1;
     counter = 0;
     end
    end
  end

endmodule
