<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- XSLT stylesheet to check if a PSI-MI files is into canonical form.-->
<!-- It lists references without descritpion for experimentRef,        -->
<!-- availabilityRef and interactorRef .                               -->
<!-- It lists misplaced descritpions : experimentDescription,          -->
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
		<title>Normalised Form Tester</title>
		<meta name="Author" content="Cezanne, Even, Roumegous, Jolibert, Thomas-Nelson, Marques, Cros, Sablayrolles at the ENSEIRB (www.enseirb.fr)"/>
	</head>

	<body bgcolor="#FFFFFF">
	<center>
	<table width ="80%" border="0" cellpadding="0" cellspacing="0">
		<tr align="center">
			<td><a href="http://psidev.sourceforge.net"><img src="http://psidev.sourceforge.net/images/psi.gif" width="113" height="75" border="0" align="left"/></a></td> 
			<td align="center"><h2>Normalised Form Tester</h2></td>
			<td><a href="http://www.hupo.org/"><img src="http://psidev.sourceforge.net/images/hupo.gif" width="113" height="75" border="0" align="right"/></a></td>
		</tr>
		<tr height="20" bgcolor="#FFFFFF">
			<td colspan="3"/>
		</tr>
		<tr bgcolor="#CCCCCC" >
			<td colspan="3"><h2>List of undefined references :</h2></td>
			<!-- The following reference have no definition -->
		</tr>

	<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:experimentRef"/>
	<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:availabilityRef"/>
	<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:participantList/psi:participant/psi:interactorRef"/>
		
		<tr height="20" bgcolor="#FFFFFF">
			<td colspan="3"/>
		</tr>
		<tr bgcolor="#CCCCCC" >
			<td colspan="3"><h2>List of misplaced descriptions :</h2></td>
			<!-- The following definitions should not be done in interactionList -->
		</tr>

	<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="check_experiment"/>
	<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="check_availability"/>
	<xsl:apply-templates select="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:participantList/psi:participant"/>
		
	</table>
	</center>
	</body>
</html>

</xsl:template>


<!-- References tests -->

<!-- check if a definition exists for each experimentRef -->
<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:experimentRef">
 
  <xsl:if test="not(/psi:entrySet/psi:entry/psi:experimentList/psi:experimentDescription[@id=current()/@ref])">
    <tr bgcolor="#FF0066"><td colspan="3">
An <b>ExperimentRef</b> makes reference to the <b>ID:[<xsl:value-of select="current()/@ref"/>]</b>, which is unknown, in the interaction number: <b><xsl:value-of select="position()"/></b>
    </td></tr>
</xsl:if>
</xsl:template>

<!-- check if a definition exists for each availabilityRef -->
<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:availabilityRef">
  <xsl:if test="not(/psi:entrySet/psi:entry/psi:availabilityList/psi:availability[@id=current()/@ref])">
    <tr bgcolor="#00FF00"><td colspan="3">
An <b>AvailabilityRef</b> makes reference to the <b>ID:[<xsl:value-of select="current()/@ref"/>]</b>, which is unknown, in the interaction number: <b><xsl:value-of select="position()"/></b>
    </td></tr>
  </xsl:if>
</xsl:template>

<!-- check if a definition exists for each interactorRef -->
<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:participantList/psi:participant/psi:interactorRef">
  <xsl:if test="not(/psi:entrySet/psi:entry/psi:interactorList/psi:proteinInteractor[@id=current()/@ref])">
    <tr bgcolor="#0066FF"><td colspan="3">
An <b>InteractorRef</b> makes reference to the <b>ID:[<xsl:value-of select="current()/@ref"/>]</b>, which is unknown, in the interaction number: <b><xsl:value-of select="position()"/></b>
    </td></tr>
  </xsl:if>
</xsl:template>
  

<!-- Misplaced Descriptions tests -->

<!-- lists the misplaced experimentDescription -->
<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="check_experiment">
 
  <xsl:if test="./psi:experimentDescription">
    <tr bgcolor="#FF0066"><td colspan="3">
<b>experimentDescription</b> element with the <b>ID:[<xsl:value-of select="current()/psi:experimentDescription/@id"/>]</b> found in the interaction number <b><xsl:value-of select="position()"/></b>
    </td></tr>
  </xsl:if>
</xsl:template>

<!-- lists the misplaced availabilityDescription -->
<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction" mode="check_availability">
  <xsl:if test="./psi:availabilityDescription">
      <tr bgcolor="#00FF00"><td colspan="3">
<b>availabilityDescription</b> element with the <b>ID:[<xsl:value-of select="current()/psi:availabilityDescription/@id"/>]</b> found in the interaction number <b><xsl:value-of select="position()"/></b>
    </td></tr>
</xsl:if>
</xsl:template>

<!-- lists the misplaced proteinInteractor -->
<xsl:template match="/psi:entrySet/psi:entry/psi:interactionList/psi:interaction/psi:participantList/psi:participant">
  <xsl:if test="./psi:proteinInteractor">
      <tr bgcolor="#0066FF"><td colspan="3">
<b>proteinInteractor</b> element with the <b>ID:[<xsl:value-of select="current()/psi:proteinInteractor/@id"/>]</b> found in the interaction number <b><xsl:value-of select="position()"/></b>
    </td></tr>
</xsl:if>
</xsl:template>


</xsl:stylesheet>