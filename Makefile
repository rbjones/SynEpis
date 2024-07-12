LUALATEXS=part1.tex
CONTEXTS=LogKb.tex
TEXS=introduction.tex varepis.tex

LUAPDFS=$(LUALATEXS:.tex=.pdf)
CONTEXTPDFS=$(CONTEXTS:.tex=.pdf)

BIBFILES=rbj3.bib rbjfmu.bst

$(LUAPDFS): %.pdf: %.tex $(TEXS) $(BIBFILES)
	bibtex $*
	lualatex $<

$(CONTEXTPDFS): %.pdf: %.tex $(TEXS) $(BIBFILES)
	context $<
	bibtex $*
	context $<

