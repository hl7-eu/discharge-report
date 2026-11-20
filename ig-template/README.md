# HL7 Europe Discharge Report – local IG template

Local FHIR IG template (`hl7.fhir.eu.template`) used by the HL7 Europe Discharge Report implementation guide.

It is based on the language-aware `fhir2.base.template`, pinned to version 0.1.0 in `package/package.json`, and adds the HL7 Europe look:

- `includes/fragment-header.html` and `includes/fragment-footer.html`: HL7 Europe header (logos) and footer;
- `includes/_append.fragment-css.html`: adds `assets/css/hl7eu.css` to the base stylesheets;
- `content/searchform.html`: search page;
- `content/assets/`: stylesheets, images and favicon.

The menu is not part of the template: it is provided by the guide in `input/includes/menu.xml`, because the base template does not accept the `href="#"` dropdown toggles that SUSHI generates.
