<xsl:stylesheet xmlns:psi="net:sf:psidev:mi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:namespace-alias stylesheet-prefix = "xsi" result-prefix="psi"/>  
  <xsl:template match="/">
    

		<tr bgcolor="#CCCCCC" >
			<td colspan="3"><h2>List of not allowed references :</h2></td>
			<!-- Following references are not allowed in denormalised form -->
		</tr>

		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="1"/>
		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="2"/>
		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:participantList/psi:participant" mode="3"/> 

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dip="http://dip.doe-mbi.ucla.edu/xml/JIN"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:psi="net:sf:psidev:mi">  

  <xsl:output method="html" indent="yes" />

<html>
	<head>
		<title>DeNormalised Form Tester</title>
		<meta name="Author" content="Cezanne, Even, Roumegous, Jolibert, Thomas-Nelson, Marques, Cros, Sablayrolles at the ENSEIRB (www.enseirb.fr)"/>
	</head>

	<body bgcolor="#FFFFFF">
	<center>
	<table width ="80%" border="0" cellpadding="5" cellspacing="0">
		<tr align="center">
			<td><a href="http://psidev.sourceforge.net"><img src="http://psidev.sourceforge.net/images/psi.gif" width="113" height="75" border="0" align="left"/></a></td> 
			<td align="center"><h2>DeNormalised Form Tester</h2></td>
			<td><a href="http://www.hupo.org/"><img src="http://psidev.sourceforge.net/images/hupo.gif" width="113" height="75" border="0" align="right"/></a></td>
		</tr>
		<tr height="20" bgcolor="#FFFFFF">
			<td colspan="3"/>
		</tr>
	</table> 
          <xsl:element name="H1">

            <xsl:element name="center">
              <font size="+3"> DIP to PSI's Transformation's Report</font>
                            
            </xsl:element>
          </xsl:element>

          <xsl:apply-templates/>
        </xsl:element>
      </xsl:element>
    </xsl:template>
    
    <xsl:template match="dip:project" >
      <xsl:if test="boolean(./*[name(.)!='node' and name(.)!='edge'])">
        <xsl:text>
          These following elements aren't treated because only the ones named "node" and "edge" are.
        </xsl:text>
        <xsl:element name="BR"/>
        <xsl:element name="UL">
          <xsl:for-each select="./*[name(.)!='node' and name(.)!='edge']">
            <xsl:element name="LI">
              <xsl:value-of select="name(.)"/>
              <xsl:element name="BR"/>
            </xsl:element>
          </xsl:for-each>
          <xsl:element name="BR"/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="boolean(dip:node[@class!='protein'])">
        <xsl:text>These following elements "node" aren't treated because their attribute "class" isn't egal to "protein":</xsl:text>
        <xsl:element name="BR"/>
        <xsl:element name="UL">
          <xsl:for-each select="dip:node[@class!='protein']">
            <xsl:element name="LI">
              <xsl:value-of select="./@id"/>
              <xsl:element name="BR"/>
            </xsl:element>
          </xsl:for-each>
          <xsl:element name="BR"/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="boolean(dip:edge[@class!='link'])">
        <xsl:text>These following elements "edge" aren't treated because their attribute "class" isn't egal to "link":</xsl:text>
        <xsl:element name="BR"/>
        <xsl:element name="UL">
          <xsl:for-each select="dip:edge[@class!='link']">
            <xsl:element name="LI">
              <xsl:value-of select="./@id"/>
              <xsl:element name="BR"/>
            </xsl:element>
          </xsl:for-each>
          <xsl:element name="BR"/>        
        </xsl:element>
      </xsl:if>
      <xsl:if test="boolean(dip:node[@class='protein']/*[name(.)!='feature' and name(.)!='att'])">
        <xsl:text>
          We only transform "feature" and "att" elements into each "node" element. These following elements are not treated.
        </xsl:text>
        <xsl:element name="BR"/>
        <xsl:element name="UL">
          <xsl:apply-templates select="dip:node[@class='protein']" mode="erreurnode1"/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="boolean(dip:node[@class='protein']/dip:att[@name!='taxon' and @name!='organism' and @name!='descr' and @name!='shn'])">
        <xsl:text>
          We only transform the elements "att"("node" 's child) which attribute "name" is egal to "taxon" or "organism"
          or "descr" or "shn".
          These following "node" 's attributes are not treated:
        </xsl:text>
        <xsl:element name="BR"/>
        <xsl:element name="UL">
          <xsl:apply-templates select="dip:node[@class='protein']" mode="erreurnode2"/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="boolean(dip:edge[@class='link']/*[name(.)!=('feature' or 'att')])">    
      <xsl:text>We only transform "feature" element into each "edge" element. These following elements are not treated.

</xsl:text>
      <xsl:element name="BR"/>
      <xsl:element name="UL">
        <xsl:apply-templates select="dip:edge[@class='link']" mode="erreuredge"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="boolean(dip:edge[@class='link']/*[name(.)='att'])">
      <xsl:text>
        We don't transform elements "att" included in elements "edge".
      </xsl:text>
      <xsl:element name="BR"/>
      <xsl:element name="BR"/>
    </xsl:if>

    <xsl:if test="boolean(dip:node/dip:feature[@class!='cref'])">
      <xsl:text>
        We don't transform "feature" elements("node" 's son) which attribute class is different to "cref".
      </xsl:text>
      <xsl:element name="BR"/>
      <xsl:element name="UL">
        <xsl:apply-templates select="./dip:node/dip:feature[@class!='cref']/.." mode="erreurfeature"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="dip:node[@class='protein' and (not(dip:att/@name='shn') or not(dip:att/@name='taxon' and dip:att/@name!='organism'))]">
      <xsl:text>
        Warning: Some datas are incomplete
      </xsl:text>
      <xsl:element name="BR"/>
      <xsl:element name="UL">       
      <xsl:apply-templates select="dip:node[@class='protein']" mode="avertissement"/>
    </xsl:element>
  </xsl:if>        
