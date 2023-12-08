# run_all.sh
# Tiffany Timbers, Nov 2018

# This driver script completes the textual analysis of
# 3 novels and creates figures on the 10 most frequently
# occuring words from each of the 3 novels. This script
# takes no arguments.

# example usage:
# bash run_all.sh

# count the words

all: report/_build/html/index.html

results/isles.dat: data/isles.txt
	python scripts/wordcount.py --input_file=data/isles.txt --output_file=results/isles.dat

results/abyss.dat: data/abyss.txt
	python scripts/wordcount.py --input_file=data/abyss.txt --output_file=results/abyss.dat

results/last.dat: data/last.txt
	python scripts/wordcount.py --input_file=data/last.txt --output_file=results/last.dat

results/sierra.dat: data/sierra.txt
	python scripts/wordcount.py --input_file=data/sierra.txt --output_file=results/sierra.dat


# create the plots
results/figure/isles.png: results/isles.dat
	python scripts/plotcount.py --input_file=results/isles.dat --output_file=results/figure/isles.png
results/figure/abyss.png: results/abyss.dat
	python scripts/plotcount.py --input_file=results/abyss.dat --output_file=results/figure/abyss.png

results/figure/last.png: results/last.dat
	python scripts/plotcount.py --input_file=results/last.dat --output_file=results/figure/last.png
results/figure/sierra.png: results/sierra.dat
	python scripts/plotcount.py --input_file=results/sierra.dat --output_file=results/figure/sierra.png

report/_build/html/index.html: results/figure/isles.png \
results/figure/abyss.png \
results/figure/last.png \
results/figure/sierra.png
	jupyter-book build report

clean:
	rm -rf results/*.dat results/figure/*.png report/_build
