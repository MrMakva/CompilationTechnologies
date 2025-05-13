// parser-phase.cc
#include "cool-parse.h"
#include "cool-tree.h"
#include "utilities.h"
#include <cstdio>
#include <unistd.h>

std::FILE *token_file = stdin;
extern Classes parse_results;
extern Program ast_root;

extern int curr_lineno;
const char *curr_filename = "<stdin>";
extern int parse_errors;

// Debug flags
extern int yy_flex_debug;
extern int cool_yydebug;
int lex_verbose = 0;

extern int cool_yyparse();

void print_symbol_tables() {
  std::cerr << "\n===== Symbol Tables =====\n";
  std::cerr << "\nIdentifier Table:\n";
  idtable.print();
  std::cerr << "\nInteger Table:\n";
  inttable.print();
  std::cerr << "\nString Table:\n";
  stringtable.print();
}

int main(int argc, char **argv) {
  yy_flex_debug = 0;
  cool_yydebug = 0;
  lex_verbose = 0;

  for (int i = 1; i < argc; i++) {
    token_file = std::fopen(argv[i], "r");
    if (token_file == NULL) {
      std::cerr << "Error: can not open file " << argv[i] << std::endl;
      std::exit(1);
    }
    curr_lineno = 1;

    cool_yyparse();
    if (parse_errors != 0) {
      std::cerr << "Error: parse errors\n";
      std::exit(1);
    }

    // Dump AST
    std::cerr << "\n===== Abstract Syntax Tree =====\n";
    ast_root->dump_with_types(std::cerr, 0);

    // Print symbol tables
    print_symbol_tables();

    std::fclose(token_file);
  }

  return 0;
}