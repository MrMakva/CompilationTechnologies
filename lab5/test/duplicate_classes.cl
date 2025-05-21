-- Класс "Main"
class Main {
    main(): Object {
        (new IO).out_string("Hello, world!\n")
    };
};

-- Повторное объявление класса "Main" (ошибка!)
class Main {
    foo(): Int {
        42
    };
};
