class Main {
    main(): Object {
        (new IO).out_string("Check params uniqueness!\n")
    };

    -- ОШИБКА: Два параметра с именем 'x'
    sum(x: Int, x: Int): Int {  
        x + x  -- Какой 'x' использовать? Компилятор не знает!
    };
};
