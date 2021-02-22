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
    var doc = new PDFDoc(inpath)
    var fdf = doc.fdfExtract()
    var fiter = fdf.getFieldIterator

    while (fiter.hasNext) {
      var field = fiter.next
      var obj = field.findAttribute("T")
      if (obj != null && obj.isString() && obj.getAsPDFText().startsWith("ICC")) {
          obj.setString("Barfdsay");
          println("%d %s\t%s".format(obj.getType, obj.getAsPDFText(), field.getName));
      }
    }
    var outs = new FileOutputStream("pout.pdf")
    doc.save(outs, {SDFDoc.SaveMode.INCREMENTAL}, null, 0)
    outs.close
  }
}
```
