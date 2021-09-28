PROJECT_ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
CFLAGS=-std=c11 -g -static
SRCS=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)

9cc: $(OBJS)
	$(CC) -o 9cc $(OBJS) $(LDFLAGS)

$(OBJS): 9cc.h

go-test: 9cc
	./test.sh

go-clean:
	rm -f 9cc *.o *~ tmp*

go:
	docker run --rm -w /9cc -it -v $(PROJECT_ROOT):/9cc compilerbook

test:
	docker run --rm  -w /9cc -v $(PROJECT_ROOT):/9cc compilerbook make go-test

clean:
	docker run --rm  -w /9cc -v $(PROJECT_ROOT):/9cc compilerbook make go-clean

.PHONY: go test clean
