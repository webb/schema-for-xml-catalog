<?xml version="1.0" encoding="US-ASCII"?>
<schema 
   queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">

  <title>Assertions about XML Catalog</title>

  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <ns prefix="catalog" uri="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>

  <pattern>
    <rule context="/">
      <assert test="self::document-node(element(catalog:catalog))"
              >Document element must be catalog:catalog.</assert>
    </rule>
  </pattern>

  <pattern>
    <rule context="catalog:uri">
      <assert test="exists(@name)">catalog:uri must have @name.</assert>
      <assert test="exists(@uri)">catalog:uri must have @uri.</assert>
    </rule>
  </pattern>

  <pattern>
    <rule context="catalog:uri[exists(@name)]">
      <assert test="empty(preceding::catalog:uri[@name = current()/@name])"
              >There should be only one catalog:uri for an @name, but there is a duplicate for @name=&quot;<value-of select="@name"/>.&quot;</assert>
    </rule>
  </pattern>

  <pattern>
    <rule context="catalog:uri[exists(@uri)]">

      <assert test="ends-with(@uri, '.xsd')
                    or ends-with(@uri, '.csv')">catalog:uri/@uri MUST end in .xsd or .csv</assert>

    </rule>
  </pattern>
  
  <pattern>
    <rule context="catalog:uri[exists(@uri) and ends-with(@uri, '.xsd')]">

      <let name="uri" value="resolve-uri(@uri, base-uri(.))"/>

      <assert test="doc-available($uri)"
              >catalog:uri/@uri must resolve to an XML document.</assert>

      <assert test="not(doc-available($uri))
                    or doc($uri)/self::document-node()"
              >catalog:uri/@uri must reference available document.</assert>

      <assert test="not(doc-available($uri))
                    or doc($uri)/self::document-node(element(xs:schema))"
              >Referenced XML document must have document element xs:schema (uri= <value-of select="$uri"/>, root=<value-of select="node-name(doc($uri)/*)"/>).</assert>

      <assert test="not(doc-available($uri))
                    or doc($uri)/xs:schema/@targetNamespace"
              >Document element xs:schema of referenced XML Schema document must have @targetNamespace.</assert>

    </rule>
    <rule context="catalog:uri[exists(@uri) and ends-with(@uri, '.xsd')]">
      
      <let name="uri" value="resolve-uri(@uri, base-uri(.))"/>

      <assert test="unparsed-text-available($uri)"
              >catalog:uri/@uri for *.csv must resolve to a text file (uri=<value-of select="$uri"/>).</assert>
    </rule>
  </pattern>

  <pattern>
    <rule context="catalog:uri[exists(@uri) and exists(@name)]">
      <let name="uri" value="resolve-uri(@uri, base-uri(.))"/>
      <let name="name" value="@name"/>
      <assert test="not(doc-available($uri))
                    or (doc($uri)/xs:schema/@targetNamespace = $name)"
              >Document element xs:schema of referenced XML Schema document must have @targetNamespace = &quot;<value-of select="$name"/>&quot;.</assert>
    </rule>
  </pattern>

</schema>
