# Discharge Report IG – to-do list after the HDR → DR scope change

Started: 2026-10-06, after the first revision (version 1.0.0-ci-build) that turned the Hospital Discharge Report (HDR) 1.0.0 into the generic Discharge Report (DR).
Status: `[ ]` open · `[x]` done · `[-]` dropped (add a short reason).

---

## 1. Build and validation (do first)

### First full build – 2026-10-06

IG Publisher 2.3.4 (`../publisher.jar`), with the terminology server (tx.fhir.org).
QA result: **1 error, 0 warnings, 1 information**, 0 broken links, 0 invalid XHTML pages.
Suppressed by `ignoreWarnings.txt`: 199 warnings and 675 hints.

| # | Severity | Message | Action |
| --- | --- | --- | --- |
| 1 | Error | No JIRA specification file `FHIR-eu-discharge-report` in the `HL7/Jira-Spec-Artifacts` repo | Expected; handled as a last step just before publication (not tracked here) |
| 2 | Information | Wrong display for LOINC 28655-9 in `DischargeReportTypeDrVS`: the valid display is *Attending Discharge summary* | Fixed in the FSH after the build; not yet rebuilt |

Also in the build log, not reported in the QA:

- `Error generating combined package: output\package.tgz (file not found)`, logged just before Jekyll runs. It looks like a publisher ordering issue, because the package is built later. Check that it doesn't come back on the CI build.

### Items

- [x] Run the full IG Publisher (`_build`) and triage the QA report. Done 2026-10-06; results are in the table above.
- [x] Rebuild to confirm that the LOINC 28655-9 display fix clears the information message. The second build, with version 1.0.0-ci-build, on 2026-10-06 returned 1 error (the expected JIRA spec file), 0 warnings, 0 information messages and 0 broken links.
- [x] Use a terminology server to check the codes added in this revision:
  - [x] the LOINC codes in `DischargeReportTypeDrVS`: all are valid. Only the 28655-9 display was wrong, and it is now fixed.
  - [x] the codes in the new ED example (SNOMED CT 29857009 and 29303009, ICD-10 R07.4, `discharge-disposition#home`): no terminology issues reported.
- [ ] Review `input/ignoreWarnings.txt`:
  - [x] The `.../fhir/dr/...` URLs match: the suppressions on the `bundle-eu-dr`, `composition-eu-dr`, `deviceUseStatement-eu-dr` and `encounter-eu-dr` slices are used.
  - [ ] Remove the unused suppression for `Unknown code 'system' in the CodeSystem 'http://hl7.org/fhir/examplescenario-actor-type'` (0 uses; the old HDR ActorDefinition issue).
  - [ ] Review the broad wildcard suppressions. They also hide messages from new examples, e.g. `%This element does not match any known slice defined in the profile .../composition-eu-dr%` has 17 uses, and the one on `.../encounter-eu-dr%` has 1. Check that none of them come from the ED example, and narrow the patterns where possible.
  - [ ] Check the 50 warnings suppressed on `StructureDefinition-composition-eu-dr` and the 26 on `composition-obl-eu-dr`, to make sure nothing new related to the `Composition.type` binding is hidden.

### Third build – 2026-10-06, IG Publisher 2.3.5

IG Publisher 2.3.5 (`../publisher.jar`, updated on 2026-10-06), validator core `6.0.0-snapshot1`.
QA result: **5 errors, 11 warnings, 41 information**, "9 broken links", 1 page with invalid XHTML.
Suppressed: 188 warnings and 639 hints.
The guide content is the same as for the second build (1 / 0 / 0 / 0), so these messages come from the new publisher version.

