class A inherits B {  -- A наследует B
    -- Код класса A
};

class B inherits C {  -- B наследует C
    -- Код класса B
};

class C inherits A {  -- C наследует A → цикл (A → B → C → A)
    -- Код класса C
};

class Main {
    main() : Object {
        new A  -- Создаем объект A (но из-за цикла это невозможно)
    };
};