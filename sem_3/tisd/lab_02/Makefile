TARGET = main.out
HDRS_DIR = lab_02

SRCS =  lab_02/main.cpp 
	

.PHONY: all clean

all: $(SRCS)
	g++ -Wall -Werror -I $(HDRS_DIR) -o $(TARGET) $(CPPFLAGS) $(SRCS)


clean:
	rm -rf $(TARGET)
