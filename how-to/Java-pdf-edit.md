Download PDFTron

https://www.pdftron.com/documentation/java/download/windows/
https://www.pdftron.com/downloads/PDFNetJava.zip

Extract
```bash
# Must have dll/so available
export LD_LIBRARY_PATH=$PDFTRON/PdfNetJava/Lib/
scala -classpath $PDFTRON/PdfNetJava/Lib/PDFNet.jar
```

https://www.pdftron.com/api/PDFTronSDK/java/com/pdftron/pdf/package-summary.html

```scala
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import com.pdftron.common.Matrix2D;
import com.pdftron.common.PDFNetException;
import com.pdftron.pdf._;
import com.pdftron.sdf.SDFDoc;
import com.pdftron.sdf.ObjSet;
import com.pdftron.sdf.Obj;

class PdfWorker  {
  def run (inpath: String): Unit = {
     PDFNet.initialize();
    printf("infile %s\n", infile.getAbsolutePath)

    var doc = new PDFDoc(infile.getAbsolutePath)
    // doc.initSecurityHandler(); // makes value not appear until textfield is clicked
    /* For images cf. https://www.pdftron.com/documentation/samples/java/AddImageTest */
    var builder = new ElementBuilder
    var writer = new ElementWriter
    writer.begin(doc.getPage(1))
    var img :Image = null
    var element :Element = null
    /* Add JPG */
    img = Image.create(doc.getSDFDoc(), "Pictures/rot.jpg")
    element = builder.createImage(img, 50, 200, 400, 400);
    var sdfObj :com.pdftron.sdf.Obj = element.getXObject
    sdfObj.putString("T", "mimg title")
    writer.writePlacedElement(element)
    /* Add PNG */
    img = Image.create(doc.getSDFDoc(), "Pictures/screenshot.png")
    element = builder.createImage(img, 100, 100, 300, 500)
    element.getXObject.putString("T", "pngtitle")
    writer.writePlacedElement(element)
    writer.end()

    /* For inputs, cf. InteractiveFormsTest.java*/
    var iter = doc.getFieldIterator
    while (iter.hasNext) {
      var field = iter.next
      if (field.getType == Field.e_text) {
        field.rename("ice cream")
        var obj = field.getSDFObj.findObj("V")
        println("got text")
        field.setValue("hooray for tons of choco")
      } else if (field.getType == Field.e_check) {
        field.rename("choco chips")
        println("got check")
        field.setValue("Yes")
      } else {
        printf("got %s\n", field.getType)
      }
    }


    doc.save(new FileOutputStream("out.pdf"), SDFDoc.SaveMode.NO_FLAGS, null);

    println("saved")
    doc.close
    PDFNet.terminate();
  }
}
```
