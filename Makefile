tests: \
	.folds.py.txt \
	.rwh00.txt \
	.rwh01.txt \
	.rwh02.txt \
	.rwh03.txt

all-tests: tests \
	.RWH00.hs.txt \
	.RWH01.hs.txt \
	.RWH02.hs.txt \
	.RWH03.hs.txt

rwh00: RWH00.hs
	ghc -dynamic -main-is RWH00 -package HUnit -o $@ -O1 $?

rwh01: RWH01.hs
	ghc -dynamic -main-is RWH01 -package HUnit -o $@ -O1 $?

rwh02: RWH02.hs
	ghc -dynamic -main-is RWH02 -package HUnit -o $@ -O1 $? -fprint-potential-instances

rwh03: RWH03.hs
	ghc -dynamic -main-is RWH03 -package HUnit -o $@ -O1 $?

.%.txt: %
	./$< |& tee $@

clean:
	@rm -fv *.o
	@rm -fv *.hi
	@rm -fv .*.txt
	@rm -fv rwh??
