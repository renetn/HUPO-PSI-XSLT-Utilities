<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- XSLT stylesheet to check if a PSI-MI files is into denormalised   -->
<!-- form.                                                             -->
<!-- It lists not allowed references : experimentRef, availabilityRef  -->
<!-- and interactorRef .                                               -->
<!-- It lists misplaced descritpions : experimentDescription,          -->
<!-- availabilityDescription and interactorDescription .               -->
<!-- It lists contradictory descritpions of experimentDescription,     -->
<!-- availabilityDescription and interactorDescription .               -->
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- This file is based on the XSD schema version (CVS) 1.12.          -->
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- Written by Cezanne, Even, Roumegous, Jolibert, Thomas-Nelson,     -->
<!-- Marques, Cros, Sablayrolles at the ENSEIRB (www.enseirb.fr)       -->
<!-- with a little advice from David Sherman 2003/05/21                -->
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->



<xsl:stylesheet xmlns:psi="net:sf:psidev:mi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:namespace-alias stylesheet-prefix = "xsi" result-prefix="psi"/>  
  <xsl:template match="/">
    
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
		<tr bgcolor="#CCCCCC" >
			<td colspan="3"><h2>List of not allowed references :</h2></td>
			<!-- Following references are not allowed in denormalised form -->
		</tr>

		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="1"/>
		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="2"/>
		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:participantList/psi:participant" mode="3"/> 
		
		<tr bgcolor="#CCCCCC" >
			<td colspan="3"><h2>List of misplaced definitions :</h2></td>
			<!-- The following definitions should not be done in experimentList, availabilityList or interactorList -->
		</tr>

		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:experimentList/psi:experimentDescription" mode="1"/>
		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:availabilityList/psi:availability" mode="2"/>
		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactorList/psi:interactor" mode="3"/> 
		
		<tr bgcolor="#CCCCCC" >
			<td colspan="3"><h2>List of contradictory descriptions :</h2></td>
			<!-- The following definitions have several contadictory contents -->
		</tr>
	        <xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="4"/>
		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="5"/>
		<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:participant" mode="6"/>
	</table>
	</center>
      </body>
    </html>
  </xsl:template>

<!-- lists the not allowed references -->
<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="1">
 
  <xsl:if test="./psi:experimentRef">
      <tr bgcolor="#FF0066"><td colspan="3">
<b>experimentRef</b> element with the <b>REF:[<xsl:value-of select="./psi:experimentRef/@ref"/>]</b> found in the interaction number <b><xsl:value-of select="position()"/></b>
    </td></tr>
    </xsl:if>
</xsl:template>

<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="2">
  <xsl:if test="./psi:availabilityRef">
      <tr bgcolor="#00FF00"><td colspan="3">
<b>availabilityRef</b> element with the <b>REF:[<xsl:value-of select="./psi:availabilityRef/@ref"/>]</b> found in the interaction number <b><xsl:value-of select="position()"/></b>
    </td></tr>
</xsl:if>
</xsl:template>

<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:participantList/psi:participant" mode="3">
  <xsl:if test="./psi:interactorRef">
      <tr bgcolor="#0099FF"><td colspan="3">
<b>interactorRef</b> element with the <b>REF:[<xsl:value-of select="./psi:interactorRef/@ref"/>]</b> found in the interaction number <b><xsl:value-of select="position()"/></b>
    </td></tr>
</xsl:if>
</xsl:template>

<!-- lists misplaced definitions -->
  <xsl:template match="/psi:entrySet/psi:entry/psi:experimentList/psi:experimentDescription" mode="1">
    <tr bgcolor="#FF0066"><td colspan="3">
<b>experimentDescription</b> element with the <b>ID:[<xsl:value-of select="@id"/>]</b> found in experimentList at position <b><xsl:value-of select="position()"/></b>
    </td></tr>
</xsl:template>
  
  <xsl:template match="/psi:entrySet/psi:entry/psi:availabilityList/psi:availability" mode="2">
      <tr bgcolor="#00FF00"><td colspan="3">
<b>availabilityDescription</b> element with the <b>ID:[<xsl:value-of select="@id"/>]</b> found in availabilityList at position <b><xsl:value-of select="position()"/></b>
    </td></tr>
  </xsl:template>
  
  <xsl:template match="/psi:entrySet/psi:entry/psi:interactorList/psi:proteinInteractor" mode="3">
      <tr bgcolor="#0099FFF"><td colspan="3">
<b>proteinInteractor</b> element with the <b>ID:[<xsl:value-of select="@id"/>]</b> found in interactorList at position <b><xsl:value-of select="position()"/></b>
    </td></tr>
  </xsl:template>
      
