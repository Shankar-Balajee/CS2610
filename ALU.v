`timescale 1ns/1ns
module decoder(input [2:0] op,output [7:0] sel); 
    wire [2:0] notop;
    not nots[2:0] (notop[2:0], op[2:0]);
    and and0 (sel[0], notop[2], notop[1], notop[0]); 
    and and1 (sel[1], notop[2], notop[1], op[0]);
    and and2 (sel[2], notop[2], op[1], notop[0]);
    and and3 (sel[3], notop[2], op[1], op[0]);
    and and4 (sel[4], op[2], notop[1], notop[0]);
    and and5 (sel[5], op[2], notop[1], op[0]); 
    and and6 (sel[6], op[2], op[1], notop[0]);
    and and7 (sel[7], op[2], op[1], op[0]);
endmodule

module CLA8(a,b, cin, sum,cout,overflow,sign);
input [7:0] a,b;
input cin;
input sign;
output [7:0] sum;
output cout;
output overflow;
wire c1,c2,c3;
wire [7:0] bones;
xor xor1[7:0](bones,b,cin);
wire overflow1,overflow2,overflow3,overflow4;
CLA4 cla1 (.a(a[3:0]), .b(bones[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c1),
.overflow(overflow1),.sign(sign));
CLA4 cla2 (.a(a[7:4]), .b(bones[7:4]), .cin(c1), .sum(sum[7:4]), .cout(cout),
.overflow(overflow2),.sign(sign));
assign overflow=overflow2;
endmodule

`timescale 1ns/1ns


