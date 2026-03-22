module fifo(
    input clk,WR_EN,R_EN,reset,
    input [11:0]data_in,
    output reg FULL,EMPTY
);

reg [11:0] ff [7:0];
reg [7:0] mem [15:0];


reg [2:0] R_PTR,WR_PTR ;

always @(negedge clk) begin

    if(reset) begin
        WR_PTR <=3'b0 ; R_PTR <= 3'b0 ; FULL <= 1'b0 ; EMPTY  <= 1'b1 ; 
        end
    
    else begin

      // EMPTY = (WR_PTR == R_PTR);
      // FULL  = ((WR_PTR + 3'b001) == R_PTR);


        /// Wr in to the FIFO 
        // when the WR_EN and !FULL is there you can put data_in ;

        if( !FULL & WR_EN ) begin

            ff[WR_PTR[2:0]] <= data_in ;
            WR_PTR <= 3'b001 + WR_PTR ; ///  THINK WHY WE ARE NOT USING THE  BLOCKING STATE MENT !!!!
        end

        //read when the : so we will put data to the mem 

        if((R_EN) & (!EMPTY) ) begin
            
            mem[ff[R_PTR][11:8]] <= ff[R_PTR][7:0] ;
            R_PTR <= 3'b001 + R_PTR ;

        end

        //EMPTY LA
      
        if(WR_PTR == R_PTR) begin
            EMPTY <= 1;
            FULL  <= 0;
        end
             
        else if( (WR_PTR + 3'b001== R_PTR)) begin  // now i turn all in the circular only simply ::
            EMPTY <= 0;
            FULL  <= 1;
        end

        else begin
            EMPTY <= 0;
            FULL  <= 0;
        end

        //normal simple case can done like this 



    end

    end

endmodule  

/*  FIFO is working fine    problem is that
    
    1 kali address rai ja vandho like in that test bench if R_PTR is 000 and WR_PTR is at 111 so  7 will only  be write if
    you read ptr agaiya vane so  it's ok almost space optimezet !!

    */