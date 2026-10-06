The **HL7 Europe Discharge Report FHIR Implementation Guide** defines a standard approach for representing discharge reports using HL7 FHIR (Fast Healthcare Interoperability Resources) within the European context (transport and exchange mechanisms are out of scope). It is based on the **Xt-EHR EHDS logical models**, in particular the generic `EHDSDischargeReport` model, which refines the **eHealth Network Guideline on Hospital Discharge Report** (eHN HDR Guidelines), supporting the **European Health Data Space (EHDS)** and ensuring interoperability across EU Member States.

This Implementation Guide aims to enable the consistent and interoperable exchange of discharge information using the HL7 FHIR standard. It supports healthcare providers, IT vendors, and public health authorities in implementing national and cross-border exchange of discharge reports. The guide addresses the representation of structured and narrative clinical information to ensure the continuity of care in **cross-border** and **national healthcare settings**.

### Kinds of discharge report

A discharge report is produced when a patient is discharged at the end of a healthcare encounter. Following the EHDS logical model, this guide specifies a **generic and flexible** discharge report that can be used for different kinds of encounters, including for example:

- **hospital stays** (inpatient encounters), i.e. the Hospital Discharge Report;
- **emergency department** visits;
- **day-care** and short-stay episodes;
- **rehabilitation** and other non-acute inpatient stays;
- **ambulatory** specialist episodes ending with a discharge.

Different kinds of encounters may require adding relevant sections and elements, or omitting irrelevant ones, depending on their data needs. The kind of report is identified by the document type (`Composition.type`), while the kind of encounter is described by the referenced `Encounter`.

### Content of this guide

The scope of this guide includes:

- Defining FHIR profiles and extensions necessary for representing discharge reports as structured and narrative documents.
- Providing a common **section library** that can be used, as relevant, by the different kinds of discharge report.
- Providing alignment with the existing eHN HDR Guidelines, the EHDS logical models (v1.0.0) published by the Xt-EHR Joint Action and international standards (like **HL7 IPS**).
- Supporting the use of internationally recognised coding systems (e.g., **SNOMED CT**, **ICD-10**, **LOINC**) to ensure semantic interoperability.

Specific kinds of discharge report (for example the hospital discharge report used by MyHealth@EU) may be further specialised by derived guides, which can constrain this guide by requiring sections, fixing the document type or adding setting-specific content.
