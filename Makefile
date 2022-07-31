NAME = rcsnjszg/pdftk
HIGHLIGHT_STYLE = zenburn

.PHONY: build readme

build:
	docker build -t $(NAME) -f Dockerfile  .
readme:
	pandoc README.md -o README.pdf --highlight-style=$(HIGHLIGHT_STYLE)
default: build
