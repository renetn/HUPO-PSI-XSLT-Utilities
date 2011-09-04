DATE :
2003/05/22

DESCRIPTION :
The package contains a folder src with eight stylesheets :

- MIFn_to_CSVn.xsl : transformation MIFn->CSV
- DIP_to_MIFn.xsl : transformation DIP->MIFn
- DIP_to_MIFn_report.xsl : verification of data's integrity after a DIP_to_MIFn transformation.
- MIF_fold.xsl : transformation denormalized->normalized
- MIF_unfold.xsl : transformation normalized->denormalized
- MIF_normalisedFormTester.xsl : verify if the file has a normalized form.
- MIF_denormalisedFormTester.xsl : verify if the file has a denormalized form.
- MIF_view.xsl : its role is to permit to view a MFI normalized file.

In order to use thoses tools, you need to install a XSL processor.

For example, you can find the libxml library which eprmit to install the xsltproc processor and to use at www.xmlsoft.org .

usage for each tools :

xsltproc -o result tool.xsl input_file.xml

AUTHORS :
CEZANNE Emmanuel, EVEN Claire, ROUMEGOUS Christophe, JOLIBERT Nicolas, THOMAS-NELSON Rene, MARQUES Sandrine, CROS Sebastien, SABLAYROLLES Patrick 
at the ENSEIRB (www.enseirb.fr)       
 


