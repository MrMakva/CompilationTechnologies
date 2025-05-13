class Main inherits IO {
    x : Int <- 10;
    y : Int <- 9;
    z : String <- "Hello";
    flag : Bool <- true;

    main() : Int {
        {
            out_string("Calculating...\n");
            x / y;
        }
    };

    double(num : Int) : Int {
        num * 2
    };

    sum(a : Int, b : Int, c : Int) : Int {
        a + b + c
    };

    test_expressions() : Object {
        {
            let x : Int <- 5 in {
                out_string("x = ").out_int(x).out_string("\n");
            };

            -- Условное выражение
            if flag then
                out_string("Flag is true\n")
            else
                out_string("Flag is false\n")
            fi;

            -- Цикл
            while x < 20 loop
                x <- x + 1
            pool;

            -- Блок выражений
            {
                out_int(x);
                out_string("\n");
            };
        }
    };
};

class Child inherits Main {
    new_method() : String {
        z.concat(" World!")
    };
};

class Helper {
    help() : Object {
        (new IO).out_string("Helping!\n")
    };
};