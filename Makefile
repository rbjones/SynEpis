# Makefile 2024-06-13

GITDIR=../
SRCDIR=$(GITDIR)/SynEpis
ARCHDIR=$(SRCDIR)/arch
PAPDIR=$(GITDIR)/www.rbjones.com/src/rbjpub/www/papers

TXTS=
PAPDIRTEXS=p035.tex
LUALATEXS=notes.tex arch.tex forgrok02.tex
LUABLATEXS=part1.tex
CONTEXTS=LogKb.tex
ATEXS=  intro2.tex
TEXS=	introduction.tex intro3.tex intro4.tex intro5.tex \
	intro6.tex intro7.tex intro8.tex intro9.tex intro10.tex \
	intro11.tex intro12.tex intro13.tex intro14.tex intro15.tex\
	varepis.tex LogicalTruth.tex LogTruth01.tex \
	epistem01.tex \
	edk01.tex edk02.tex \
	kernel.tex kernel2.tex kernel3.tex kernel4.tex kernel5.tex \
	ftt01.tex \
	carnap01.tex \
	grok3in.tex \
	holdetails.tex \
	unilog01.tex
MDS=CONTRIBUTING.md

PAPPDFS=$(PAPDIRTEXS:.tex=.pdf) 
LUAPDFS=$(LUALATEXS:.tex=.pdf) 
LUABPDFS=$(LUABLATEXS:.tex=.pdf) 
CONTEXTPDFS=$(CONTEXTS:.tex=.pdf)

BIBFILES=rbj3.bib rbj4.bib rbj5.bib rbjfmu.bst

SRCDIRCPY=$(CONTEXTS) $(BIBFILES) $(LUALATEXS)  $(LUABLATEXS) $(PDFLATEXS) $(MDS) $(TEXS) $(TXTS) Makefile
PAPDIRCPY=$(PAPDIRTEXS)

all: $(PDFS) $(LUAPDFS)

*.bbl:	%.tex rbj3.bib
	bibtex %.tex

bdir:
	@mkdir $(GITDIR)/SynEpisBuild
	cp Makefile $(GITDIR)/SynEpisBuild

$(PAPPDFS): %.pdf: %.tex $(BIBFILES) Makefile
	lualatex $<
	bibtex $*
	makeindex $*
	lualatex $<

$(LUABPDFS): %.pdf: %.tex $(TEXS) rbj4.bib $(MDS) Makefile
	lualatex $<
	biber $*
	makeindex $*
	lualatex $<

$(LUAPDFS): %.pdf: %.tex $(TEXS) rbj3.bib rbjfmu.bst $(MDS) Makefile
	lualatex $<
	bibtex $*
	makeindex $*
	lualatex $<

$(CONTEXTPDFS): %.pdf: %.tex $(TEXS) $(BIBFILES) Makefile
	context $<
	bibtex $*
	context $<

$(SRCDIRCPY): %: $(SRCDIR)/%
	cp $(SRCDIR)/$@ .

$(PAPDIRCPY): %: $(PAPDIR)/%
	cp $(PAPDIR)/$@ .
