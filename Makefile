# Makefile 2024-06-13

GITDIR=~/git
SRCDIR=$(GITDIR)/SynEpis
PAPDIR=$(GITDIR)/www.rbjones.com/src/rbjpub/www/papers

PAPDIRTEXS=p035.tex
LUALATEXS=part1.tex notes.tex
CONTEXTS=LogKb.tex
TEXS=intro6.tex intro7.tex Varepis.tex LogicalTruth.tex kernel.tex

PAPPDFS=$(PAPDIRTEXS:.tex=.pdf) 
LUAPDFS=$(LUALATEXS:.tex=.pdf) 
CONTEXTPDFS=$(CONTEXTS:.tex=.pdf)

BIBFILES=rbj3.bib rbjfmu.bst

SRCDIRCPY=$(TEXS) $(LUALATEXS) $(CONTEXTS) $(BIBFILES) Makefile
PAPDIRCPY=$(PAPDIRTEXS)

all: $(LUAPDFS)

*.bbl:	%.tex rbj3.bib
	bibtex %.tex

bdir:
	@-mkdir $(GITDIR)/SynEpisBuild
	cp Makefile $(GITDIR)/SynEpisBuild

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