- [ ] **Marcheschi example: empty Practitioner identifier.** In `practitioner-ftgm-author` (`input/fsh/examples/instances/HDR-Paolo-Marcheschi-example.fsh`), `identifier.id = "12345"` should be `identifier.value` (plus a `system`). This bug was inherited from the HDR and is now caught by `ele-1`. It also causes the other three Marcheschi errors: no matching `composition` slice, and no profile match for `Composition.author` and `attester.party`.
- [ ] **WCAG heading error.** In the Novak sub-sections example page, `<h4> 'Attesters'` follows `<h2>`. The heading comes from the generated narrative or the template; check whether it can be fixed in the guide or whether it should be suppressed or reported to the tooling.
- [ ] **`searchform.html` not well formed (8 warnings).** This page comes from the local `ig-template`. It probably also explains the "9 broken links" in the QA summary, because the link checker in the build log reports 0 broken links. Update or fix the template.
- [ ] **Suppressions that no longer match the new message texts.**
  - [ ] The OID information messages now point to `https://build.fhir.org/ig/FHIR/ig-guidance/oids.html`; the current pattern expects the old `fhir-tools-ig` URL. Use a URL-independent pattern, e.g. `%could usefully have an OID assigned%`.
  - [ ] `ext-ab-1` warnings ("Additional Bindings SHOULD have a key…") on the obligation profiles, inherited from EU Base. Check the new wording and update the suppression.
  - [ ] Warning on `medicationRequest-obl-eu-dr`: "The Binding on the type slicer MedicationRequest.substitution.allowed[x] applies to all its slices". This is new; analyse it before suppressing.
  - [ ] Information messages about draft code systems in the Novak `MedicationStatement.category`. Check whether the existing `MSG_DRAFT` suppression should cover them.
- [ ] Decide which IG Publisher version is the reference for this guide. `../publisher.jar` and `~/.fhir/tools/publisher/publisher.jar` (used by the updated `_build` scripts) can now be different versions.

## 2. Project infrastructure (outside this repo)

- [x] GitHub repository: `hl7-eu/dr` renamed to `hl7-eu/discharge-report` on 2026-10-06 (the old URL redirects). `README.md`, `FHIR-eu-discharge-report.xml` and the local `origin` remote are updated. The package id and canonical were also renamed, from `hl7.fhir.eu.dr` and `http://hl7.eu/fhir/dr` to `hl7.fhir.eu.discharge-report` and `http://hl7.eu/fhir/discharge-report`, and the JIRA spec file to `FHIR-eu-discharge-report.xml`. Artifact ids (`*-eu-dr`) and names (`*EuDr`) keep the `dr` code.
- [x] Set up the CI build at `https://build.fhir.org/ig/hl7-eu/discharge-report`: HL7 build webhook configured on 2026-10-06.
- [ ] Register the `FHIR-eu-discharge-report` specification in the HL7 JIRA spec-artifacts repo so that feedback can be submitted.
- [ ] Reserve or confirm the package id `hl7.fhir.eu.discharge-report` and the canonical `http://hl7.eu/fhir/discharge-report` with HL7 Europe.
- [ ] Decide what happens to the HDR IG:
  - [ ] whether it is maintained in parallel, frozen, or superseded by DR;
  - [ ] if superseded, add a note to the HDR IG pointing to DR.
- [ ] Decide the publication plan for `publication-request.json`: it is currently `1.0.0-ci-build`, `draft`, mode `working`; set the final version and path before publication. Should the first release be a ballot instead?

## 3. Scope decisions to confirm (project team)

- [ ] **Kinds of discharge report in scope.** Confirm the list on the Scope page: hospital, emergency department, day-care, rehabilitation, ambulatory. Should others be added or removed (e.g. nursing home, home care, mental health, palliative care)?
- [ ] **Relationship with MyHealth@EU HDR.** The MyHealth@EU HDR IG is derived from HL7 EU HDR. Decide whether it should derive from DR in the future, possibly through a hospital-specific DR profile.
- [ ] **Setting-specific profiles.** Decide whether this guide should define specialised Composition profiles (e.g. `CompositionHospitalDischargeEuDr`, `CompositionEmergencyDischargeEuDr`) that fix `type` and require sections, or leave this to derived guides. The current text says "derived guides".
- [ ] **`Composition.type` binding.** The binding is currently extensible, with 18842-5 as the generic fallback. Decide between extensible and preferred, and how national document type codes should be used.
- [ ] **`Composition.category`.** It is still only an example (LOINC LP72467-1). Decide whether to require it, as the way to recognise "a discharge report" regardless of type.
- [ ] **Invariant `cmp-dr-2`.** It requires the Discharge summary or the Course of encounter section. Check that this still makes sense for short encounters, such as an ED visit.

