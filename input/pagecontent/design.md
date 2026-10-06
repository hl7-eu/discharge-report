

### Generic document, multiple kinds of report

This guide defines a single document structure – the [Bundle (DR)](StructureDefinition-bundle-eu-dr.html) and the [Composition (DR)](StructureDefinition-composition-eu-dr.html) – that can be used for any kind of discharge report:

* the kind of discharge report is identified by `Composition.type`, bound (extensible) to the [Discharge Report Type](ValueSet-discharge-report-type-eu-dr.html) value set (e.g. *Hospital Discharge summary*, *Emergency department Discharge summary*); the generic code LOINC 18842-5 *Discharge summary* is used when no more specific code applies;
* the kind of encounter is described by the [Encounter (DR)](StructureDefinition-encounter-eu-dr.html) referenced by `Composition.encounter`, through `Encounter.class` (e.g. inpatient, emergency, ambulatory) and `Encounter.type`;
* all sections are optional, so that each kind of report includes only the sections relevant for it.

Examples are provided both for hospital discharge reports (e.g. [lower leg fracture](Bundle-HDR-Reijer-Wolff-Example.html)) and for an [emergency department discharge report](Bundle-DR-Emergency-Department-Example.html).


### Section structure

To address the [**Discharge Report Structure Challenge**](challenges.html), we have opted for a **flexible approach** rather than imposing a rigid format.

The **"flat structure"** documented in the guide should be understood as a **"section library"** that can be reused in both **flat and nested structures**, and by the different kinds of discharge report. This approach allows implementers to organise the report according to local, institutional or setting-specific needs while maintaining a standardised content model.

The flat structure is nevertheless considered best practice. Where sub-sections are needed, see this [example](Bundle-DischargeBundle-Novak-Petr-Subsections.html) of how they can be used.

In practice:

1. At least one of the Discharge summary or Course of encounter sections SHALL be present (invariant `cmp-dr-2`).
2. **Section slices are open**, meaning that implementers have the freedom to include additional **"first-level" sections**.
3. With the exception of a few specific cases, **sub-sections are allowed**, giving healthcare providers the ability to create a structure that best fits their clinical context.

By offering this level of flexibility, the implementation guide supports diverse healthcare environments while promoting consistency in content and interoperability.


### Section entry optionality

In order to support the different maturity levels foreseen for the **European EHR eXchange Format** (structured, text-only, unstructured), this version of the guide does not require entries to be present in the Discharge Report sections.

However, the presence of entries in the Discharge Report sections is generally recommended to ensure a more structured and interoperable document.

This recommendation is expressed in this guide through **specific obligations**, which guide implementers toward achieving a higher level of data quality and interoperability.


### Bundle and resource language

`Bundle.language` **SHALL** be populated and represents the **main language** of the Bundle.

Individual resources contained in `Bundle.entry.resource` **MAY** populate their own `language` element. If populated, the individual resource language **SHOULD** be consistent with the main language declared in `Bundle.language`.

For this comparison, only the **primary language subtag** is considered. Regional variants of the same language are therefore considered matching. For example, `fr-BE`, `fr-FR`, and `fr-CA` are considered matching because they share the same primary language subtag, `fr`. The comparison is case-insensitive (for example, `en-US` and `EN-gb` are considered matching).

This expectation is conveyed by the warning-severity invariant `bdl-dr-2` on the [Bundle (DR)](StructureDefinition-bundle-eu-dr.html) profile.


