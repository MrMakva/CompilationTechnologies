class Main inherits IO {
    CLASS
    tRUE
    TRUE
    -- Функция, которая принимает число, строку и логическое значение, а затем выводит их
    printValues(num : Int, text : String, flag : Bool) : Object {
        {
            out_string("Number: jr ").out_int(num).out_string("\n");  -- Выводим число
            out_string("Text: ").out_string(text).out_string("\n"); -- Выводим строку
            if flag then
                out_string("Flag is true\n")                     -- Выводим, если flag = true
            else
                out_string("Flag is false\n")                    -- Выводим, если flag = false
            fi;
        }
    };    
    -- Главный метод, который вызывает функцию printValues
    main() : Object {
        {
            printValues(42, "Hello, Cool!", true);  -- Вызов функции с аргументами
        }
    };
};