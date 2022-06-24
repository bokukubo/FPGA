`timescale 1ps/1ps

/*
0:7'b1111110
1:7'b1100000
2:7'b1101101
3:7'b1111001
4:7'b0110011
5:7'b1011011
6:7'b1011111
7:7'b1110000
8:7'b1111111
9:7'b1111011
A:7'b1110111
B:7'b0011111
C:7'b1001110
D:7'b0111101
E:7'b1001111
F:7'b1000111
*/

module kubo7seg(
    input i_clk,
    input i_reset,
    input i_en,

    input [7:0]i_data,
    input i_indata_valid,

    output [6:0]led0,
    output [6:0]led1

    );

    reg [13:0]sr_led;

    function [13:0]tamesi7seg;

        input [7:0]f_led;
        input f_indata_valid;
        input [13:0]f_r_led;

        begin
            if(f_indata_valid==1)begin
                case(f_led[3:0])
                    4'h0 : tamesi7seg[6:0] = 7'b1111110;
                    4'h1 : tamesi7seg[6:0] = 7'b1100000;
                    4'h2 : tamesi7seg[6:0] = 7'b1101101;
                    4'h3 : tamesi7seg[6:0] = 7'b1111001;
                    4'h4 : tamesi7seg[6:0] = 7'b0110011;
                    4'h5 : tamesi7seg[6:0] = 7'b1011011;
                    4'h6 : tamesi7seg[6:0] = 7'b1011111;
                    4'h7 : tamesi7seg[6:0] = 7'b1110000;
                    4'h8 : tamesi7seg[6:0] = 7'b1111111;
                    4'h9 : tamesi7seg[6:0] = 7'b1111011;
                    4'hA : tamesi7seg[6:0] = 7'b1110111;
                    4'hB : tamesi7seg[6:0] = 7'b0011111;
                    4'hC : tamesi7seg[6:0] = 7'b1001110;
                    4'hD : tamesi7seg[6:0] = 7'b0111101;
                    4'hE : tamesi7seg[6:0] = 7'b1001111;
                    4'hF : tamesi7seg[6:0] = 7'b1000111;
                endcase

                case(f_led[7:4])
                    4'h0 : tamesi7seg[13:7] = 7'b1111110;
                    4'h1 : tamesi7seg[13:7] = 7'b1100000;
                    4'h2 : tamesi7seg[13:7] = 7'b1101101;
                    4'h3 : tamesi7seg[13:7] = 7'b1111001;
                    4'h4 : tamesi7seg[13:7] = 7'b0110011;
                    4'h5 : tamesi7seg[13:7] = 7'b1011011;
                    4'h6 : tamesi7seg[13:7] = 7'b1011111;
                    4'h7 : tamesi7seg[13:7] = 7'b1110000;
                    4'h8 : tamesi7seg[13:7] = 7'b1111111;
                    4'h9 : tamesi7seg[13:7] = 7'b1111011;
                    4'hA : tamesi7seg[13:7] = 7'b1110111;
                    4'hB : tamesi7seg[13:7] = 7'b0011111;
                    4'hC : tamesi7seg[13:7] = 7'b1001110;
                    4'hD : tamesi7seg[13:7] = 7'b0111101;
                    4'hE : tamesi7seg[13:7] = 7'b1001111;
                    4'hF : tamesi7seg[13:7] = 7'b1000111;
                endcase

                end else begin
                tamesi7seg = f_r_led;
            end
        end
    endfunction

    always @(posedge i_clk or posedge i_reset) begin
    
        if(i_reset) begin

            sr_led = 14'b0000000_0000000;

        end else begin
    
            if(i_en != 1) begin

                sr_led = 14'b0000000_0000000;

            end else begin
                
                sr_led = tamesi7seg(i_data,i_indata_valid,sr_led);

            end
        end
    end

    //wire sr_led = tamesi7seg(i_data,i_indata_valid,sr_led); //レジスタ登録を行う時はalwaysが必要？
    assign led1 = sr_led[6:0];
    assign led0 = sr_led[13:7];

    initial begin
        sr_led = 14'b0000000_0000000;
    end

endmodule
