~class Main inherits IO {
 main() : Object {
-- comment (*arabi abudabi (*arabi ne v abudabi*) mdam *)
(*
comment 
commit
*)

(* Abc (* *) -- dfs
-- comm
*)

(*
* Example app.
*
*)
"

"String  hello"
"str"

"abudabi ne \
arabi"

"Hello\n"

bool
class P {
f(): Int { 1 };
};
class C inherits P {
f(): String { "1" };
};


(*arabi abudabi (*arabi ne v abudabi*) mdam *)
 -- Объявление переменных всех типов
            let x : Int <- 10,
                y : Int <- 5,
                z : Int,
                flag : Bool <- true,
                message : String <- "Результат: ",
                i : Int <- 0
            in
                {
                    -- Условный оператор if
                    if flag then
                        {
                            -- Арифметические операции
                            z <- x + y;
                            out_string(message).out_int(z).out_string("\n");  -- Вывод: Результат: 15

                            z <- x - y;
                            out_string(message).out_int(z).out_string("\n");  -- Вывод: Результат: 5

                            z <- x * y;
                            out_string(message).out_int(z).out_string("\n");  -- Вывод: Результат: 50

                            z <- x / y;
                            out_string(message).out_int(z).out_string("\n");  -- Вывод: Результат: 2
                        }
                    else
                        out_string("Флаг false, вычисления не выполнены.\n")
                    fi;

                    -- Цикл while
                    while i < 5 loop
                        {
                            out_string("Итерация: ").out_int(i).out_string("\n");
                            i <- i + 1;
                        }
                    pool;

                    -- Логические операции
                    if x = 10 and y = 5 then
                        out_string("x = 10 и y = 5\n")  -- Вывод: x = 10 и y = 5
                    else
                        out_string("Условие не выполнено\n")
                    fi;

                    if not flag then
                        out_string("Флаг false\n")
                    else
                        out_string("Флаг true\n")  -- Вывод: Флаг true
                    fi;
                };
        }
    };
};