</xsl:template>

<xsl:template match="dip:node[@class='protein']" mode="avertissement">
  <xsl:element name="LI">
    <xsl:text>Dans le node : </xsl:text>
    <xsl:value-of select="./@id"/>
    <xsl:element name="BR"/>
  </xsl:element>
  <xsl:element name="UL">
    <xsl:if test="not(dip:att/@name='shn')">
      <xsl:element name="LI">
        <xsl:text>
          There is no attribute named "shn". The shortLabel will be :
        </xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:element name="BR"/>  
      </xsl:element>
    </xsl:if>
    <xsl:element name="LI">
      <xsl:choose>
        
        <xsl:when test="dip:att/@name='taxon' and dip:att/@name!='organism'">
          <xsl:text>
            The element organism isn't created : the attribute "organism" is missing.
          </xsl:text>
          <xsl:element name="BR"/>  
          <xsl:text>
            The attribute "taxon" 's value which is "
          </xsl:text>
          <xsl:value-of select="./dip:att[@name='taxon']"/>
          <xsl:text>
            " hasn't be copied the PSI file.
          </xsl:text>
          <xsl:element name="BR"/>  
        </xsl:when>
        
        <xsl:when test="dip:att/@name!='taxon' and dip:att/@name='organism'">
          <xsl:text>
            The element organism isn't created : the attribute "taxon" is missing.
          </xsl:text>
          <xsl:element name="BR"/>  
          <xsl:text>
            The attribute "organism" 's value which is "
          </xsl:text>
          <xsl:value-of select="./dip:att[@name='organism']"/>
          <xsl:text>
            " hasn't be copied the PSI file.
          </xsl:text>
          <xsl:element name="BR"/>   
        </xsl:when> 
        
        <xsl:otherwise>
          <xsl:text>
            The element organism isn't created : the attributes "taxon" and "organism" are missing.
          </xsl:text>
          <xsl:element name="BR"/>  
        </xsl:otherwise>
        
      </xsl:choose>
    </xsl:element>
  </xsl:element>
</xsl:template>

<xsl:template match="dip:node[@class='protein']" mode="erreurnode1">
  <xsl:if test="boolean(./*[name(.)!='feature' and name(.)!='att'])">
    <xsl:element name="LI">
      <xsl:text>Dans le node :</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:element name="BR"/>  
      <xsl:element name="UL">
        <xsl:for-each select="./*[name(.)!='feature' and name(.)!='att']">
          <xsl:element name="LI">
            <xsl:text>
              The element :
            </xsl:text>
            <xsl:value-of select="name(.)"/>
            <xsl:element name="BR"/>  
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
      <xsl:element name="BR"/>
    </xsl:element>
  </xsl:if>
</xsl:template>
  
<xsl:template match="dip:node[@class='protein']" mode="erreurnode2">
  <xsl:if test="boolean(./dip:att[@name!='taxon' and @name!='organism' and @name!='descr' and @name!='shn'])">
    
    <xsl:element name="LI">
      <xsl:text>
        In the element "node" :
      </xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:element name="BR"/>  
      <xsl:element name="UL">
        <xsl:for-each select="./dip:att[@name!='taxon' and @name!='organism' and @name!='descr' and @name!='shn']">
          <xsl:element name="LI">
            <xsl:text>
              The attribute :
            </xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:element name="BR"/>
          </xsl:element>  
        </xsl:for-each>
      </xsl:element>
      <xsl:element name="BR"/>  
    </xsl:element>
  </xsl:if>
</xsl:template>

<xsl:template match="dip:edge[@class='link']" mode="erreuredge">
  <xsl:if test="boolean(./*[name(.)!=('feature' or 'att')])">
    <xsl:element name="LI">
      <xsl:text>
        In the element "edge" :
      </xsl:text>       
      <xsl:value-of select="@id"/>
      <xsl:element name="BR"/>  
      <xsl:element name="UL">
        <xsl:for-each select="./*[name(.)!=('feature' or 'att')]">
          <xsl:element name="LI">
            <xsl:text>The element :</xsl:text>
            <xsl:value-of select="name(.)"/>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:element>
  </xsl:if>
</xsl:template>

<!-- Pour ne pas traiter les commentaires du fichier source -->
<xsl:template match="comment()"/>



<xsl:template match="dip:node" mode="erreurfeature">
  <xsl:element name="LI">
    <xsl:text>
      In the element "node" :
    </xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:element name="BR"/>  
  </xsl:element>
</xsl:template>

</xsl:stylesheet>