# Title: C makefile
# Author: ***REMOVED***
# About: Builds C applications and runs them.
# Dependencies: Any UNIX system or Cygwin for Windows
# with make installed.
# Usage: make

#============================
# Begin Options
#============================

# The compiler to use.
COMPILER=gcc
# Any compiler flag sto use
.COMPILER_FLAGS=
# The name of the program.
PROGRAM=bin/espresso
#The name of the includes folder.
INCLUDES_FOLDER=include
# The name of the library folder.
LIBRARY_FOLDER=lib
# The names of all library source files you will need.
LIBRARY_SOURCES=mem.c linkedlist.c tree.c
# The name of the source folder.
SOURCE_FOLDER=src
# The names of all the source files you will need. These must be
# in order of dependency. These should be comma-delimited.
SOURCES=bootstrap.c keys.c parser.c processor.c espresso.c
# The list of files to remove for cleanup. By default these are
# the object files generated by your compiler.
CLEANUP=*.o
# Whether or not to execute the program.
EXEC=FALSE
# Any execution arguments.
EXEC_ARGS="test/hello world.esp"
# Whether or not to Valgrind the application.
# Only use this on a UNIX system with Valgrind installed.
VALGRIND=FALSE
# Any Valgrind flags to use.
VALGRIND_FLAGS=
# For makefile debug purposes.
DEBUG=FALSE

#============================
# End Options
#============================

ALL_SOURCES=$(LIBRARY_SOURCES) $(SOURCES)
OBJECTS=$(ALL_SOURCES:.c=.o)

SOURCES_LINKED=$(SOURCES:%.c=$(SOURCE_FOLDER)/%.c)
LIBRARY_SOURCES_LINKED=$(LIBRARY_SOURCES:%.c=$(LIBRARY_FOLDER)/%.c)
ALL_SOURCES_LINKED = $(LIBRARY_SOURCES_LINKED) $(SOURCES_LINKED)

ifeq ($(DEBUG), FALSE)
	SUPPRESS=@
else
	SUPPRESS=
endif

MAKE: SETUP COMPILE $(PROGRAM) CLEAN EXECUTE

EXECUTE:
ifeq ($(EXEC), TRUE)
	@echo 'Executing <$(PROGRAM)>:'
	@echo ''
ifeq ($(VALGRIND), TRUE)
	$(SUPPRESS)valgrind $(VALGRIND_FLAGS) ./$(PROGRAM) $(EXEC_ARGS)
else
	$(SUPPRESS)./$(PROGRAM) $(EXEC_ARGS)
endif
endif

CLEAN:
	@echo 'Cleaning up'
	$(SUPPRESS)rm -rf $(CLEANUP)

$(PROGRAM): $(OBJECTS)
	@echo 'Compiling <$(OBJECTS)>'
	$(SUPPRESS)$(COMPILER) -I $(INCLUDES_FOLDER) $(COMPILER_FLAGS) $(OBJECTS) -o $(PROGRAM)

COMPILE: $(SOURCES_LINKED)
	@echo 'Compiling <$(SOURCES)>'
	$(SUPPRESS)$(COMPILER) -I $(INCLUDES_FOLDER) -c $(COMPILER_FLAGS) $(ALL_SOURCES_LINKED)

SETUP:
	@# Reserved for any future commands.
