#include "types.h"

#ifndef _PROCESSOR_H_
#define _PROCESSOR_H_
bool isDelimiter(char c);
string getNextToken(int index, string buffer);
void process(string buffer);
#endif