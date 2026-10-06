
### Draft scope revision

This version is a first revision of the guide derived from the HL7 Europe Hospital Discharge Report IG 1.0.0, adapted to cover any kind of discharge report. The content has not yet been reviewed for each kind of encounter (e.g. emergency department, day-care, rehabilitation, ambulatory); feedback is welcome on sections that are missing, or that are not relevant, for specific settings.

### Hospital-oriented LOINC section codes

Several section codes are inherited from the Hospital Discharge Report and are defined by LOINC for the hospital setting, for example 8648-8 *Hospital course*, 11535-2 *Hospital discharge diagnosis*, 10185-7 *Hospital discharge procedure* and 8650-4 *Hospital discharge disposition*. In this version they are used for all kinds of discharge report. Setting-neutral codes (e.g. from LOINC or SNOMED CT) may be adopted in a future version.

### Discharge report document types

The [Discharge Report Type](ValueSet-discharge-report-type-eu-dr.html) value set includes a selection of LOINC document codes. Its content, and the strength of the binding on `Composition.type` (currently extensible), are open for feedback, in particular with respect to codes for other settings (e.g. rehabilitation or day-care discharge summaries) and to the use of national document type codes.

### Encounter.hospitalization

In FHIR R4 the admission and discharge details are represented by `Encounter.hospitalization`. Despite its name, this element is used for any kind of encounter covered by this guide (in FHIR R5 it is renamed `Encounter.admission`).

### Images

Some figures (e.g. the EHDS priority categories) were inherited from the Hospital Discharge Report IG and may still need to be updated to reflect the broader scope of this guide.

### Obligations

Obligations are only informative for this version of the guide. They will be consolidated in a future version based on implementer feedback.

### Dependency on a pre-release IHE package

This guide depends on the IHE Medication Prescription and Dispense (MPD) package `ihe.pharm.mpd.r4` version `1.0.0-comment-2`, a public-comment pre-release. The dependency is inherited from the HL7 Europe Base and Core FHIR IG (version 2.0.1), with which this guide is aligned. It will be updated when a final release of the IHE MPD profile is adopted by the HL7 Europe Base and Core FHIR IG.
