module fifo (
    input WR_clk , R_clk, reset_WR, reset_R , WR_EN , R_EN ,
    input [11:0] data_in,
    output reg FULL_WR , EMPTY_R 
);


reg  [2:0] R_PTR_bin , WR_PTR_bin ;
wire [2:0] R_PTR_gry , WR_PTR_gry , R_to_WR_PTR_2_bin , WR_to_R_PTR_2_bin;


reg  [2:0] WR_to_R_PTR_1, WR_to_R_PTR_2 , R_to_WR_PTR_1 , R_to_WR_PTR_2 ;


reg [11:0] ff [7:0];
reg [7:0] mem [15:0];

// gray code block :

assign WR_PTR_gry[2]=WR_PTR_bin[2] ;
assign WR_PTR_gry[1]=WR_PTR_bin[1] ^ WR_PTR_bin[2];
assign WR_PTR_gry[0]=WR_PTR_bin[0] ^ WR_PTR_bin[1];

assign R_PTR_gry[2]=R_PTR_bin[2] ;
assign R_PTR_gry[1]=R_PTR_bin[1] ^ R_PTR_bin[2];
assign R_PTR_gry[0]=R_PTR_bin[0] ^ R_PTR_bin[1];


// reconvert the synchronizers output to bin

assign R_to_WR_PTR_2_bin[2]=R_to_WR_PTR_2[2];
assign R_to_WR_PTR_2_bin[1]=R_to_WR_PTR_2[1] ^ R_to_WR_PTR_2_bin[2];
assign R_to_WR_PTR_2_bin[0]=R_to_WR_PTR_2[0] ^ R_to_WR_PTR_2_bin[1];

assign WR_to_R_PTR_2_bin[2]=WR_to_R_PTR_2[2];
assign WR_to_R_PTR_2_bin[1]=WR_to_R_PTR_2[1] ^ WR_to_R_PTR_2_bin[2];
assign WR_to_R_PTR_2_bin[0]=WR_to_R_PTR_2[0] ^ WR_to_R_PTR_2_bin[1];


//%%%%%%% --- synchronizers for both --- %%%%%% //
// write pointer ke read me vajota thruve the read clk :


always @ (negedge R_clk) begin


    if(reset_R) begin

        WR_to_R_PTR_1 <= 0;
        WR_to_R_PTR_2 <= 0;

    end


    else begin

        WR_to_R_PTR_1 <= WR_PTR_gry ; 
        WR_to_R_PTR_2 <= WR_to_R_PTR_1 ;
         
    end


end


// read pointer ke write domain me 


always @ (negedge WR_clk) begin


    if(reset_WR == 1'b1) begin


        R_to_WR_PTR_1 <= 0;
        R_to_WR_PTR_2 <= 0;
        
    end


    else begin

        R_to_WR_PTR_1 <= R_PTR_gry ; 
        R_to_WR_PTR_2 <= R_to_WR_PTR_1 ;
         
    end


end


// write domain things : 


always @ (negedge WR_clk) begin


    if(reset_WR == 1'b1) begin


        WR_PTR_bin <=3'b0 ;
        FULL_WR    <=1'b0 ;


    end


    //full in write :


    FULL_WR <= (WR_PTR_bin + 3'b001 == R_to_WR_PTR_2_bin) ;


    // wriing :


    if((WR_EN) & (!FULL_WR)) begin


        ff[WR_PTR_bin]  <= data_in ;
        WR_PTR_bin <= 3'b001 + WR_PTR_bin ;


    end


end


// read domain things


always @(negedge R_clk) begin


        if(reset_R) begin


            R_PTR_bin <= 3'b0 ;  
            EMPTY_R   <= 1'b1 ;
        
        end


        EMPTY_R <=  ( R_PTR_bin == WR_to_R_PTR_2_bin )  ;


    if(!EMPTY_R & R_EN) begin


        mem[ff[R_PTR_bin][11:8]] <= ff[R_PTR_bin][7:0] ;
        R_PTR_bin <= 3'b001 + R_PTR_bin ;


    end
    end
    
endmodule









