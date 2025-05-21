class A inherits Object {
    -- Простой класс, корректно наследуется от Object
};

class C inherits B {
    -- ОШИБКА: класс B не существует, поэтому нет пути к Object
    -- Это нарушает правило "существования всех классов предков"
};

class Main {
    main() : Object {
        new A
    };
};