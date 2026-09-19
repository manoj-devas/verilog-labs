module tb;

    reg  [3:0] t_a, t_b;
    reg        t_op;
    wire [3:0] t_result;

    integer errors;

    alu DUT (
        .a(t_a),
        .b(t_b),
        .op(t_op),
        .result(t_result)
    );

    // Wait for the output to settle, then check it.
    task check;
        input [3:0] expected;
        begin
            #1;

            if (t_result !== expected) begin
                errors = errors + 1;

                $display(
                    "FAIL a=%0d b=%0d op=%b: result=%b expected=%b",
                    t_a, t_b, t_op, t_result, expected
                );
            end else begin
                $display(
                    "PASS a=%0d b=%0d op=%b: result=%0d",
                    t_a, t_b, t_op, t_result
                );
            end
        end
    endtask

    initial begin
        errors = 0;

        // Establish a correct addition result.
        t_a = 9; t_b = 3; t_op = 0;
        check(4'd12);

        // Change ONLY op: result must change from 12 to 6.
        t_op = 1;
        check(4'd6);

        // Change operands while remaining in subtraction mode.
        t_a = 8; t_b = 2;
        check(4'd6);

        t_a = 7; t_b = 1;
        check(4'd6);

        t_a = 10; t_b = 4;
        check(4'd6);

        // Change ONLY op back to addition.
        t_op = 0;
        check(4'd14);

        // Check 4-bit overflow and subtraction wraparound.
        t_a = 15; t_b = 1;
        check(4'd0);

        t_a = 3; t_b = 5; t_op = 1;
        check(4'd14);

        if (errors == 0)
            $display("PASS: all 8 tests passed.");
        else
            $display("FAIL: %0d of 8 tests failed.", errors);

        $finish;
    end

endmodule