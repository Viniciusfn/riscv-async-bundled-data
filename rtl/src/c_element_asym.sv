module c_element_asym #(
   parameter bit INIT = 0 //Init. value: 1 = set; 0 = reset
)(
   input  logic a, // strong input
   input  logic b, // weak input
   input  logic rst_n,
   output logic s
);

   `ifndef SYNTHESIS
   always @* begin
      if (!rst_n) begin
         s = INIT;
      end
      else begin
         case ({a,b})
            2'b00:        s = 1'b0;
            2'b10, 2'b11: s = 1'b1;
            default:      s = s;
         endcase
      end
   end

   `else
   wire n1,n2,n3,i1,i2,i3;

   NAND2X6 NAND2_1_DONT_TOUCH(
      .A(a),
      .B(b),
      .Y(n1)
   );

   NAND2X6 NAND2_2_DONT_TOUCH(
      .A(a),
      .B(s),
      .Y(n2)
   );

   NAND2X6 NAND2_3_DONT_TOUCH(
      .A(b),
      .B(s),
      .Y(n3)
   );

   NAND3X4 NAND3_1_DONT_TOUCH(
      .A(n1),
      .B(n2),
      .C(n3),
      .Y(i1)
   );

   OR2X6 OR2_1_DONT_TOUCH(
      .A(a),
      .B(i1),
      .Y(i3)
   );

   generate if (INIT == 1) begin

      INVX8 INV_1_DONT_TOUCH(
         .A(rst_n),
         .Y(i2)
      );

      OR2X8 DRV_DONT_TOUCH(
         .A(i3),
         .B(i2),
         .Y(s)
      );
   
   end else begin
   
      AND2X8 DRV_DONT_TOUCH(
         .A(i3),
         .B(rst_n),
         .Y(s)
      );
   
   end endgenerate

   `endif

endmodule
