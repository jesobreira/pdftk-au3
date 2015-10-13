# PDFTK wrapper for AutoIt3

This is a PDFTK Server wrapper for AutoIt3.

PDFTK Server is the command line part of [PDFtk](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/). With this lib, you don't need to worry about telling your user to install PDFtk. It comes with it bound, extracts to temp dir once the class is used and then removes it.

PDFtk is a powerful tool to manipulate PDF files. You can merge them in many ways, use a PDF as background of another and many other things. Using this lib together with [wkhtmltox-au3](http://github.com/jesobreira/wkhtmltox-au3), you can do really very amazing things with PDF on your applications!

So far, however, this lib is not fully implemented. You can already use it, but all it can do is querying directly to the EXE files (you must just pass the arguments - learn about them [here](https://www.pdflabs.com/docs/pdftk-man-page/) and [here](https://www.pdflabs.com/docs/pdftk-cli-examples/)).

There is a working example on example.au3 file which applies a background (letterhead.pdf) into a text PDF (test.pdf) and outputs it into done.pdf.

I plan to make things better. As now, instead of telling your user to download and install PDFtk and then directly querying that file, you just use New_PDFTK.Cmd() method. But in future versions, instead of just that method, there will be many methods for the functionalities that PDFtk has.

Want to make things better too? Feel free to pull request :)
