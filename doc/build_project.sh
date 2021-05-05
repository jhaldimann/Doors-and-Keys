makeglossaries Doors_And_Keys_gassm4_haldj4.tex;
pdflatex Doors_And_Keys_gassm4_haldj4.tex;
pandoc Doors_And_Keys_gassm4_haldj4.tex -o Doors_And_Keys_gassm4_haldj4.docx
echo "Words counted: ";
ps2ascii Doors_And_Keys_gassm4_haldj4.pdf | wc -w;