<!-- lists the contradictory descriptions -->
<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="4">
  <xsl:variable name="n" select="psi:experimentDescription/@id"/>
  <xsl:if test="not($n=preceding-sibling::psi:interaction/psi:experimentDescription/@id)">
    <xsl:variable name="d" select="psi:experimentDescription"/>
    <xsl:variable name="p" select="position()"/>
    <xsl:for-each select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction[position()>=$p]">
      <xsl:variable name="d2"><xsl:copy-of select="psi:experimentDescription"/></xsl:variable>
      <xsl:if test="($n=./psi:experimentDescription/@id) and (not($d2=$d)) ">
    <tr bgcolor="#FF0066"><td colspan="3">
Interaction number <b><xsl:value-of select="position()"/></b> contains :<br/>
<br/>
<fieldset><legend>experimentDescription</legend>
<xsl:value-of select="$d2"/><br/>
</fieldset>
<br/>
<b>different from</b> :<br/>
<br/>
<fieldset><legend>experimentDescription</legend>
<xsl:value-of select="$d"/><br/>
</fieldset>
<br/>
of interaction number <b><xsl:value-of select="$p"/></b> with the same ID[<b><xsl:value-of select="$n"/></b>]<br/>.
<br/>
<b><i>Only the latter definition will be preseved.</i></b>
    </td></tr>
    </xsl:if>
  </xsl:for-each>
</xsl:if>
</xsl:template>


<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="5">
  <xsl:variable name="n" select="psi:availabilityDescription/@id"/>
  <xsl:if test="not($n=preceding-sibling::psi:interaction/psi:availabilityDescription/@id)">
    <xsl:variable name="d" select="psi:availabilityDescription"/>
    <xsl:variable name="p" select="position()"/>

    <xsl:for-each select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction[position()>=$p]">
      <xsl:variable name="d2" select="psi:availabilityDescription"/>
      <xsl:if test="($n=./psi:availabilityDescription/@id) and (not($d2=$d)) ">
      <tr bgcolor="#00FF00"><td colspan="3">
Interaction number <b><xsl:value-of select="position()"/></b> contains :<br/>
<br/>
<fieldset><legend>availabilityDescription</legend>
<xsl:value-of select="$d2"/><br/>
</fieldset>
<br/>
<b>different from</b> :<br/>
<br/>
<fieldset><legend>availabilityDescription</legend>
<xsl:value-of select="$d"/><br/>
</fieldset>
<br/>
of interaction number <b><xsl:value-of select="$p"/></b> with the same ID[<b><xsl:value-of select="$n"/></b>]<br/>.
<br/>
<b><i>Only the latter definition will be preseved.</i></b>
     </td></tr>
    </xsl:if>
  </xsl:for-each>
</xsl:if>
</xsl:template>


<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:participant" mode="6">
 <xsl:variable name="int_pos"><value-of select="ancestor::psi:interaction/position()"/></xsl:variable>
 <xsl:variable name="part_pos" select="position()"/>
 <xsl:variable name="n" select="psi:proteinInteractor/@id"/>
  
 <xsl:if test="not($n=//psi:entrySet/psi:entry/psi:interactionList/psi:interaction[not(position()>$int_pos)]/psi:participantList/psi:participant[not(position()>=$part_pos)]/psi:proteinInteractor/@id)">
      <xsl:variable name="d" select="psi:proteinInteractor"/>
      
    <xsl:for-each select="//psi:entrySet/psi:entry/psi:interactionList/psi:interaction[position()>=$int_pos]/psi:participantList/psi:participant[position()>$part_pos]">
      <xsl:variable name="d2" select="psi:proteinInteractor"/>
      <xsl:if test="($n=psi:proteinInteractor/@id) and (not($d2=$d)) ">
      <tr bgcolor="#0099FFF"><td colspan="3">
Interaction number <b><xsl:value-of select="position()"/></b> contains :<br/>
<br/>
<fieldset><legend>proteinInteractor</legend>
<xsl:value-of select="$d2"/><br/>
</fieldset>
<br/>
<b>different from</b> :<br/>
<br/>
<fieldset><legend>proteinInteractor</legend>
<xsl:value-of select="$d"/><br/>
</fieldset>
<br/>
of interaction number <b><xsl:value-of select="$int_pos"/></b> with the same ID[<b><xsl:value-of select="$n"/></b>]<br/>.
<br/>
<b><i>Only the latter definition will be preseved.</i></b>
    </td></tr>
    </xsl:if>
  </xsl:for-each>
</xsl:if>
</xsl:template>

</xsl:stylesheet>