module full_adder(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    wire t1,t2,t3;
    xor x1(t1,a,b);
    and a1(t2,a,b);
    xor x2(sum,t1,cin);
    or oo1(cout,t1&cin,t2);
endmodule

module CLA4(a,b, cin, sum,cout,overflow,sign);
    input [3:0] a,b;
    input cin;
    input sign;
    output [3:0] sum;
    output cout;
    output overflow;
    wire cock1,cock2;

    wire [3:0] p,g,c;
    wire notsign;

    xor xor1[3:0](p,a,b);
    and anderson[3:0](g,a,b);
    //assign cin to c[0] structurally
    buf cin_buf(c[0],cin);
    wire t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16;
    and a2(t1,p[0],c[0]);
    or o2(c[1],t1,g[0]);
    and a3(t2,p[1],p[0],c[0]);
    and a4(t3,p[1],g[0]);
    or o3(c[2],t2,t3,g[1]);
    // assign c[2]=(p[1]&p[0]&c[0])|(p[1]&g[0])|(g[1]);
    and a5(t4,p[2],p[1],p[0],c[0]);
    and a6(t5,p[2],p[1],g[0]);
    and a7(t6,p[2],g[1]);
    or o4(c[3],t4,t5,t6,g[2]);
    // assign c[3]=(p[2]&p[1]&p[0]&c[0])|(p[2]&p[1]&g[0])|(p[2]&g[1])|(g[2]);
    and a8(t7,p[3],p[2],p[1],p[0],c[0]);
    and a9(t8,g[0],p[1],p[2],p[3]);
    and a10(t9,p[3],p[2],g[1]);
    and a11(t10,p[3],g[2]);
    or o5(cout,t7,t8,t9,t10,g[3]);
    // assign cout=(p[3]&p[2]&p[1]&p[0]&c[0])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&g[1])|(p[3]&g[2])|(g[3]);
    xor final1[3:0](sum,p,c);
    not n11(notsign,sign);
    and tp(cock1,notsign,cout);
    wire tt;
    xor sign_cond(tt,cout,c[3]);
    and tp2(cock2,sign,tt);
    or finalegate(overflow,cock1,cock2);
endmodule


module CLA16(a,b, cin, sum,cout,overflow,sign);
    input [15:0] a,b;
    input cin;
    input sign;
    output [15:0] sum;
    output cout;
    output overflow;
    wire c1,c2,c3;
    wire [15:0] bones;
    xor xor1[15:0](bones,b,cin);
    wire overflow1,overflow2,overflow3,overflow4;
    CLA4 cla1 (.a(a[3:0]), .b(bones[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c1), .overflow(overflow1),.sign(sign));
    CLA4 cla2 (.a(a[7:4]), .b(bones[7:4]), .cin(c1), .sum(sum[7:4]), .cout(c2), .overflow(overflow2),.sign(sign));
    CLA4 cla3(.a(a[11:8]), .b(bones[11:8]), .cin(c2), .sum(sum[11:8]), .cout(c3), .overflow(overflow3),.sign(sign));
    CLA4 cla4(.a(a[15:12]), .b(bones[15:12]), .cin(c3), .sum(sum[15:12]), .cout(cout), .overflow(overflow4),.sign(sign));
    assign overflow=overflow4;
endmodule

module twox1muxspe (a, b, sel, y);

input [7:0] a, b;
input sel;
output [7:0] y;

//gate logic if sel == 0 select a else select b

wire [7:0] c,d;

and a1 (c[0],a[0],~sel);
and a2 (c[1],a[1],~sel);
and a3 (c[2],a[2],~sel);
and a4 (c[3],a[3],~sel);
and a5 (c[4],a[4],~sel);
and a6 (c[5],a[5],~sel);
and a7 (c[6],a[6],~sel);
and a8 (c[7],a[7],~sel);

and b1 (d[0],b[0],sel);
and b2 (d[1],b[1],sel);
and b3 (d[2],b[2],sel);
and b4 (d[3],b[3],sel);
and b5 (d[4],b[4],sel);
and b6 (d[5],b[5],sel);
and b7 (d[6],b[6],sel);
and b8 (d[7],b[7],sel);

or o1 (y[0],c[0],d[0]);
or o2 (y[1],c[1],d[1]);
or o3 (y[2],c[2],d[2]);
or o4 (y[3],c[3],d[3]);
or o5 (y[4],c[4],d[4]);
or o6 (y[5],c[5],d[5]);
or o7 (y[6],c[6],d[6]);
or o8 (y[7],c[7],d[7]);

endmodule


module two_comp(a,b);
    input [15:0] a;
    output [15:0] b;
    wire [15:0] nota;
    wire cout,overflow;
    not n1[15:0](nota,a);
    CLA16 c1(.a(nota), .b(16'b0000000000000001), .cin(1'b0), .sum(b), .cout(cout), .overflow(overflow));
endmodule


module threetotwobeta(a,b,c,sum,carry);
    input [15:0] a;
    input [15:0] b;
    input [15:0] c;
    output [15:0] carry;
    output [15:0] sum;
    wire [15:0] temp_car;
    full_adder fa1(.a(a[0]), .b(b[0]), .cin(c[0]), .sum(sum[0]), .cout(temp_car[0]));
    full_adder fa2(.a(a[1]), .b(b[1]), .cin(c[1]), .sum(sum[1]), .cout(temp_car[1]));
    full_adder fa3(.a(a[2]), .b(b[2]), .cin(c[2]), .sum(sum[2]), .cout(temp_car[2]));
    full_adder fa4(.a(a[3]), .b(b[3]), .cin(c[3]), .sum(sum[3]), .cout(temp_car[3]));
    full_adder fa5(.a(a[4]), .b(b[4]), .cin(c[4]), .sum(sum[4]), .cout(temp_car[4]));
    full_adder fa6(.a(a[5]), .b(b[5]), .cin(c[5]), .sum(sum[5]), .cout(temp_car[5]));
    full_adder fa7(.a(a[6]), .b(b[6]), .cin(c[6]), .sum(sum[6]), .cout(temp_car[6]));
    full_adder fa8(.a(a[7]), .b(b[7]), .cin(c[7]), .sum(sum[7]), .cout(temp_car[7]));
    full_adder fa9(.a(a[8]), .b(b[8]), .cin(c[8]), .sum(sum[8]), .cout(temp_car[8]));
    full_adder fa10(.a(a[9]), .b(b[9]), .cin(c[9]), .sum(sum[9]), .cout(temp_car[9]));
    full_adder fa11(.a(a[10]), .b(b[10]), .cin(c[10]), .sum(sum[10]), .cout(temp_car[10]));
    full_adder fa12(.a(a[11]), .b(b[11]), .cin(c[11]), .sum(sum[11]), .cout(temp_car[11]));
    full_adder fa13(.a(a[12]), .b(b[12]), .cin(c[12]), .sum(sum[12]), .cout(temp_car[12]));
    full_adder fa14(.a(a[13]), .b(b[13]), .cin(c[13]), .sum(sum[13]), .cout(temp_car[13]));
    full_adder fa15(.a(a[14]), .b(b[14]), .cin(c[14]), .sum(sum[14]), .cout(temp_car[14]));
    full_adder fa16(.a(a[15]), .b(b[15]), .cin(c[15]), .sum(sum[15]), .cout(temp_car[15]));
    //bit shift carry
    buf b11carry[14:0](carry[15:1],temp_car[14:0]);
    assign carry[0]=0;
endmodule

module partial_product_compute(a,b,out);
    input [7:0] a;
    input b;
    output [15:0] out;
    assign out[0]=a[0]&b;
    assign out[1]=a[1]&b;
    assign out[2]=a[2]&b;
    assign out[3]=a[3]&b;
    assign out[4]=a[4]&b;
    assign out[5]=a[5]&b;
    assign out[6]=a[6]&b;
    assign out[7]=a[7]&b;
    assign out[8]=1'b0;
    assign out[9]=1'b0;
    assign out[10]=1'b0;
    assign out[11]=1'b0;
    assign out[12]=1'b0;
    assign out[13]=1'b0;
    assign out[14]=1'b0;
    assign out[15]=1'b0;
endmodule

module Tree(a,b,out,overflow);
    input [7:0] a;
    input [7:0] b;
    output [15:0] out;
    output overflow;
    wire [15:0] carry0,carry1,carry2,carry3,carry4,carry5;
    wire [15:0] sum0,sum1,sum2,sum3,sum4,sum5;
    //partial products
    wire [15:0] p0,p1,p2,p3,p4,p5,p6,p7;
    wire [15:0] temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
    wire t1,t2,t3,t4,t5,t6,t7,t8,t9;
  

    partial_product_compute ppc1(.a(a), .b(b[0]), .out(p0));
    partial_product_compute ppc2(.a(a), .b(b[1]), .out(temp1));
    //shift one bit  in p1 
    buf b1[14:0](p1[15:1],temp1[14:0]);
    assign p1[0]=0;
    partial_product_compute ppc3(.a(a), .b(b[2]), .out(temp2));
    //shift two bits in p2
    buf b2[13:0](p2[15:2],temp2[13:0]);
    assign p2[0]=0;
    assign p2[1]=0;
    partial_product_compute ppc4(.a(a), .b(b[3]), .out(temp3));
    //shift three bits in p3
    buf b3[12:0](p3[15:3],temp3[12:0]);
    assign p3[0]=0;
    assign p3[1]=0;
    assign p3[2]=0;
    partial_product_compute ppc5(.a(a), .b(b[4]), .out(temp4));
    //shift four bits in p4
    buf b4[11:0](p4[15:4],temp4[11:0]);
    assign p4[0]=0;
    assign p4[1]=0;
    assign p4[2]=0;
    assign p4[3]=0;
    partial_product_compute ppc6(.a(a), .b(b[5]), .out(temp5));
    //shift five bits in p5
    buf b5[10:0](p5[15:5],temp5[10:0]);
    assign p5[0]=0;
    assign p5[1]=0;
    assign p5[2]=0;
    assign p5[3]=0;
    assign p5[4]=0;
    partial_product_compute ppc7(.a(a), .b(b[6]), .out(temp6));
    //shift six bits in p6
    buf b6[9:0](p6[15:6],temp6[9:0]);
    assign p6[0]=0;
    assign p6[1]=0;
    assign p6[2]=0;
    assign p6[3]=0;
    assign p6[4]=0;
    assign p6[5]=0;
    partial_product_compute ppc8(.a(a), .b(b[7]), .out(temp7));
    //shift seven bits in p7
    buf b7[8:0](p7[15:7],temp7[8:0]);
    assign p7[0]=0;
    assign p7[1]=0;
    assign p7[2]=0;
    assign p7[3]=0;
    assign p7[4]=0;
    assign p7[5]=0;
    assign p7[6]=0;
    // we got the partial products , now implement the tree using 3to2beta
    
    wire cin,cout,overflow,sign;
    threetotwobeta tt1(.a(p0), .b(p1), .c(p2), .sum(sum0), .carry(carry0));
    threetotwobeta tt2(.a(p3), .b(p4), .c(p5), .sum(sum1), .carry(carry1));
    threetotwobeta tt3(.a(sum0), .b(carry0), .c(sum1), .sum(sum2), .carry(carry2));
    threetotwobeta tt4(.a(p6), .b(p7), .c(carry1), .sum(sum3), .carry(carry3));
    threetotwobeta tt5(.a(sum2), .b(carry2), .c(sum3), .sum(sum4), .carry(carry4));
    threetotwobeta tt6(.a(carry3), .b(sum4), .c(carry4), .sum(sum5), .carry(carry5));
    //16 bit adder
    CLA16 cla(.a(sum5), .b(carry5), .cin(1'b0), .sum(out), .cout(cout));

    or or1[7:0](t1,out[7],out[8],out[9],out[10],out[11],out[12],out[13],out[14],out[15]);
    xnor augh(t2,a[7],b[7]);
    and aa1(t3,t1,t2);
    wire notstore[8:0];
    not ni1(notstore[0],out[7]);
    not ni2(notstore[1],out[8]);
    not ni3(notstore[2],out[9]);
    not ni4(notstore[3],out[10]);
    not ni5(notstore[4],out[11]);
    not ni6(notstore[5],out[12]);
    not ni7(notstore[6],out[13]);
    not ni8(notstore[7],out[14]);
    not ni9(notstore[8],out[15]);
    or orr1[7:0](t4,notstore[0],notstore[1],notstore[2],notstore[3],notstore[4],notstore[5],notstore[6],notstore[7],notstore[8]);
    xor aurgh(t5,a[7],b[7]);
    and aar1(t6,t4,t5);
    or finale(overflow,out[8],out[9],out[10],out[11],out[12],out[13],out[14],out[15]);
endmodule




module mantissa_mul(a,b,prod,overflow);
    input [7:0] a;
    input [7:0] b;
    output [15:0] prod;
    output overflow;
    Tree tree1(.a(a), .b(b), .out(prod), .overflow(overflow));
endmodule


module twox1mux (a, b, sel, y);

input [6:0] a, b;
input sel;
output [6:0] y;

//gate logic if sel == 0 select a else select b

wire [6:0] c,d;

and a1 (c[0],a[0],~sel);
and a2 (c[1],a[1],~sel);
and a3 (c[2],a[2],~sel);
and a4 (c[3],a[3],~sel);
and a5 (c[4],a[4],~sel);
and a6 (c[5],a[5],~sel);
and a7 (c[6],a[6],~sel);

and b1 (d[0],b[0],sel);
and b2 (d[1],b[1],sel);
and b3 (d[2],b[2],sel);
and b4 (d[3],b[3],sel);
and b5 (d[4],b[4],sel);
and b6 (d[5],b[5],sel);
and b7 (d[6],b[6],sel);

or o1 (y[0],c[0],d[0]);
or o2 (y[1],c[1],d[1]);
or o3 (y[2],c[2],d[2]);
or o4 (y[3],c[3],d[3]);
or o5 (y[4],c[4],d[4]);
or o6 (y[5],c[5],d[5]);
or o7 (y[6],c[6],d[6]);

endmodule


module twox1mux4bit (a, b, sel, y);

input [3:0] a, b;
input sel;
output [3:0] y;

//gate logic if sel == 0 select a else select b

wire [3:0] c,d;

and a1 (c[0],a[0],~sel);
and a2 (c[1],a[1],~sel);
and a3 (c[2],a[2],~sel);
and a4 (c[3],a[3],~sel);


and b1 (d[0],b[0],sel);
and b2 (d[1],b[1],sel);
and b3 (d[2],b[2],sel);
and b4 (d[3],b[3],sel);

or o1 (y[0],c[0],d[0]);
or o2 (y[1],c[1],d[1]);
or o3 (y[2],c[2],d[2]);
or o4 (y[3],c[3],d[3]);

endmodule


module floatmul(a,b,prod,overflow_exp);
    input [11:0] a;
    input [11:0] b;
    output [11:0] prod;
    output overflow_exp;
    wire [4:0] exp_sumy;
    wire [7:0] subout1,subout2;
    wire [15:0] temp_prod_by_mul_mantissa;
    wire [6:0] temp1,temp2;
    wire [6:0] z_mantissa;

    wire [7:0] a_mantissa;
    wire [7:0] b_mantissa;


    buf b1[6:0](a_mantissa[6:0],a[6:0]);
    buf b2(a_mantissa[7],1'b1);
    buf b3[6:0](b_mantissa[6:0],b[6:0]);
    buf b4(b_mantissa[7],1'b1);

    
    wire mult_overflow;

    mantissa_mul mantissa_mul1(.a(a_mantissa), .b(b_mantissa), .prod(temp_prod_by_mul_mantissa), .overflow(mult_overflow));

    
    buf b5[6:0](temp1[6:0],temp_prod_by_mul_mantissa[14:8]);
    buf b6[6:0](temp2[6:0],temp_prod_by_mul_mantissa[13:7]);

    

    twox1mux two1muxyboi(.a(temp2),.b(temp1),.sel(temp_prod_by_mul_mantissa[15]),.y(z_mantissa));



    wire cout,ovv,sins;
    

    CLA4 cary4(.a(a[10:7]),.b(b[10:7]),.cin(1'b0),.sum(exp_sumy[3:0]),.cout(cout),.overflow(ovv),.sign(1'b0));
    buf bb(exp_sumy[4],cout);
    // a,b, cin, sum,cout,overflow,sign


    wire [7:0] op1,op2,op3;
    buf bufop1[4:0](op1[4:0],exp_sumy[4:0]);
    buf bufop2[7:5](op1[7:5],3'b000);

    assign op2=8'b00000111;
    assign op3=8'b00000110;

    
    wire uselesscarr1,uselessover1,sgn1,selesscarr2,uselessover2,sgn2;

    CLA8 cla8sub(.a(op1),.b(op2),.cin(1'b1),.sum(subout1),.cout(uselesscarr1),.overflow(uselessover1),.sign(1'b0));

    CLA8 cla8sub11(.a(op1),.b(op3),.cin(1'b1),.sum(subout2),.cout(uselesscarr2),.overflow(uselessover2),.sign(1'b0));

    wire [3:0] finops1,finops2;
    buf augh1[3:0](finops1,subout1[3:0]);
    buf augh2[3:0](finops2,subout2[3:0]);

    wire [3:0] zexp;

    twox1mux4bit two1muxyboi4bit(.a(finops1),.b(finops2),.sel(temp_prod_by_mul_mantissa[15]),.y(zexp));
    wire y11,x2;

    and o1(y11,temp_prod_by_mul_mantissa[15],subout2[4]);
    and o2(x2,~temp_prod_by_mul_mantissa[15],subout1[4]);

    or o3(overflow_exp,y11,x2);

    assign prod[11]=a[11]^b[11];

    buf ans1[3:0](prod[10:7],zexp);
    buf ans2[6:0](prod[6:0],z_mantissa);

endmodule

// CHANGE THE SHIFTER 


module eightbitmultiplicationunsigned(a,b,out,overflow);
    input [7:0] a;
    input [7:0] b;
    output [15:0] out;
    output overflow;
    wire [15:0] carry0,carry1,carry2,carry3,carry4,carry5;
    wire [15:0] sum0,sum1,sum2,sum3,sum4,sum5;
    //partial products
    wire [15:0] p0,p1,p2,p3,p4,p5,p6,p7;
    wire [15:0] temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
    wire t1,t2,t3,t4,t5,t6,t7,t8,t9;
  

    partial_product_compute ppc1(.a(a), .b(b[0]), .out(p0));
    partial_product_compute ppc2(.a(a), .b(b[1]), .out(temp1));
    //shift one bit  in p1 
    buf b1[14:0](p1[15:1],temp1[14:0]);
    assign p1[0]=0;
    partial_product_compute ppc3(.a(a), .b(b[2]), .out(temp2));
    //shift two bits in p2
    buf b2[13:0](p2[15:2],temp2[13:0]);
    assign p2[0]=0;
    assign p2[1]=0;
    partial_product_compute ppc4(.a(a), .b(b[3]), .out(temp3));
    //shift three bits in p3
    buf b3[12:0](p3[15:3],temp3[12:0]);
    assign p3[0]=0;
    assign p3[1]=0;
    assign p3[2]=0;
    partial_product_compute ppc5(.a(a), .b(b[4]), .out(temp4));
    //shift four bits in p4
    buf b4[11:0](p4[15:4],temp4[11:0]);
    assign p4[0]=0;
    assign p4[1]=0;
    assign p4[2]=0;
    assign p4[3]=0;
    partial_product_compute ppc6(.a(a), .b(b[5]), .out(temp5));
    //shift five bits in p5
    buf b5[10:0](p5[15:5],temp5[10:0]);
    assign p5[0]=0;
    assign p5[1]=0;
    assign p5[2]=0;
    assign p5[3]=0;
    assign p5[4]=0;
    partial_product_compute ppc7(.a(a), .b(b[6]), .out(temp6));
    //shift six bits in p6
    buf b6[9:0](p6[15:6],temp6[9:0]);
    assign p6[0]=0;
    assign p6[1]=0;
    assign p6[2]=0;
    assign p6[3]=0;
    assign p6[4]=0;
    assign p6[5]=0;
    partial_product_compute ppc8(.a(a), .b(b[7]), .out(temp7));
    //shift seven bits in p7
    buf b7[8:0](p7[15:7],temp7[8:0]);
    assign p7[0]=0;
    assign p7[1]=0;
    assign p7[2]=0;
    assign p7[3]=0;
    assign p7[4]=0;
    assign p7[5]=0;
    assign p7[6]=0;
    // we got the partial products , now implement the tree using 3to2beta
    
    wire cin,cout,overflow,sign;
    threetotwobeta tt1(.a(p0), .b(p1), .c(p2), .sum(sum0), .carry(carry0));
    threetotwobeta tt2(.a(p3), .b(p4), .c(p5), .sum(sum1), .carry(carry1));
    threetotwobeta tt3(.a(sum0), .b(carry0), .c(sum1), .sum(sum2), .carry(carry2));
    threetotwobeta tt4(.a(p6), .b(p7), .c(carry1), .sum(sum3), .carry(carry3));
    threetotwobeta tt5(.a(sum2), .b(carry2), .c(sum3), .sum(sum4), .carry(carry4));
    threetotwobeta tt6(.a(carry3), .b(sum4), .c(carry4), .sum(sum5), .carry(carry5));
    //16 bit adder
    CLA16 cla(.a(sum5), .b(carry5), .cin(1'b0), .sum(out), .cout(cout));

    or or1[7:0](t1,out[7],out[8],out[9],out[10],out[11],out[12],out[13],out[14],out[15]);
    xnor augh(t2,a[7],b[7]);
    and aa1(t3,t1,t2);
    wire notstore[8:0];
    not ni1(notstore[0],out[7]);
    not ni2(notstore[1],out[8]);
    not ni3(notstore[2],out[9]);
    not ni4(notstore[3],out[10]);
    not ni5(notstore[4],out[11]);
    not ni6(notstore[5],out[12]);
    not ni7(notstore[6],out[13]);
    not ni8(notstore[7],out[14]);
    not ni9(notstore[8],out[15]);
    or orr1[7:0](t4,notstore[0],notstore[1],notstore[2],notstore[3],notstore[4],notstore[5],notstore[6],notstore[7],notstore[8]);
    xor aurgh(t5,a[7],b[7]);
    and aar1(t6,t4,t5);
    or finale(overflow,out[8],out[9],out[10],out[11],out[12],out[13],out[14],out[15]);
endmodule





module eightbitmultiplicationsigned(a,b,out,overflow);
    input [7:0] a;
    input [7:0] b;
    output [15:0] out,sum0,carry0;
    output overflow;
    wire [15:0] carry0,carry1,carry2,carry3,carry4,carry5,carry6,carry7;
    wire [15:0] sum0,sum1,sum2,sum3,sum4,sum5,sum6,sum7;
    //partial products
    wire [15:0] p0,p1,p2,p3,p4,p5,p6,p7;
    wire [15:0] temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
    wire t1,t2,t3,t4,t5,t6,t7,t8,t9;
  

    partial_product_compute ppc1(.a(a), .b(b[0]), .out(p0));
    partial_product_compute ppc2(.a(a), .b(b[1]), .out(temp1));
    //shift one bit  in p1 
    buf b1[14:0](p1[15:1],temp1[14:0]);
    assign p1[0]=0;
    partial_product_compute ppc3(.a(a), .b(b[2]), .out(temp2));
    //shift two bits in p2
    buf b2[13:0](p2[15:2],temp2[13:0]);
    assign p2[0]=0;
    assign p2[1]=0;
    partial_product_compute ppc4(.a(a), .b(b[3]), .out(temp3));
    //shift three bits in p3
    buf b3[12:0](p3[15:3],temp3[12:0]);
    assign p3[0]=0;
    assign p3[1]=0;
    assign p3[2]=0;
    partial_product_compute ppc5(.a(a), .b(b[4]), .out(temp4));
    //shift four bits in p4
    buf b4[11:0](p4[15:4],temp4[11:0]);
    assign p4[0]=0;
    assign p4[1]=0;
    assign p4[2]=0;
    assign p4[3]=0;
    partial_product_compute ppc6(.a(a), .b(b[5]), .out(temp5));
    //shift five bits in p5
    buf b5[10:0](p5[15:5],temp5[10:0]);
    assign p5[0]=0;
    assign p5[1]=0;
    assign p5[2]=0;
    assign p5[3]=0;
    assign p5[4]=0;
    partial_product_compute ppc7(.a(a), .b(b[6]), .out(temp6));
    //shift six bits in p6
    buf b6[9:0](p6[15:6],temp6[9:0]);
    assign p6[0]=0;
    assign p6[1]=0;
    assign p6[2]=0;
    assign p6[3]=0;
    assign p6[4]=0;
    assign p6[5]=0;
    partial_product_compute ppc8(.a(a), .b(b[7]), .out(temp7));
    //shift seven bits in p7
    wire [15:0] tempp7;
    buf b7[8:0](tempp7[15:7],temp7[8:0]);
    assign tempp7[0]=0;
    assign tempp7[1]=0;
    assign tempp7[2]=0;
    assign tempp7[3]=0;
    assign tempp7[4]=0;
    assign tempp7[5]=0;
    assign tempp7[6]=0;
    // we got the partial products , now implement the tree using 3to2beta
    xor sir1[15:0](p7,tempp7,b[7]);
    wire cin,cout,overflow,sign;
    wire lmao1,lmao2;
    wire [15:0] tp;
    assign tp[15:1]=15'b0;
    assign tp[0]=b[7];
    threetotwobeta tt1(.a(p0), .b(p1), .c(p2), .sum(sum0), .carry(carry0));
    threetotwobeta tt2(.a(p3), .b(p4), .c(p5), .sum(sum1), .carry(carry1));
    threetotwobeta ttt1(.a(p6), .b(p7), .c(tp), .sum(sum3), .carry(carry3));
    threetotwobeta tt3(.a(sum0), .b(carry0), .c(sum1), .sum(sum2), .carry(carry2));
    threetotwobeta tt4(.a(carry1), .b(sum3), .c(carry3), .sum(sum4), .carry(carry4));
    threetotwobeta tt5(.a(sum2), .b(carry2), .c(sum4), .sum(sum5), .carry(carry5));
    threetotwobeta tt6(.a(carry4), .b(sum5), .c(carry5), .sum(sum6), .carry(carry6));
    //16 bit adder
    CLA16 cla(.a(sum6), .b(carry6), .cin(1'b0), .sum(out), .cout(cout));

    or or1[7:0](t1,out[7],out[8],out[9],out[10],out[11],out[12],out[13],out[14],out[15]);
    xnor augh(t2,a[7],b[7]);
    and aa1(t3,t1,t2);
    wire notstore[8:0];
    not ni1(notstore[0],out[7]);
    not ni2(notstore[1],out[8]);
    not ni3(notstore[2],out[9]);
    not ni4(notstore[3],out[10]);
    not ni5(notstore[4],out[11]);
    not ni6(notstore[5],out[12]);
    not ni7(notstore[6],out[13]);
    not ni8(notstore[7],out[14]);
    not ni9(notstore[8],out[15]);
    or orr1[7:0](t4,notstore[0],notstore[1],notstore[2],notstore[3],notstore[4],notstore[5],notstore[6],notstore[7],notstore[8]);
    xor aurgh(t5,a[7],b[7]);
    and aar1(t6,t4,t5);
    or finale(overflow,t3,t6);
endmodule




module eightx1mux (a,b,c,d,e,f,g,h,sel,y);

input [7:0] a,b,c,d,e,f,g,h;
input [2:0] sel;
output [7:0] y;


wire c1,c2,c3;
assign c1 = sel[0];
assign c2 = sel[1];
assign c3 = sel[2];

wire [7:0] y1, y2, y3, y4, y5, y6;

twox1muxspe mux1 (a,b,c1,y1);
twox1muxspe mux2 (c,d,c1,y2);
twox1muxspe mux3 (e,f,c1,y3);
twox1muxspe mux4 (g,h,c1,y4);

twox1muxspe mux5 (y1,y2,c2,y5);
twox1muxspe mux6 (y3,y4,c2,y6);

twox1muxspe mux7 (y5,y6,c3,y);
endmodule



module barrel_shifter(a,sel,tp,y);

input [7:0] a;
input [2:0] sel;
input tp;
output [7:0] y;


wire[7:0] b,c,d,e,f,g,h;
wire [7:0] temp;

// b is a shifted left by 1
// c is a shifted left by 2

assign b[0] = a[1];
assign b[1] = a[2];
assign b[2] = a[3];
assign b[3] = a[4];
assign b[4] = a[5];
assign b[5] = a[6];
assign b[6] = a[7];
assign b[7] = 1'b0;

assign c[0] = a[2];
assign c[1] = a[3];
assign c[2] = a[4];
assign c[3] = a[5];
assign c[4] = a[6];
assign c[5] = a[7];
assign c[6] = 1'b0;
assign c[7] = 1'b0;

assign d[0] = a[3];
assign d[1] = a[4];
assign d[2] = a[5];
assign d[3] = a[6];
assign d[4] = a[7];
assign d[5] = 1'b0;
assign d[6] = 1'b0;
assign d[7] = 1'b0;

assign e[0] = a[4];
assign e[1] = a[5];
assign e[2] = a[6];
assign e[3] = a[7];
assign e[4] = 1'b0;
assign e[5] = 1'b0;
assign e[6] = 1'b0;
assign e[7] = 1'b0;

assign f[0] = a[5];
assign f[1] = a[6];
assign f[2] = a[7];
assign f[3] = 1'b0;
assign f[4] = 1'b0;
assign f[5] = 1'b0;
assign f[6] = 1'b0;
assign f[7] = 1'b0;

assign g[0] = a[6];
assign g[1] = a[7];
assign g[2] = 1'b0;
assign g[3] = 1'b0;
assign g[4] = 1'b0;
assign g[5] = 1'b0;
assign g[6] = 1'b0;
assign g[7] = 1'b0;

assign h[0] = a[7];
assign h[1] = 1'b0;
assign h[2] = 1'b0;
assign h[3] = 1'b0;
assign h[4] = 1'b0;
assign h[5] = 1'b0;
assign h[6] = 1'b0;
assign h[7] = 1'b0;

eightx1mux mux1 (a,b,c,d,e,f,g,h,sel,temp);

twox1muxspe mux2 (temp,8'b00000000,tp,y);

endmodule



module float_addition_12_bit(a,b,sum);
input [11:0] a,b;
output [11:0] sum;


wire [6:0] a_mantis,b_mantis;

wire [3:0] a_exp,b_exp,not_b_exp;
wire [7:0] augh;
wire [7:0] sum_mantis;
wire cout2;
wire [6:0] final_mantis;


wire a_sign,b_sign;
assign a_sign=a[11];
assign b_sign=b[11];

not not1[3:0](not_b_exp,b_exp);

buf b1[6:0](a_mantis,a[6:0]);
buf b2[6:0](b_mantis,b[6:0]);
buf b3[3:0](a_exp,a[10:7]);
buf b4[3:0](b_exp,b[10:7]);

wire cout,ovv,sign;
wire [3:0] sum_exp;
CLA4 cla1(a_exp,not_b_exp,1'b1,sum_exp,cout,ovv,1'b0);

wire bloo;
wire [2:0] selector;

buf  selector_buf[2:0](selector,sum_exp[2:0]);

wire [7:0] shifted_mantis;
wire tp;
assign tp=sum_exp[3];

assign augh[7]=1'b1;
assign augh[6:0]=b_mantis[6:0];
//CHECK THIS PLOX
barrel_shifter bs1(augh,selector,tp,shifted_mantis);
wire [7:0] onepointxmantis;
assign onepointxmantis[7]=1'b1;
assign onepointxmantis[6:0]=a_mantis[6:0];

//CLA to add mantis

wire ovv2;
CLA8 cla2(onepointxmantis,shifted_mantis,1'b0,sum_mantis,cout2,ovv2,1'b0);


or ha1 (final_mantis[0],cout2&sum_mantis[1],~cout2&sum_mantis[0]);
or ha2 (final_mantis[1],cout2&sum_mantis[2],~cout2&sum_mantis[1]);
or ha3 (final_mantis[2],cout2&sum_mantis[3],~cout2&sum_mantis[2]);
or ha4 (final_mantis[3],cout2&sum_mantis[4],~cout2&sum_mantis[3]);
or ha5 (final_mantis[4],cout2&sum_mantis[5],~cout2&sum_mantis[4]);
or ha6 (final_mantis[5],cout2&sum_mantis[6],~cout2&sum_mantis[5]);
or ha7 (final_mantis[6],cout2&sum_mantis[7],~cout2&sum_mantis[6]);

wire [3:0] final_exp;
wire cout3,ovv3;
CLA4 cla3(sum_exp,4'b0000,cout2,final_exp,cout3,ovv3,1'b0);

buf b5[6:0](sum[6:0],final_mantis[6:0]);
buf b6[3:0](sum[10:7],final_exp[3:0]);
buf b7(sum[11],1'b0);

endmodule


module eightbitcomparison(input [7:0] a,input [7:0] b,output [7:0] out);
xor x1[7:0](out,a,b);
endmodule




module ArithMeticAndLogicalUnit(input [26:0] instruction,output [11:0] result);
    wire [2:0] opcode=instruction[26:24];
    wire [11:0] a=instruction[23:12];
    wire [11:0] b=instruction[11:0];
    wire [7:0] sel;
    decoder dec1(opcode,sel);
    wire [11:0] intadder;
    wire ov1;
    //a,b, cin, sum,cout,overflow,sign
    wire cout1;
    CLA8 add1(a[7:0],b[7:0],1'b0,intadder[7:0],cout1,ov1,1'b0);
    buf b1[3:0] (intadder[11:8],1'b0);
    wire [11:0] intsubtractor;
    wire ov2;
    wire cout2;
    CLA8 sub1(a[7:0],b[7:0],1'b1,intsubtractor[7:0],cout2,ov2,1'b0);
    buf b2[3:0] (intsubtractor[11:8],1'b0);
    wire [15:0] unsignedmultiplication;
    wire ov3;
    eightbitmultiplicationunsigned mult1(a[7:0],b[7:0],unsignedmultiplication[15:0],ov3);
    wire [11:0] multunsignedoutput;
    buf b3[3:0] (multunsignedoutput[11:8],1'b0);
    buf b4[7:0] (multunsignedoutput[7:0],unsignedmultiplication[7:0]);
    wire [15:0] signedmultiplication;
    wire ov4;
    eightbitmultiplicationsigned mult2(a[7:0],b[7:0],signedmultiplication[15:0],ov4);
    wire [11:0] multsignedoutput;
    buf b5[3:0] (multsignedoutput[11:8],1'b0);
    buf b6[7:0] (multsignedoutput[7:0],signedmultiplication[7:0]);

    // 12 bit floating pt addition 
    wire [11:0] floataddition;
    float_addition_12_bit floatadd1(a,b,floataddition[11:0]);

    wire [11:0]floatmultiplication;
    wire ov11;
    floatmul floatmult1(a,b,floatmultiplication[11:0],ov11);

    //8 bit comparison 
    wire [11:0] comparator_output;
    eightbitcomparison compi1(a[7:0],b[7:0],comparator_output[7:0]);
    buf b10[3:0](comparator_output[11:8],1'b0);
    wire [11:0] select0, select1, select2, select3, select4, select5, select6, select7, select_adder;
    buf b00[11:0] (select0, sel[0]);
    buf b01[11:0] (select1, sel[1]);
    buf b02[11:0] (select2, sel[2]);
    buf b03[11:0] (select3, sel[3]);
    buf b04[11:0] (select4, sel[4]);
    buf b05[11:0] (select5, sel[5]);
    buf b06[11:0] (select6, sel[6]);
    buf b07[11:0] (select7, sel[7]);
    wire [11:0] op1, op2, op3, op4, op5, op6, op7;
    and and0[11:0] (op1, intadder, select1);
    and and1[11:0] (op2, intsubtractor, select2);
    and and2[11:0] (op3, multunsignedoutput, select3);
    and and3[11:0] (op4, multsignedoutput, select4);
    and and4[11:0] (op5, floataddition, select5);
    and and5[11:0] (op6, floatmultiplication, select6);
    and and6[11:0] (op7, comparator_output, select7);
    
    or or1[11:0] (result, op1, op2, op3, op4, op5, op6, op7);
endmodule










