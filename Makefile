tests: \
	test-folds.py \
	test-rwh01 \
	test-rwh03

all-tests: tests \
	test-RWH01.hs \
	test-RWH03.hs

rwh01: RWH01.hs
	ghc -dynamic -main-is RWH01 -package HUnit -o $@ -O1 $?

rwh03: RWH03.hs
	ghc -dynamic -main-is RWH03 -package HUnit -o $@ -O1 $?

test-%: %
	./$<

clean:
	@rm -fv *.o
	@rm -fv *.hi
	@rm -fv rwh03