## 4. Composition sections

- [ ] **Hospital-named LOINC codes.** Look for setting-neutral codes (LOINC or SNOMED CT) or accept the current ones. Also align the section titles used in the examples. Codes affected:
  - 8648-8 *Hospital course*
  - 11535-2 *Hospital discharge diagnosis*
  - 10185-7 *Hospital discharge procedure*
  - 8650-4 *Hospital discharge disposition*
  - 8653-8 *Hospital discharge instructions* (used in the Wolff example)
- [ ] **Section relevance per kind of encounter.** Write a matrix of section × kind of report (required / recommended / usually not relevant). It could go on the Design page or a new "Kinds of discharge report" page. Check for example:
  - Admission evaluation for ED or ambulatory reports;
  - Pharmacotherapy for short encounters;
  - Immunizations;
  - History of procedures.
- [ ] **Missing sections for non-hospital settings.** Check whether other settings need sections that are not there. Candidates:
  - triage / presenting complaint and mode of arrival (ED);
  - rehabilitation goals and outcomes, functional status at admission vs discharge (rehabilitation);
  - follow-up appointments.
  Check what the EHDS model allows; open sections may be enough.
- [ ] **Section descriptions.** Re-read every section `^definition` in `input/fsh/profiles/composition-dr.fsh` for remaining hospital assumptions. Examples:
  - "Purely diagnostic procedures such as MRI or CT are not reported here";
  - "another hospital or a nursing home" in Discharge details.
- [ ] **`sectionCourseOfEncounter`.** The slice was renamed from `sectionHospitalCourse`. Check the obligation profile and any external references (e.g. MyHealth@EU, national guides) that used the old slice name.

## 5. EHDS model alignment

- [ ] **`header.documentTitle` and `header.status`.** These have no `^requirements` mapping in `CompositionEuDr`; add it to `Composition.title` and `Composition.status`. Only `header.documentType` and `header.period` are mapped today.
- [ ] **`body.synthesis`.** It is mapped on the model-map page (`map-ehdsdischargereport.xml`) but has no `^requirements` on `section[sectionSynthesis]`; add it.
- [ ] **`header.intendedRecipient[x]`.** Check its mapping to the `informationRecipient` extension.
- [ ] **Model-map pages.** Re-check them for the generic model (`input/pagecontent/map-*.xml`, `modelmap.xml`):
  - [ ] confirm the descriptions don't assume an inpatient encounter;
  - [ ] `map-ehdsencounter.xml` maps admission/discharge to `Encounter.hospitalization.*`: add a note that this applies to any encounter.
- [ ] **Check the latest Xt-EHR models.** The `_xtehr/` snapshot is dated 2026-04-13. Check for newer versions of `EHDSDischargeReport` / `EHDSEncounter` and for the Article 15 implementing act.
- [ ] **Logical Models page.** Consider adding models used only by some settings (e.g. `EHDSServiceRequest` for follow-up orders, `EHDSImagingStudy`) if they become relevant.

## 6. Encounter

- [ ] **`EncounterClassDrVS`.** It now has `IMP`, `ACUTE`, `NONAC`, `OBSENC`, `SS`, `EMER`, `AMB` and `HH`. Confirm the list (e.g. add `VR` virtual, `PRENC`?), and remove the old comment "should we have this general category ?".
- [ ] **`EncounterTypeDrVS`.** Check that SNOMED CT *Care provision regime* descendants suit non-hospital settings, or switch to / add a service-type value set.
- [ ] **`dischargeDisposition`.** Consider a preferred value set that covers outcomes typical of ED and ambulatory encounters, such as admitted to hospital, transferred, left without being seen, or home.
- [ ] **ED patients admitted to the same hospital.** Decide how to represent an ED visit that ends in admission rather than discharge (`partOf`, encounter linking). Clarify whether an ED report is still produced in that case.
- [ ] **`legalStatus` extension.** Its short text says "Legal status/situation at admission". Check that this is still meaningful for every kind of encounter.

