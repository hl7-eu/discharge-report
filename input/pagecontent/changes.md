This page summarises the main changes applied to this version of the guide.

### 0.1.0 – Initial version, derived from the Hospital Discharge Report IG 1.0.0

This guide is derived from the [HL7 Europe Hospital Discharge Report (HDR) FHIR IG 1.0.0](http://hl7.eu/fhir/hdr/1.0.0). Its scope is extended from the hospital discharge report to **any kind of discharge report**, in line with the Xt-EHR `EHDSDischargeReport` logical model. For the history of the changes prior to this version, see the [HDR change log](http://hl7.eu/fhir/hdr/1.0.0/changes.html).

#### 🔧 Identity of the guide

* Package id `hl7.fhir.eu.discharge-report`, canonical `http://hl7.eu/fhir/discharge-report`, title *HL7 Europe Discharge Report*.
* All artifacts are renamed from the `HDR` to the `DR` code: profile names (`<Resource>EuHdr` → `<Resource>EuDr`, `<Resource>EuHdrObligation` → `<Resource>EuDrObligation`), ids (`<resource>-eu-hdr` → `<resource>-eu-dr`, `<resource>-obl-eu-hdr` → `<resource>-obl-eu-dr`), titles (`(HDR)` → `(DR)`), value sets (`<Name>HdrVS` → `<Name>DrVS`) and invariants (`cmp-hdr-n` → `cmp-dr-n`, `bdl-hdr-n` → `bdl-dr-n`, `dus-hdr-n` → `dus-dr-n`).
* As a new guide, the profiles and value sets are FMM 1 / draft; the obligation profiles remain FMM 0 / informative.

#### 📄 Document structure (Bundle and Composition)

* `Composition.type` is no longer fixed to LOINC 34105-7 (Hospital Discharge summary); it is bound (extensible) to the new [Discharge Report Type](ValueSet-discharge-report-type-eu-dr.html) value set, with LOINC 18842-5 (Discharge summary) as the generic code.
* The `sectionHospitalCourse` slice is renamed `sectionCourseOfEncounter` (title *Course of encounter*, same LOINC code 8648-8); the invariant `cmp-dr-2` requires at least one of the Discharge summary or Course of encounter sections.
* The *Hospital admission evaluation* section is renamed *Admission evaluation*, and *Hospital discharge medications* is renamed *Discharge medications* (same codes).
* Section, Composition and Bundle descriptions are generalised from the hospital stay to the encounter.

#### 🧩 Other profiles and terminology

* `EncounterEuDr` describes any kind of encounter leading to a discharge; `Encounter.hospitalization` is documented as applicable to all kinds of encounter.
* The [Encounter Class](ValueSet-encounter-class-eu-dr.html) value set is extended with the `EMER` (emergency), `AMB` (ambulatory) and `HH` (home health) codes; the descriptions of the encounter value sets no longer refer to inpatient encounters only.

#### 🧪 Examples

* Added an [Emergency Department Discharge Report example](Bundle-DR-Emergency-Department-Example.html).
* The Hospital Discharge Report examples are kept as examples of one kind of discharge report.

#### 📚 Narrative pages

* Home, Scope, Background, Challenges, Design, Logical Models, References, Authors and Known Issues pages revised for the broader scope.
