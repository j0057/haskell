tests: \
	test-folds.py \
	test-rwh03

all-tests: tests \
	test-RWH03.hs

rwh03: RWH03.hs
	ghc -dynamic -main-is RWH03 -package HUnit -o $@ -O1 $?

test-%: %
	./$<

clean:
	@rm -fv *.o
	@rm -fv *.hi
	@rm -fv rwh03
