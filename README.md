# PDFtk dockerben

A `pdftk` egy pdf fájlok manipulálására alkalmas program.

 - Weboldal: https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/
 - Manual: https://www.pdflabs.com/docs/pdftk-man-page/ 
 - Példák: https://www.pdflabs.com/docs/pdftk-cli-examples/

## TLDR;

Build, Alias és Futtatás

```bash
docker build -t rcsnjszg/pdftk -f Dockerfile  .
alias pdftk="docker run --rm -v $(pwd):/app rcsnjszg/pdftk"
pdftk README.pdf dump_data | grep NumberOfPages | awk '{print $2}'
```

## Build

A `Dockerfile` fordítását a `Makefile` teszi egyszerűvé.

Megfelelő környezetben elegendő a `make` parancsot kiadni a docker image buildeléséhez.

```bash
make
```

Amennyiben nem áll rendelkezésre, úgy az alábbi sor futtatásával lehet buildelni:

```bash
docker build -t rcsnjszg/pdftk -f Dockerfile  .
```

## Futtatás


A fájlt tesztelni az alábbi parancs kiadásával lehet:

```bash
docker run --rm -v $(pwd):/app rcsnjszg/pdftk README.pdf dump_data
```

A `docker run` a megadott imageből (`rcsnjszg/pdftk`) létrehoz egy konténert, majd a `Dockerfileban` megadott belépési pontotban (`ENTRYPOINT ["pdftk"]`) meghatározott parancsot indítja el, jelen esetben a `pdftk`-t. Ennek az első paramétere a fájl neve (`README.pdf`) lesz. A `dump_data` hatására a pdf fájlról jelenít meg információkat.

 - A `--rm` miatt a docker konténer törlésre kerül a parancs lefuttatása után, mondhatni tiszavirág életű

 - A `-v` határozza meg, hogy a konténerhez melyik mappát kell felcsatolni
    - A `$(pwd)` az aktuális mappát (Path Working Directory) takarja a hoszt gépen
    - A `/app` a konténeren belüli helyet jelöli

## Alias

Ezek után célszerű lehet egy aliast létrehozni a könnyebb kezelhetőség kedvéért.
Ehhez kezdetként a projekt mappába kell navigálni, hogy az abban található fájlokat lehessen majd futtatni a `pdftk` által.

```bash
cd projekt
```

Az alias parancs felparaméterezése:

```bash
alias pdftk="docker run --rm -v $(pwd):/app rcsnjszg/pdftk"
```

Innentől kezdve a `pdftk` használható lesz az adott shellben, de csak az azott mappában működik helyesen!

Például:

```bash
pdftk README.pdf dump_data
```

A fenti kód eredményeként megjelennek az adott fájlból kinyert információk.