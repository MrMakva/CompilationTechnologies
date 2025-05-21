class A {
    x : Int <- 42;  -- Атрибут типа Int
};

class B inherits A {
    -- Пустой класс, наследует x : Int
};

class Main {
    main() : Object {
        let
            a : A <- new A,  -- Создаем объект A
            b : B <- new B   -- Создаем объект B
        in {
            a <- b;           -- ОК: B подтип A
            b <- a;           -- ОШИБКА: A не подтип B
            1 + "Hello";      -- ОШИБКА: сложение Int и String
            2.fun();          -- ОШИБКА: метод fun() не объявлен для Int
        }
    };
};