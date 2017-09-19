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
      <div class="col-lg-12">
        <p id="regMsg">Loading...</p>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12">
          <div class="table-responsive">        
              <table class="tablesorter">
                  <thead>
                      <tr>
                          <th>Course</th>
                          <th>Building</th>
                      </tr>
                  </thead>
                  <tbody id="tblBdy"><tr><td>&#160;</td><td>&#160;</td></tr></tbody>
              </table>
          </div>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12">
        <button class="btn btn-primary pull-right" id="btnClear">Clear</button>
      </div>
    </div>
    <div class="row" id="divMap">
        <br /><div id="map-canvas">&#160;</div>
    </div>
  </xsl:template>
</xsl:stylesheet>