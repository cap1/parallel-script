DIRS= `find -maxdepth 1  -type d ! -wholename \*.svn\* | grep /`
PDF = $(addsuffix .pdf, $(basename $(wildcard *.eps)))

show: all

all: $(PDF) $(GNUPLOT) $(INKSCAPE) 
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	bibtex ./tmp/parallel-script
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	cp ./tmp/parallel-script.pdf .
	mv ./tmp/parallel-script.pdf ~/Dropbox/uni/Parallel\ Computing/Parallel-Script.pdf

nobib:
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	cp ./tmp/parallel-script.pdf .
	mv ./tmp/parallel-script.pdf ..

evince:
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	bibtex ./tmp/parallel-script
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	mv ./tmp/parallel-script.pdf .
	evince parallel-script.pdf &> /dev/null

okular:
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	bibtex ./tmp/parallel-script
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	pdflatex --halt-on-error --output-directory=./tmp ./parallel-script.tex
	mv ./tmp/parallel-script.pdf .
	okular ./parallel-script.pdf 2> /dev/null

prepare:
	mkdir tmp

%.pdf: %.eps
	epstopdf $(basename $@).eps

clean:
	-rm -f ./tmp/*.bak ./tmp/*.aux ./tmp/*.log ./tmp/*.toc ./tmp/*.out ./tmp/*.nav ./tmp/*.snm ./tmp/*.bbl ./tmp/*.blg
	-rm -f ./tmp/*~	
	-rm -f ./tmp/*.pdf
	-rm -f *.pdf

all-evince: show
