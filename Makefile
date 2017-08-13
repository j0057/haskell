
tests: \
    test-folds.py \
    test-ch03.hs \
    test-ch03

ch03: ch03.hs
	ghc -dynamic -O -o $@ $?

test-%: %
	./$<

clean:
	@rm -fv *.o
	@rm -fv *.hi
	@rm -fv ch03
