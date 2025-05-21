(* Класс без метода main() - ошибка *)
class HelloWorld {
    say_hello(): Object {
        (new IO).out_string("Hello, world!\n")
    };
};
