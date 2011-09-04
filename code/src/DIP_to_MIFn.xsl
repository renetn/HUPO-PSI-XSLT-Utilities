<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dip="http://dip.doe-mbi.ucla.edu/xml/JIN"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:psi="net:sf:psidev:mi">
  
  <xsl:output method="xml" indent="yes"/>
  
  <!-- Construction of the document's head -->
  <xsl:template match="/">
    <xsl:element name="entrySet" namespace="net:sf:psidev:mi">
      <xsl:attribute name="level">1</xsl:attribute>
      <xsl:attribute name="version">12</xsl:attribute>
      <xsl:element name="entry">  
      <xsl:apply-templates/>
    </xsl:element> 
    </xsl:element>
  </xsl:template>
  
  <!-- Transformation of the DIP document's body --> 
  <xsl:template match="dip:project" >
    <!-- Transformation of the element "source" from the DIP document -->
    <xsl:element name="source" >
      <xsl:element name="names" >
        <xsl:element name="shortLabel">DIP</xsl:element>
        <xsl:element name="fullName">Database of Interacting Proteins</xsl:element>
      </xsl:element>
      <xsl:element name="attributeList" >
        <xsl:element name="attribute">
          <xsl:attribute name="name">title</xsl:attribute>
          <xsl:value-of select="@title"></xsl:value-of>
        </xsl:element>
        <xsl:apply-templates select="@ver"/>            
        <xsl:apply-templates select="@source"/>
        <xsl:apply-templates select="@date"/>
        <xsl:apply-templates select="@author"/>
      </xsl:element>       
    </xsl:element>
    <!-- Construction of the experimentList -->
    <xsl:element name="experimentList">
      <xsl:apply-templates select="dip:edge/dip:feature" mode="experiment"/>
    </xsl:element>          
    <!-- Treatment of the interctors  -->
    <xsl:element name="interactorList" >
      <!-- We apply the same transformation for each element 'node' -->
      <xsl:apply-templates select="dip:node"/>
    </xsl:element>
    <!-- Treatment of the interactions -->
    <xsl:element name="interactionList">
      <!-- We apply the same transformation for each element 'edge' -->
      <xsl:apply-templates select="dip:edge"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Acces to the project's source -->
  <xsl:template match="dip:project/@source">
    <xsl:element name="attribute">
      <xsl:attribute name="name">source</xsl:attribute>
      <xsl:value-of select="."></xsl:value-of>
    </xsl:element>
  </xsl:template>
  
  <!-- Acces to the project's date -->
  <xsl:template match="dip:project/@date">
    <xsl:element name="attribute">
      <xsl:attribute name="name">date</xsl:attribute>
      <xsl:value-of select="."></xsl:value-of>
    </xsl:element>
  </xsl:template>

  <!-- Acces to the project's author -->
  <xsl:template match="dip:project/@author">
    <xsl:element name="attribute">
      <xsl:attribute name="name">author</xsl:attribute>
      <xsl:value-of select="."></xsl:value-of>
    </xsl:element>
  </xsl:template>

  <!-- Acces to the project's version -->
  <xsl:template match="dip:project/@ver">
    <xsl:element name="attribute">
      <xsl:attribute name="name" >version</xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>       
  </xsl:template>

  <!-- Treatment for each experiment. Applied on 'feature' nodes(child of 'edge') -->
  <xsl:template match="dip:edge/dip:feature" mode="experiment">
    <xsl:element name="experimentDescription">
      <xsl:attribute name="id">
        <!-- there is no ID present in DIP that's why we generate one -->
        <xsl:value-of select="generate-id(.)"/>
      </xsl:attribute>
      <!-- Data transfert -->
      <xsl:element name="interactionDetection">
        <xsl:element name="names">
          <xsl:element name="shortLabel">
            <xsl:value-of select="@uid"/>
          </xsl:element>
          <xsl:element name="fullName">
            <xsl:value-of select="./dip:val"/>
          </xsl:element>
        </xsl:element>
        <xsl:element name="xref">
          <xsl:element name="primaryRef">
            <xsl:attribute name="db">
              <xsl:value-of select="substring-before(./dip:src,':')"/>
            </xsl:attribute>
            <xsl:attribute name="id">
              <xsl:value-of select="substring-after(./dip:src,':')"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
  <!-- Treatment for each protein. Applied on 'node' nodes -->
  <xsl:template match="dip:node[@class='protein']">
    <!-- Construction of a valid PSI protein with DIP datas -->
    <xsl:element name="proteinInteractor" >
      <xsl:attribute name="id">
        <!-- there is no ID present in DIP that's why we generate one -->
        <xsl:value-of select="generate-id()"/>
      </xsl:attribute>
      <xsl:element name="names" >
        <xsl:element name="shortLabel">
          <xsl:if test="dip:att/@name='shn'">
            <xsl:value-of select=" dip:att/dip:val[../@name='shn']"/>
          </xsl:if>
          <xsl:if test="not(dip:att/@name='shn')">
            <xsl:value-of select="@name"/>
          </xsl:if>
        </xsl:element>
        <xsl:if test="dip:att/@name='descr'">
          <xsl:element name="fullName"><xsl:value-of select="dip:att/dip:val[../@name='descr']"/></xsl:element>
        </xsl:if>
      </xsl:element>
      <xsl:element name="xref">
        <xsl:element name="primaryRef">
          <xsl:attribute name="db">DIP</xsl:attribute>
          <xsl:attribute name="id">
            <xsl:value-of select="./@uid"/>
          </xsl:attribute>
        </xsl:element>
        <!-- Construction of a possible secondaryRef -->
        <xsl:apply-templates select="dip:feature"/>
      </xsl:element>
      <!-- We create an element 'organism' only if all the DIP datas exist -->
      <xsl:if test="dip:att/@name='taxon' and dip:att/@name='organism'">
        <xsl:element name="organism">
          <xsl:attribute name="ncbiTaxId">
            <xsl:value-of select="dip:att/dip:val[../@name='taxon']"/>
          </xsl:attribute>
          <xsl:element name="names">
            <xsl:element name="shortLabel">
              <xsl:value-of select="dip:att/dip:val[../@name='organism']"/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <!-- Construction of an optional secondaryRef for a PSI protein -->
  <xsl:template match="dip:node/dip:feature[@class='cref']">
    <xsl:element name="secondaryRef">
      <xsl:attribute name="db">
        <xsl:value-of select="dip:src"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="./@name"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

  <!-- Treatment for each interaction. Applied on 'edge' nodes -->
  <xsl:template match="dip:edge[@class='link']">
    <xsl:element name="interaction">
      <!-- Construction with the DIP datas -->
      <xsl:if test="boolean(@uid)">
        <xsl:element name="names">
          <xsl:element name="shortLabel">
            <xsl:value-of select="@uid"/>
          </xsl:element>
          <xsl:if test="boolean(@name)">
            <xsl:element name="fullName">
              <xsl:value-of select="@name"/>
            </xsl:element>
          </xsl:if>
        </xsl:element>
      </xsl:if>
      <xsl:if test="not(boolean(@uid)) and boolean(@name)">
        <xsl:element name="names">
          <xsl:element name="shortLabel">
            <xsl:value-of select="@name"/>
          </xsl:element>
          <xsl:element name="fullName">
            <xsl:value-of select="@name"/>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <!-- Construction of the list of experiments -->
      <xsl:element name="experimentsList">
        <xsl:apply-templates select="./dip:feature" mode="ref"/>
      </xsl:element>       
      <!-- Construction of the list of participants -->
      <xsl:element name="participantList">
        <xsl:element name="proteinParticipant">
          <xsl:element name="interactorRef">
            <xsl:attribute name="ref">
              <xsl:value-of select="generate-id(//dip:node[@id=current()/@from])"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:element>
        <xsl:element name="proteinParticipant">
          <xsl:element name="interactorRef">
            <xsl:attribute name="ref">
              <xsl:value-of select="generate-id(//dip:node[@id=current()/@to])"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- Construction of an experiment -->
  <xsl:template match="dip:edge/dip:feature" mode="ref">
    <xsl:element name="experimentRef">
      <xsl:attribute name="ref">
      <xsl:value-of select="generate-id(.)"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  
  <!-- Treatment for all the other cases(unknown elements) -->
  <xsl:template match="node() | @*">
    <xsl:message >
      Datas has been lost. You may use dip2psi_report.xsl!
    </xsl:message>
  </xsl:template>

  <!-- Treatment of the comments -->
  <xsl:template match="comment()"/>

</xsl:stylesheet>