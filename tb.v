`include "afifo_cyc.v"
`timescale 1ns/100ps 

module tb();

reg WR_clk,R_clk,WR_EN,R_EN,reset_WR, reset_R ;
reg [11:0] data_in ;

wire FULL_WR , EMPTY_R ;

fifo f1(
    WR_clk , R_clk , reset_WR, reset_R , WR_EN ,R_EN ,data_in , FULL_WR ,  EMPTY_R 
); 


always   #5 WR_clk = ~ WR_clk ;

always #10 R_clk = ~ R_clk ;

initial begin 

    WR_clk = 1'b0 ; R_clk = 1'b0 ;
    $dumpfile("fifo.vcd");
    $dumpvars(0,tb) ;

    #4 reset_R = 1'b1 ; reset_WR = 1'b1 ;
    #50 reset_WR=1'b0 ; reset_R=1'b0 ;
    #10 WR_EN = 1'b1  ; data_in = 12'h101 ;
    #10 data_in = 12'h202 ;
    #10 data_in = 12'h303 ;
    #10 data_in = 12'h402 ;
    #10 data_in = 12'h503 ; R_EN=1'b1 ;
    #10 data_in = 12'h602 ;
    #10 data_in = 12'h703 ;   
    #10 data_in = 12'h808 ;
    #10 WR_EN = 1'b0 ; 
    #30 WR_EN =1'b1 ; 
    #10 data_in = 12'h908 ; 
    #20 WR_EN = 1'b0 ;    
    #10  

    #150 $display("data in mem 1 %d 2 %d 3 %d 8 %d  fifo me 1 %d 7 %d 0 %d  " ,
             f1.mem[8] , f1.mem[2] , f1.mem[3] , f1.mem[9] , f1.ff[2]  ,f1.ff[7] , f1.ff[0]) ;
    #30 $finish ;

    end
endmodule