## 7. Other profiles and obligations

- [ ] Re-read the descriptions of `CarePlanEuDr`, `GoalEuDr`, `DeviceEuDr`, `DeviceUseStatementEuDr`, `MedicationAdministrationEuDr` and `MedicationDispenseEuDr` for remaining hospital wording.
- [ ] **`MedicationAdministrationEuDr` and `MedicationDispenseEuDr`.** Check that they are still needed and justified for all settings.
- [ ] **Obligations.**
  - [ ] Review `CompositionEuDrObligation` against `EHDSDischargeReportObligations`.
  - [ ] Some obligations may differ by kind of report; decide whether that is in scope for v0.1.
  - [ ] Check the "SHALL populate" obligation on `sectionCourseOfEncounter`.
- [ ] **Actors.** The Xt-EHR Producer and Consumer actors are generic; confirm no DR-specific actors are needed.

## 8. Examples

- [ ] **More non-hospital examples.** Consider at least:
  - [ ] a day-care or ambulatory surgery report;
  - [ ] a rehabilitation discharge report;
  - [ ] an example that uses the generic type 18842-5.
- [ ] **ED example.** Consider adding structured entries (e.g. troponin result, MedicationRequest for paracetamol, vital signs) so that it is not mostly narrative.
- [ ] **HDR example ids.** The hospital examples keep their HDR ids (`HDR-*`, `composition-hdr-*`, `*-euhdr`). Decide whether to rename them (e.g. `DR-Hospital-*`), and update the links in `design.md`, `ignoreWarnings.txt` and the Novak sub-section link if you do.
- [ ] **Example titles.** They use the "Bundle: HDR …" pattern. Decide whether to prefix by kind of report, e.g. "Bundle: Hospital DR …" / "Bundle: ED DR …".
- [ ] **CSS class.** The `hl7__hdr` table class in the example narratives can be renamed if wanted (cosmetic only).

## 9. Narrative pages and assets

- [ ] **Figures.** Update the figures in `input/images` (`ehds-domain.png`, `ig-overview.png`, `ehds-ig-strategy.png`) from `input/images-source/images.pptx` to show the DR instead of the HDR.
- [ ] **Authors page.** Check the contributor statistics (224 contributors, 29 countries) and the "Experts Distribution" figure: they describe the HDR community. Decide whether to keep or update them for DR.
- [ ] **Background page.** It still describes the HDR community effort; review it for the DR.
- [ ] **New page (optional).** Consider a page such as "Kinds of discharge report" or "Using this guide for a specific setting" that explains how to specialise the guide, with the section matrix from section 4.
- [ ] **Change Log.** Keep `changes.md` updated as items in this list are resolved.
- [ ] **Known Issues.** Remove entries from `knownIssues.md` as they are resolved, e.g. hospital LOINC codes, document types, images.

## 10. Repository housekeeping

- [x] HDR sources removed from `models-src/` on 2026-10-06. Original item: `models-src/` still holds the HDR sources (`ehn_hdr_guidelines_en.pdf`, `hl7-hdr-models-and-maps.xlsx`, `mindMap/hl7-hdr-mindmap.xlsx`). Decide whether to keep them as background, rename them, or replace them with DR material.
- [ ] Refresh the `_xtehr/` reference snapshot if newer Xt-EHR models are published.
- [ ] Commit the pending `_attic/` and `reviews/` deletions, which were present before the scope change, or restore them.
- [ ] Clean the commented-out HDR leftovers in `sushi-config.yaml` (eHN logical model groups, `*-map.html` pages, ConceptMaps).
- [ ] Commit the scope-change revision (not committed yet).
