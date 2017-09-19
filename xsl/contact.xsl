<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="2.0">

  <!-- import common page layout -->
  <xsl:import href="common.xsl" />

    <xsl:output
        method="xml"
        encoding="utf-8"
        omit-xml-declaration="yes"
        doctype-public="http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd"
        doctype-system="-//W3C//DTD XHTML Basic 1.1//EN" />

  <!--
    match on courses, since the following was set in common.xsl:
    <xsl:template match="document-node()">
  -->
  <xsl:template match="courses">
      <div class="row">
        <h2 class="contact">Contact Us</h2>
        <p class="contact">Note: This page does not send an actual email.</p>
        <div class="col-lg-8">
            <form class="form-horizontal" role="form" id="frmContact" action="thanks.html" method="POST" >
              <div class="form-group">
                <label class="control-label col-sm-2" for="name">Name:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="name" name="name" required="required" />
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-sm-2" for="email">Email:</label>
                <div class="col-sm-10">
                  <input type="email" class="form-control" id="email" name="email" required="required" />
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-sm-2" for="name">Phone:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="phone" name="phone" />
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-sm-2" for="question">Ask your question here:</label>
                <div class="col-sm-10">
                  <textarea rows="10" class="form-control" id="question" name="question">&#160;</textarea>
                </div>
              </div>

              <div class="form-group">        
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="submit" class="btn btn-default pull-right">Submit</button>
                </div>
              </div>
            </form>
        </div>
      </div>
  </xsl:template>
</xsl:stylesheet>