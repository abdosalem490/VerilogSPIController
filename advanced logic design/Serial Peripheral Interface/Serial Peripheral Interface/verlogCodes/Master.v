module Master(
clk,
reset,
start,
slaveSelect,
masterDataToSend,
masterDataReceived,
SCLK,
CS,
MOSI,
MISO);

//inputs
input clk; 
input reset; 
input start;
input  MISO;
input [1:0] slaveSelect;
input [7:0] masterDataToSend;

//outputs
output reg [7:0] masterDataReceived;
output reg SCLK;
output reg [0:2]CS; 
output reg MOSI;

//resvoir for data stored int the register
reg [7:0]dateReserved;

// temporary resovoir for shifting and sending
reg [7:0]tempDateReserved;

//enable for meking the first posedge clk to operate not the  negedge clk
reg enable;

// counter for 8 bits transmission
reg [3:0]counter;
assign counter = 8;

// reg enabled to handle the problem of not assigning any data while transferring
reg enable_for_storing;
assign enable_for_storing = 1;

//reset the stored to 0
always@(reset)
begin
 if(reset == 1)
 begin
  if(enable_for_storing == 1)
  begin
   dateReserved = 0;
   masterDataReceived = dateReserved ;
   tempDateReserved = dateReserved;
  end
 end
end

//assign the selected slave to the master
always@(slaveSelect)
begin
CS = 3'b111;
 case (slaveSelect)
	0: CS = 3'b011;
	1: CS = 3'b101;
	2: CS = 3'b110;
	default:
	  CS = 3'b111;
 endcase
end

//responsible for initializing the stored data
always@(masterDataToSend)
begin
 if(enable_for_storing == 1)
 begin
 dateReserved = masterDataToSend;
 tempDateReserved = dateReserved;
 masterDataReceived = dateReserved;
  if(start == 1)
   begin
   tempDateReserved = dateReserved;
   SCLK = 0;
   enable = 0;
   counter = 0;
   SCLK = 1;
   end
 end
end

// for shifting & sending
always@(posedge clk)
begin
 if(counter < 8)
 begin
  enable_for_storing = 0;
  MOSI = tempDateReserved[0];
  tempDateReserved = tempDateReserved>>1;
  SCLK = 1;
  enable = 1;
 end
end

// for storing the recieved bit
always@(negedge clk)
begin
 if( counter < 8 && enable == 1)
 begin
  tempDateReserved[7] = MISO; 
  masterDataReceived = tempDateReserved ;
  SCLK = 0;
  counter = counter + 1;
 end
 else if(counter > 7)
 begin
  tempDateReserved = dateReserved;
  enable_for_storing = 1;
 end
end

// to start transmitting 8 bits
always@(posedge start)
begin
tempDateReserved = dateReserved;
SCLK = 0;
enable = 0;
counter = 0;
SCLK = 1;

end

endmodule
