module tb;
  
   reg [1:0] t_a, t_b;
   wire t_GT,t_LT,t_EQ;


   integer a,b;
   integer errors;

   comp2 DUT(
    .A(t_a),
    .B(t_b),
    .GT(t_GT),
    .LT(t_LT),
    .EQ(t_EQ)
   );

   initial begin
    errors = 0;
    for(a=0;a<4; a=a+1) begin
        for(b=0;b<4; b=b+1) begin
            t_a = a;
            t_b = b;
        
        #1;

        if((t_GT !== (t_a>t_b)) ||
        (t_LT !== (t_a < t_b))  ||
        (t_EQ !== (t_a ==t_b ))) begin
            errors = errors +1;
            $display(
                        "FAIL A=%0d B=%0d: got GT,LT,EQ=%b%b%b expected=%b%b%b",
                        t_a, t_b,
                        t_GT, t_LT, t_EQ,
                        (t_a > t_b), (t_a < t_b), (t_a == t_b)
                    );
                end
            end
        end

        if (errors == 0)
            $display("PASS: all 16 combinations passed.");
        else
            $display("FAIL: %0d of 16 combinations failed.", errors);

        $finish;
    end

endmodule