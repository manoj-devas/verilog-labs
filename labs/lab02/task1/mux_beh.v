// mux_beh.v
// 2-to-1 multiplexer, BEHAVIORAL style.
//
// This file does not compile as-is. Find the bug and fix it before moving on.
// Hint: think carefully about which port should be a net and which should be
// a variable in behavioral modeling.

module mux_beh (
  input       I0,
  input       I1,
  input       S,
  output  reg Y
);

  always @(*) begin
    if (S) begin
      Y = I1;
    end else begin 
      Y = I0;
    end
    
  end

endmodule
