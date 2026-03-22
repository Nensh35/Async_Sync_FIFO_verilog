`timescale 1ns/100ps 
`include "sfifo.v"

module tb() ;

    reg clk,R_EN,WR_EN,reset ; 
    reg [11:0] data_in;

    wire FULL,EMPTY ;

    fifo f1(
        clk,WR_EN,R_EN,reset,data_in , FULL , EMPTY
    );

    initial begin 
        clk=1'b0; 
        repeat(100)
        #5 clk = ~ clk ;

    end

    initial begin 


        $dumpfile("sfifo.vcd");
        $dumpvars(0,tb) ;

        R_EN = 0; WR_EN = 0 ;
        #6 reset = 1'b1 ; 
        #10 WR_EN = 1'b1 ;
            data_in =12'h101 ; reset = 1'b0 ;
        #10 data_in =12'h208 ;
        #10 data_in =12'h303 ;
        #10 data_in =12'h404 ;
        #10 data_in =12'h505 ;
        #10 data_in =12'h606 ;
        #10 data_in =12'h707 ;
        #10 data_in =12'h808 ;
        #10 WR_EN = 1'b0 ;  R_EN =1'b1 ; 
        #90 R_EN=1'b0 ; // WR_EN = 1'b1 ; data_in =12'h105 ;
    //  #10 data_in =12'h203 ;
    //  #10 data_in =12'h215 ;
    //  #10 WR_EN = 1'b0 ;  R_EN =1'b1 ; 
        #80 reset=1'b1 ;

        #10 $display("value of mem at 1 %d and at 2 %d at 3 %d ", f1.mem[1] , f1.mem[2] , f1.mem[3] ) ;
        $display("value of mem at 4 %d and at 5 %d at 6 %d ", f1.mem[4] , f1.mem[5] , f1.mem[6] ) ;
        $display("value of mem at 7 %d and fifo jo at 8 %d %d ", f1.mem[7] , f1.ff[0] , f1.mem[1] ) ;
        #60 $finish ;
    
    end
endmodule
