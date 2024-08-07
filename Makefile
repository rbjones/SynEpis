# Makefile 2024-06-13

SRCDIR=~/git/SynEpis
PAPDIR=~/git/www.rbjones.com/src/rbjpub/www/papers

PAPDIRTEXS=p035.tex
LUALATEXS=part1.tex
CONTEXTS=LogKb.tex
TEXS=intro2.tex varepis.tex LogicalTruth.tex

PAPPDFS=$(PAPDIRTEXS:.tex=.pdf) 
LUAPDFS=$(LUALATEXS:.tex=.pdf) 
CONTEXTPDFS=$(CONTEXTS:.tex=.pdf)

BIBFILES=rbj3.bib rbjfmu.bst

SRCDIRCPY=$(TEXS) $(LUALATEXS) $(CONTEXTS) $(BIBFILES) Makefile
PAPDIRCPY=p035.tex

bdir:
	-mkdir ../SynEpisBuild
	cp Makefile ../SynEpisBuild

$(PAPPDFS): %.pdf: %.tex $(BIBFILES) Makefile
	lualatex $<
	-bibtex $*
	lualatex $<

$(LUAPDFS): %.pdf: %.tex $(TEXS) $(BIBFILES) Makefile
	lualatex $<
	-bibtex $*
	lualatex $<

$(CONTEXTPDFS): %.pdf: %.tex $(TEXS) $(BIBFILES) Makefile
	context $<
	bibtex $*
	context $<

$(SRCDIRCPY): %: $(SRCDIR)/%
	cp $(SRCDIR)/$@ .

$(PAPDIRCPY): %: $(PAPDIR)/%
	cp $(PAPDIR)/$@ .
