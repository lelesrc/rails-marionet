<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:marionet="http://github.com/youleaf/rails-marionet"
     >

<!--
    <xsl:namespace-alias stylesheet-prefix="xmlns:marionet" 
          result-prefix=""/>
-->
    <xsl:output method="html" omit-xml-declaration="yes"/>


    <!-- Fetch some info from head, and all of body -->
    <xsl:template match="*[local-name()='html']">
        <div id="{$namespace}" class="portlet">
          <div class="{$namespace}_head">
            <xsl:apply-templates select="*[local-name()='head']/link"/>
            <xsl:apply-templates select="*[local-name()='head']/style"/>
          </div>
          <div class="{$namespace}_body">
            <xsl:apply-templates select="*[local-name()='body']"/>
          </div>
        </div>
    </xsl:template>

    <xsl:template match="*[local-name()='body']">
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <!-- Rewrite links -->
    <xsl:template match="*[local-name()='a']">
        <xsl:copy-of select="marionet:link(.,marionet:session)"/>
    </xsl:template>

    <!-- Copy through everything that hasn't been modified by the processor -->
    <xsl:template match="text()|@*|*">
        <xsl:copy>
          <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
