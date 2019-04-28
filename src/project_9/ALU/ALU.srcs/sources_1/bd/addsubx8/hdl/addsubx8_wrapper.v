//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Sun Apr 28 20:50:12 2019
//Host        : DESKTOP-RTRUIMN running 64-bit major release  (build 9200)
//Command     : generate_target addsubx8_wrapper.bd
//Design      : addsubx8_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module addsubx8_wrapper
   (a,
    b,
    cf,
    ovf,
    sf,
    sub,
    sum,
    zf);
  input [7:0]a;
  input [7:0]b;
  output cf;
  output ovf;
  output sf;
  input sub;
  output [7:0]sum;
  output zf;
  
  wire [7:0]a;
  wire [7:0]b;
  wire cf;
  wire ovf;
  wire sf;
  wire sub;
  wire [7:0]sum;
  wire zf;
  addsubx8 addsubx8_i
       (.a(a),
        .b(b),
        .cf(cf),
        .ovf(ovf),
        .sf(sf),
        .sub(sub),
        .sum(sum),
        .zf(zf));
endmodule
