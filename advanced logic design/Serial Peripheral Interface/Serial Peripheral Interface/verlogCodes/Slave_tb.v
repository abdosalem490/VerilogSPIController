`include "slave.v"
module slave_tb();
  reg reset, cs, clk, MOSI;  
  // The initial value for the slave register.
  reg [7:0] initValForSlaveData;
  
  // The data value of slave register at any given time. 
  wire [7:0] slaveDataToRecieve;
  
  // This register emulates the master register.
  reg [7:0] virtualMasterData;
  wire MISO;
  
  Slave UUT(.reset(reset), .initialValue(initValForSlaveData), .slaveDataToSend(slaveDataToRecieve) , .clk(clk), .cs(cs), .MOSI(MOSI),.MISO(MISO));
  
  
  localparam period = 10;
  always@(posedge clk)
  begin
   MOSI = virtualMasterData[0];
   virtualMasterData = virtualMasterData >>1;
  end

  always@(negedge clk) 
  begin
  virtualMasterData[7] = MISO;
  end
  
  reg [3:0] failedSendingCounter = 0;
  reg [3:0] failedRecCounter = 0;
  
  initial begin
    
    cs = 0;
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b0001001;
    virtualMasterData = 8'b10000010;
    #(period/16) reset=0;
    
    // Test case 1    
    
    repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b0001001) begin
      $display("Test case 1: Sending is successful.");
    end
    else begin
      $display("Test case 1: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b0001001);
      failedSendingCounter = failedSendingCounter + 1;
      
    end
    
    if (slaveDataToRecieve == 8'b10000010) begin
      $display("Test case 1: Recieving is successful.\n");
    end
    else begin
      $display("Test case 1: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b10000010);
      failedRecCounter = failedRecCounter + 1;
    end
    
    // Test case 2
    
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b00001111;
    virtualMasterData = 8'b11110000;
    #(period/16) reset=0;
    
    
    repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b00001111) begin
      $display("Test case 2: Sending is successful.");
    end
    else begin
      $display("Test case 2: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b00001111);
      failedSendingCounter = failedSendingCounter + 1;
    end
    
    if (slaveDataToRecieve == 8'b11110000) begin
      $display("Test case 2: Recieving is successful.\n");
    end
    else begin
      $display("Test case 2: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b11110000);
      failedRecCounter = failedRecCounter + 1;
    end
    
    // Test case 3
    
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b00110001;
    virtualMasterData = 8'b00011010;
    #(period/16) reset=0;
    
      
    repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b00110001) begin
      $display("Test case 3: Sending is successful.");
    end
    else begin
      $display("Test case 3: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b00110001);
      failedSendingCounter = failedSendingCounter + 1;
    end
    
    if (slaveDataToRecieve == 8'b00011010) begin
      $display("Test case 3: Recieving is successful.\n");
    end
    else begin
      $display("Test case 3: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b00011010);
      failedRecCounter = failedRecCounter + 1;
    end
    
    // Test case 4
    
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b00001110;
    virtualMasterData = 8'b11000001;
    #(period/16) reset=0;
    
      
    repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b00001110) begin
      $display("Test case 4: Sending is successful.");
    end
    else begin
      $display("Test case 4: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b00001110);
      failedSendingCounter = failedSendingCounter + 1;
    end
    
    if (slaveDataToRecieve == 8'b11000001) begin
      $display("Test case 4: Recieving is successful.\n");
    end
    else begin
      $display("Test case 4: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b11000001);
      failedRecCounter = failedRecCounter + 1;
    end
    
    // Test case 5
    
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b00000111;
    virtualMasterData = 8'b00000010;
    #(period/16) reset=0;
    
      
    repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b00000111) begin
      $display("Test case 5: Sending is successful.");
    end
    else begin
      $display("Test case 5: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b00000111);
      failedSendingCounter = failedSendingCounter + 1;
    end
    
    if (slaveDataToRecieve == 8'b00000010) begin
      $display("Test case 5: Recieving is successful.\n");
    end
    else begin
      $display("Test case 5: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b00000010);
      failedRecCounter = failedRecCounter + 1;
    end
    
    
    
    // Test case 6
    
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b00110001;
    virtualMasterData = 8'b00011010;
    #(period/16) reset=0;
    
      
   repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b00110001) begin
      $display("Test case 6: Sending is successful.");
    end
    else begin
      $display("Test case 6: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b00110001);
      failedSendingCounter = failedSendingCounter + 1;
    end
    
    if (slaveDataToRecieve == 8'b00011010) begin
      $display("Test case 6: Recieving is successful.\n");
    end
    else begin
      $display("Test case 6: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b00011010);
      failedRecCounter = failedRecCounter + 1;
    end
    

 //test case 7   
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b11111110 ;
    virtualMasterData = 8'b00011010;
    #(period/16) reset=0;
    
      
   repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b11111110) begin
      $display("Test case 7: Sending is successful.");
    end
    else begin
      $display("Test case 7: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b11111110);
      failedSendingCounter = failedSendingCounter + 1;
    end
    
    if (slaveDataToRecieve == 8'b00011010) begin
      $display("Test case 7: Recieving is successful.\n");
    end
    else begin
      $display("Test case 7: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b00011010);
      failedRecCounter = failedRecCounter + 1;
    end
     
   

//test case 8  
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b01101101 ;
    virtualMasterData = 8'b10010001;
    #(period/16) reset=0;
    
      
   repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b01101101) begin
      $display("Test case 8: Sending is successful.");
    end
    else begin
      $display("Test case 8: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b01101101);
      failedSendingCounter = failedSendingCounter + 1;
    end
    if (slaveDataToRecieve == 8'b10010001) begin
      $display("Test case 8: Recieving is successful.\n");
    end
    else begin
      $display("Test case 8: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b10010001);
      failedRecCounter = failedRecCounter + 1;
    end
     
   
//test case 9 
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b00000001 ;
    virtualMasterData = 8'b11111110;
    #(period/16) reset=0;
    
      
   repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b00000001) begin
      $display("Test case 9: Sending is successful.");
    end
    else begin
      $display("Test case 9: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b00000001);
      failedSendingCounter = failedSendingCounter + 1;
    end
    
    if (slaveDataToRecieve == 8'b11111110) begin
      $display("Test case 9: Recieving is successful.\n");
    end
    else begin
      $display("Test case 9: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b11111110);
      failedRecCounter = failedRecCounter + 1;
    end
     
   
//test case 10
    clk = 0;
    reset = 1;
    #(period/16)
    initValForSlaveData = 8'b01011110;
    virtualMasterData = 8'b01110000;
    #(period/16) reset=0;
    
      
   repeat(8)
    begin
    clk = ~ clk;
    #(period/2) ;
    clk = ~ clk;
    #(period/2);
    end
    
    if (virtualMasterData == 8'b01011110) begin
      $display("Test case 10: Sending is successful.");
    end
    else begin
      $display("Test case 10: Sending failed.\nData sent: %b, Expected to have sent: %b\n", virtualMasterData, 8'b01011110);
      failedSendingCounter = failedSendingCounter + 1;
    end
    
    if (slaveDataToRecieve == 8'b01110000) begin
      $display("Test case 10: Recieving is successful.\n");
    end
    else begin
      $display("Test case 10: Recieving failed.\nRecieved: %b, Expected to recieve: %b\n", slaveDataToRecieve, 8'b01110000);
      failedRecCounter = failedRecCounter + 1;
    end
     
    
    $display("\nNumber of failed sending cases: %d\nNumber of failed recieving cases: %d", failedSendingCounter, failedRecCounter);
    
    
    $finish;
  end

endmodule
