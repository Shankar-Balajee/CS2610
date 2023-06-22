`timescale 1ns/1ns

module deeflipflop (input d, clk, enable,output q);
    reg q;
    always @(posedge clk)
    if(enable==1)
     begin q = d;end 
endmodule

module reg12bit (input [11:0] d_in, input clk, enable,output [11:0] q
);deeflipflop ff[11:0] (d_in[11:0], clk, enable, q[11:0]);endmodule

module eightx1mux12bit(
    input [11:0] s0, s1, s2, s3, s4, s5, s6, s7,
    input [2:0] control,
    output [11:0] out
);

    wire [2:0] control_not;
    wire [11:0] c, c0, c1, c2, c3, c4, c5, c6, c7;
    wire [11:0] out_temp0, out_temp1, out_temp2, out_temp3, out_temp4, out_temp5, out_temp6, out_temp7;
    
    not not1[2:0] (control_not, control);
    and and1 (c[0], control_not[2], control_not[1], control_not[0]);
    and and2 (c[1], control_not[2], control_not[1], control[0]);
    and and3 (c[2], control_not[2], control[1], control_not[0]);
    and and4 (c[3], control_not[2], control[1], control[0]);
    and and5 (c[4], control[2], control_not[1], control_not[0]);
    and and6 (c[5], control[2], control_not[1], control[0]);
    and and7 (c[6], control[2], control[1], control_not[0]);
    and and8 (c[7], control[2], control[1], control[0]);

    buf buf1[11:0] (c0, c[0]);
    buf buf2[11:0] (c1, c[1]);
    buf buf3[11:0] (c2, c[2]);
    buf buf4[11:0] (c3, c[3]);
    buf buf5[11:0] (c4, c[4]);
    buf buf6[11:0] (c5, c[5]);
    buf buf7[11:0] (c6, c[6]);
    buf buf8[11:0] (c7, c[7]);

    and and9[11:0] (out_temp0, s0, c0);
    and and10[11:0] (out_temp1, s1, c1);
    and and11[11:0] (out_temp2, s2, c2);
    and and12[11:0] (out_temp3, s3, c3);
    and and13[11:0] (out_temp4, s4, c4);
    and and14[11:0] (out_temp5, s5, c5);
    and and15[11:0] (out_temp6, s6, c6);
    and and16[11:0] (out_temp7, s7, c7);

    or or1[11:0] (out, out_temp0, out_temp1, out_temp2, out_temp3, out_temp4, out_temp5, out_temp6, out_temp7);

endmodule

module registerfile(input [2:0] readadd1,readadd2,writeadd,input[11:0] datain,input writeen,input clk,output [11:0] dataout1,dataout2);
wire [11:0] regread [7:0];
wire [7:0] regwriteen,tempregwriteen;
wire [7:0] inputwriteen;
decoder d11 (writeadd,tempregwriteen);
buf buf1[7:0] (inputwriteen[7:0],writeen);
and a1[7:0] (regwriteen[7:0],tempregwriteen[7:0],inputwriteen[7:0]);
reg12bit reg1 (datain,clk,regwriteen[0],regread[0]);
reg12bit reg2 (datain,clk,regwriteen[1],regread[1]);
reg12bit reg3 (datain,clk,regwriteen[2],regread[2]);
reg12bit reg4 (datain,clk,regwriteen[3],regread[3]);
reg12bit reg5 (datain,clk,regwriteen[4],regread[4]);
reg12bit reg6 (datain,clk,regwriteen[5],regread[5]);
reg12bit reg7 (datain,clk,regwriteen[6],regread[6]);
reg12bit reg8 (datain,clk,regwriteen[7],regread[7]);

eightx1mux12bit mux1(regread[0],regread[1],regread[2],regread[3],regread[4],regread[5],regread[6],regread[7],readadd1,dataout1);
eightx1mux12bit mux2(regread[0],regread[1],regread[2],regread[3],regread[4],regread[5],regread[6],regread[7],readadd2,dataout2);

endmodule