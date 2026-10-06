
<!-- Horizontal banner -->

<div style="
  /* reserve space for the ToC on the right */
  margin: 0 340px 1.25rem 0;   /* top right bottom left; adjust 340px to your ToC width */
  border: 2px solid #003366;
  border-radius: 8px;
  padding: 1em;
  background-color: #f9f9ff;
  box-sizing: border-box;

  /* optional: pull the banner up a bit to align with the ToC's top */
  /* margin-top: -0.75rem;  uncomment/tweak if you want tighter vertical alignment */
">
  <div style="margin-bottom: 1em;">
    <img src="xtehr-logo.png" alt="Xt-EHR logo" style="max-width: 100%; height: 40px;" />
  </div>
  <div style="text-align: left;">
    <strong>Acknowledgment</strong><br/>
    The development of this Implementation Guide version has been supported by the 
    <strong>Xt-EHR Joint Action</strong>.  
    Xt-EHR provided expertise, alignment with European health policy priorities, 
    and validation of specifications to enable consistency with EHDS requirements.
  </div>
</div>


    

### Scope

This Implementation Guide specifies a set of rules to be applied to HL7 FHIR to define how to represent a **Discharge Report** in the **European** context, based on the Xt-EHR EHDS logical models (`EHDSDischargeReport`), which refine and generalise the eHealth Network Guideline on Hospital Discharge Report (eHN HDR Guidelines; see the [European eHealth - Key documents](https://health.ec.europa.eu/ehealth-digital-health-and-care/key-documents_en)).

A Discharge Report summarises the care provided to a patient during a healthcare encounter and the information needed to ensure continuity of care after discharge. This guide is not limited to inpatient hospital stays: it covers any kind of encounter that ends with a discharge, for example a **hospital stay**, an **emergency department visit**, a **day-care** episode, a **rehabilitation** stay or an **ambulatory** specialist episode.

Its main goal is to define the content components and preferred structure for composing a Discharge Report, as a common framework that can be further specialised for specific kinds of discharge report and care settings.

This includes both jurisdictional and cross-border scenarios.

This guide doesn't describe how this report is exchanged.

### Relationship with the Hospital Discharge Report IG

This guide is derived from the [HL7 Europe Hospital Discharge Report (HDR) FHIR IG](http://hl7.eu/fhir/hdr) version 1.0.0. The hospital discharge report is now one of the kinds of discharge report covered by this guide; see the [Change Log](changes.html) for the differences with the HDR IG.

### Purpose
The goal of this Implementation Guide is to define a common European specification for the Discharge Report, facilitating harmonisation across national initiatives and laying the groundwork for the European EHR eXchange Format (EEHRxF), by specifying how to exchange personal electronic health data in the priority category of 'discharge reports' listed in Article 14 of the EHDS Regulation.

This project is promoted by HL7 Europe and developed in collaboration with several other European and national organisations and projects.

The aspiration is for this guide to be used as a basis for European national guides, the European EEHRxF and, consequently, by MyHealth@EU for EU cross-border services.

### Background

This guide is part of the group of HL7 FHIR Implementation Guides published by HL7 Europe to support the priority categories identified by the [European Health Data Space Regulation](http://data.europa.eu/eli/reg/2025/327/oj) (EHDS).

This activity has been carried out in a neutral working space by engaging EEHRxF-related initiatives (Xt-EHR, MyHealth@EU Architecture WG, EU-funded projects), national and regional agencies, relevant stakeholders, and interested communities (e.g. EU HL7 Affiliates, IHE Europe).

More details about the project background can be found in the [background page](background.html).
