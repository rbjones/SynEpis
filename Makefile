# Makefile 2024-06-13

GITDIR=~/git
SRCDIR=$(GITDIR)/SynEpis
PAPDIR=$(GITDIR)/www.rbjones.com/src/rbjpub/www/papers

TXTS=
PAPDIRTEXS=p035.tex
LUALATEXS=part1.tex notes.tex arch.tex forgrok02.tex
CONTEXTS=LogKb.tex
TEXS=	introduction.tex intro2.tex intro3.tex intro4.tex intro5.tex \
	intro6.tex intro7.tex intro8.tex intro9.tex intro10.tex intro11.tex intro12.tex intro13.tex\
	Varepis.tex LogicalTruth.tex LogTruth01.tex \
	epistem01.tex \
	edk01.tex edk02.tex \
	kernel.tex kernel2.tex kernel3.tex kernel4.tex kernel5.tex \
	ftt01.tex \
	carnap01.tex \
	grok3in.tex

PAPPDFS=$(PAPDIRTEXS:.tex=.pdf) 
LUAPDFS=$(LUALATEXS:.tex=.pdf) 
CONTEXTPDFS=$(CONTEXTS:.tex=.pdf)

BIBFILES=rbj3.bib rbjfmu.bst

SRCDIRCPY=$(TEXS) $(LUALATEXS) $(CONTEXTS) $(BIBFILES) $(TXTS) Makefile
PAPDIRCPY=$(PAPDIRTEXS)

all: $(LUAPDFS)

*.bbl:	%.tex rbj3.bib
	bibtex %.tex

bdir:
	@-mkdir $(GITDIR)/SynEpisBuild
	cp Makefile $(GITDIR)/SynEpisBuild

$(PAPPDFS): %.pdf: %.tex $(BIBFILES) Makefile
	lualatex $<
	bibtex $*
	makeindex $*
	lualatex $<

$(LUAPDFS): %.pdf: %.tex $(TEXS) $(BIBFILES) Makefile
	lualatex $<
	bibtex $*
	makeindex $*
	lualatex $<

part1.pdf: grok3in.txt

$(CONTEXTPDFS): %.pdf: %.tex $(TEXS) $(BIBFILES) Makefile
	context $<
	bibtex $*
	context $<

$(SRCDIRCPY): %: $(SRCDIR)/%
	cp $(SRCDIR)/$@ .

$(PAPDIRCPY): %: $(PAPDIR)/%
	cp $(PAPDIR)/$@ .
