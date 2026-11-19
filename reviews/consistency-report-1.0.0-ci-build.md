# HL7 Europe Discharge Report – Consistency Review for 1.0.0-ci-build (first draft)

- **Date:** 2026-11-19. First review. Items that have been fixed will be removed; they will be listed under *Fixed since the first review* at the end of the report.
- **Scope:** FSH sources (`input/fsh`), narrative pages (`input/pagecontent`, `input/includes`), configuration (`sushi-config.yaml`, `publication-request.json`, `ig.ini`), the local template (`ig-template`), examples, the latest IG Publisher QA output (`output/qa.*`) and `input/ignoreWarnings.txt`.
- **Build status:**
  - SUSHI 3.21.0 ran as part of the Publisher build; its error and warning counts were not captured separately in this review.
  - The IG Publisher v3.0.4 run of 2026-11-19 19:33 was built as `hl7.fhir.eu.discharge-report#1.0.0-ci-build`, status `draft`, release label `ci-build`. It includes all commits up to `3d5f5ef` plus the working copy: template switched to `fhir2.base.template`, `ignoreWarnings.txt` aligned with HDR 1.0.0, `HDR-Paolo-Marcheschi-example.fsh` deleted. None of these changes is committed yet.
  - It reports **20452 errors, 4 warnings and 10 information messages**, plus 195 suppressed warnings and 670 suppressed hints. 20424 of the errors are one terminology problem (7-1).

Severity: **High** means fix before publication. **Medium** means it should be fixed for 1.0.0-ci-build. **Low** means cleanup or editorial.

File references are relative to the repository root. Line numbers are those of the current working copy.

Each open item has an id `<section>-<n>` (e.g. `3.1-2`). Ids are stable: fixed or accepted items keep their id when they move to *Won't fix (accepted)* or *Fixed since the first review*, and new items get the next free number.

---

## 1. Release blockers (High)

| ID | Area | Finding | Fix |
|---|---|---|---|
| 1-1 | QA / terminology | 20424 errors: the eHDSI value set `eHDSIIllnessandDisorder\|0.2.0`, which comes from the EU Base bindings, cannot be expanded. tx.fhir.org reports that its ICD-10 codes (e.g. `I70.20`) are not in `http://hl7.org/fhir/sid/icd-10\|2019-covid-expanded`. The error repeats once per code for each of 6 coded elements in the examples. It also makes `condition-meerling` and `condition-growth` fail `condition-eu-core`, which cascades into the Swart Bundle errors (5-2). | Check whether HDR 1.0.0 now shows the same errors (it is a tx change, not a change in this guide). Report it to the tx.fhir.org / EU Base maintainers. Until then, add one justified pattern, `%The value set 'http://terminology.ehdsi.eu/ValueSet/eHDSIIllnessandDisorder\|0.2.0' is not valid%`, to `ignoreWarnings.txt`, then rebuild to see the remaining errors. |
| 1-2 | Template | The new base template rejects SUSHI's menu: "In your menu.xml file, it's no longer allowed to have href='#' on dropdown items". `fsh-generated/includes/menu.xml` has 4 dropdowns with `href="#"` (Introduction, Functional, Implementation, About). | Provide `input/includes/menu.xml` (copy of the generated one, with `href="menu.html"` on the dropdown toggles) and keep it in sync with the `menu` in `sushi-config.yaml`; or check whether a newer SUSHI writes a valid href. |
| 1-3 | Template / pages | 6 broken links on the Downloads page. `fhir2.base.template` publishes the pages under `output/en/`, while the packages and zips stay in `output/`, so `package.tgz`, `package.r4.tgz`, `package.r4b.tgz` and `examples.*.zip` do not resolve (`input/pagecontent/downloads.md:9,15,19,25-27`). `full-ig.zip` (line 3) has the same problem. | Prefix these links with `../`, as `readi` does (`../package.tgz`, `../full-ig.zip`, …). |

---

## 2. Configuration and publication

| ID | Sev | Location | Finding | Fix |
|---|---|---|---|---|
| 2-1 | Medium | `ig-template/package/package.json:9` | The template depends on `fhir2.base.template#current`, so any change upstream changes the build. The only release is 0.1.0 (2025-07-06). HDR pins `hl7.fhir.template` 1.0.0. | Pin a released version once one works with the current Publisher, or record in `knownIssues.md` / the template README that `current` is used on purpose. |
| 2-2 | Medium | `ig-template/` | The local template still carries fragments written for `hl7.fhir.template` (header logos, `hl7eu.css`, footer, `searchform.html`). The build validates, but the look on the v2 base has not been checked. `README.md` and `package-list.json` still describe the old template, and `package-list.json` has the Laboratory canonical. | Check the rendered pages (header, menu, footer, search). Update `README.md`, and fix the canonical in `package-list.json`. |
| 2-3 | Medium | `FHIR-eu-discharge-report.xml:2-4` (working copy) | The regenerated Jira spec file has an empty `ciUrl` and no `gitUrl`, and it adds a `1.0.0-ci-build` version entry. HDR's file has `ciUrl` and `gitUrl` set. | Restore `ciUrl="https://build.fhir.org/ig/hl7-eu/discharge-report"` and `gitUrl="https://github.com/hl7-eu/discharge-report"` before committing; drop the version entry unless that version will really be published. |
| 2-4 | Medium | `sushi-config.yaml:7,10`, `publication-request.json` | Version `1.0.0-ci-build` and release label `ci-build` are fine for CI, but not for a publication: the publication request would publish at `…/1.0.0-ci-build`. | Before publishing, choose the release version and label (e.g. `0.1.0` / `ballot` or `draft`) and update both files together. |
| 2-5 | Low | QA warning | `hl7.fhir.uv.extensions.r4#5.3.0` is outdated (5.4.0 available). It is the same version as HDR 1.0.0. | Keep it aligned with HDR and EU Base, or update all three together. |
| 2-6 | Low | `sushi-config.yaml` | `hl7.terminology.r4` is not pinned; the Publisher resolves it. | Pin it, or note the resolved version in `knownIssues.md`. |
| 2-7 | Low | `sushi-config.yaml:232-322` | Large blocks of SUSHI template comments and commented-out example resources (Laboratory concept maps, `Patient-obl-eu-lab`). | Delete them. |

---

## 3. Profiles (FSH)

### 3.1 Composition sections vs Bundle entry slices

| ID | Sev | Location | Finding | Fix |
|---|---|---|---|---|
| 3.1-1 | Low | `input/fsh/profiles/composition-dr.fsh`, `bundle-dr.fsh` | Sections reference `ClinicalImpression` and `QuestionnaireResponse`, but the Bundle has no entry slice for them. Inherited unchanged from HDR 1.0.0. | Add the slices, or accept as for HDR. |
| 3.1-2 | Low | `input/fsh/profiles/composition-dr.fsh` | 6 sections have no entry constraint (Admission evaluation, Discharge summary, Course of encounter, Synthesis, Patient history, Discharge details), so any resource is allowed. Inherited from HDR 1.0.0. | Accept as for HDR, or constrain where the content is known. |

### 3.2 Invariants

| ID | Sev | Location | Finding | Fix |
|---|---|---|---|---|
| 3.2-1 | Low | `input/fsh/profiles/composition-dr.fsh:22,426` | LOINC `18842-5` is now both the generic document type (`Composition.type`) and the code of the Discharge summary section that `cmp-dr-2` checks. That is valid, but it can confuse readers. | Add a sentence to the Composition notes or `knownIssues.md`. |

### 3.3 Leftovers in FSH

- **[3.3-1]** **Stale TODO comments:** `input/fsh/alias-systems.fsh:3` ("Temporary canonical"), `:31` and `:34` ("to be checked"), and `:40` (Orphanet OID "to be checked").
- **[3.3-2]** **Commented-out blocks:** `input/fsh/alias-ig.fsh:5` (a Laboratory `$server` alias), `:47`, `:49`; `input/fsh/examples/instances/vaccination.fsh:12`.
- **[3.3-3]** **Unused rulesets (9):** `sectionCareTeamRules` (`input/fsh/rulesSet/ruleSet-dr.fsh:8`), and `ImposeProfile`, `ExtensionContext`, `SetFmmAndStatusRuleInstance`, `SectionElementsRules`, `SectionCommonRules`, `NPUCopyrightForVS`, `NIBSCCopyrightForVS`, `ObligationElement` (`input/fsh/rulesSet/rulesSet-common.fsh`).
- **[3.3-4]** **Aliases:** 167 of 208 unused (mostly IPS, eHDSI and R5 cross-version aliases inherited from HDR and Laboratory). No duplicates found.

### 3.4 Terminology

- **[3.4-1]** All guide-specific artefacts use `SetFmmAndStatusRule (1, draft)` (15); obligation profiles use `(0, informative)` (24). This is consistent. HDR 1.0.0 uses `(2, trial-use)`: OK for a first draft.

---

## 4. Obligation profiles

No new findings. The obligation profiles are the same as in HDR 1.0.0, except for the renamed `sectionCourseOfEncounter` slice and the setting-neutral descriptions.

---

## 5. Examples

| ID | Sev | Location | Finding | Fix |
|---|---|---|---|---|
| 5-1 | Medium | `input/fsh/examples/instances/HDR-Luigi-De-Luca-example.fsh:149` | `714628002` "Prediabetes (finding)" is inactive in SNOMED CT and its display is rejected. The Encounter then fails Encounter (DR), and as a result the Bundle reports that the required `composition` and `encounter` slices are missing (3 errors). | Use the active display `Prediabetes`, or an active code for prediabetes. |
| 5-2 | Medium | `input/fsh/examples/instances/HDR-Fiona-Swart-example.fsh` | `bundle-swart`: the conditions in section 3 fail `condition-eu-core`, and the Bundle reports the composition slice as missing (5 errors). Cause: 1-1. | Re-check after 1-1. |
| 5-3 | Medium | `input/fsh/examples/instances/HDR-Petr-Novak-example.fsh:1019-1150,1473-1505` | 9 vital-sign and SDOH Observations (`ExampleBMI`, `ExampleBloodPressure`, …) have no `Usage`, so they are published as standalone examples as well as Bundle entries. Their generated narratives link to anchors in the Bundle page that do not exist (18 errors and 18 broken links). The other Novák resources are `#inline`. | Add `Usage: #inline` to these Observations. |
| 5-4 | Low | `input/fsh/examples/instances/HDR-Petr-Novak-example.fsh:1063` (Observation `6c626338-…`) | Warning: LOINC `56086-2` is a panel, not a value-bearing code. | Use the waist circumference code `8280-0`. |
| 5-5 | Low | `input/fsh/examples/instances/HDR-Fiona-Swart-example.fsh` | Warnings: `tobacco-swart` and `alcohol-swart` use SNOMED findings as `Observation.code`. Inherited from HDR. | Use observable entities (or the IPS LOINC codes `72166-2` and `74013-4`). |
| 5-6 | Low | `input/fsh/examples/instances/*.fsh` | 21 instances have no `Usage` (`alert.fsh`, `bodysite-laterality.fsh`, `device.fsh`, `medications.fsh`, `vaccination.fsh`, plus 5-3), and some ids still say `euhdr` (`example-deviceusestatement-euhdr`, `example-medicationstatement-euhdr`). | Set `Usage` explicitly; rename the ids with `dr` if links allow it. |
| 5-7 | Low | `input/fsh/examples/instances/HDR-*.fsh` | The hospital examples keep their HDR names and titles ("Bundle: HDR …"). Good for traceability, but the guide's own naming is "DR". | Keep as hospital examples, but say in their descriptions that they are hospital discharge reports; or rename them to `DR-Hospital-…`. |
| 5-8 | Low | — | Only one non-hospital example (emergency department). The scope page also lists day-care, rehabilitation and ambulatory reports. | Consider one more example (e.g. day-care), or say in `knownIssues.md` that it is planned. |

---

## 6. Narrative pages

### 6.1 `changes.md`

| ID | Sev | Line | Finding → Proposed |
|---|---|---|---|
| 6.1-1 | Medium | `input/pagecontent/changes.md:5-7` | Only says "first version". → Say that the guide is derived from HDR 1.0.0 and list the main differences: `Composition.type` bound to the Discharge Report Type value set, `sectionHospitalCourse` renamed `sectionCourseOfEncounter`, Encounter class value set extended (`EMER`, `AMB`, `HH`), setting-neutral texts, emergency department example, FMM 1 / draft. |

### 6.2 Stale ballot or preview wording

| ID | Location | Original | Proposed |
|---|---|---|---|
| 6.2-1 | `input/pagecontent/background.md:33` | "The EEHRxF will be defined by the European Commission through a set of Implementing Acts" | Check against the current state of the implementing acts; if they are adopted, use "is defined … through the Implementing Acts" with a link to the adopted text. |

### 6.3 Broken or inconsistent links

| ID | Sev | Location | Finding → Fix |
|---|---|---|---|
| 6.3-1 | High | `input/pagecontent/downloads.md` | See 1-3. |
| 6.3-2 | Medium | Novák Observation pages | See 5-3. |

### 6.4 Content inconsistencies

| ID | Sev | Location | Finding → Proposed |
|---|---|---|---|
| 6.4-1 | Low | `input/pagecontent/index.md`, `background.md` | HDR's paragraph "A result of a collaborative effort … 224 individual contributors from 29 countries" was removed. → Restore it if the content inherited from HDR should keep the acknowledgement, or confirm that the removal was intended. |
| 6.4-2 | Low | `input/pagecontent/crossversionanalysis.md:1-4` (working copy) | The "R4 vs R5 IG" section has been removed, but the change is not committed. → Confirm and commit, or revert. |

### 6.5 Language and editorial conventions

- **[6.5-1]** **Spelling.** Mixed: "organisation" ×12 and "organization" ×7. Use British English, except in FHIR resource and element names.
- **[6.5-2]** **Naming.** Consistent use of "Discharge Report" and "DR" in the guide's own texts. The HDR examples keep "HDR" (see 5-7).
- **[6.5-3]** **Punctuation.** No issues found.
- **[6.5-4]** **Markup.** Empty `<p>`/`<a>` elements and document-level tags in the mapping pages (`input/pagecontent/map-*.xml`, `modelmap.xml`), `authors.md:19`, `background.md:7`, `obligations.md:28`, `input/includes/composition-eu-dr-notes-shared.xml:6,33`. Mostly inherited from HDR; clean when convenient.

### 6.6 `knownIssues.md`: suggested additions

- **[6.6-1]** The eHDSI value set expansion problem (1-1), if it is still present when the guide is published.
- **[6.6-2]** The use of `fhir2.base.template#current` (2-1), if it is not pinned.
- **[6.6-3]** The double use of LOINC `18842-5` (3.2-1).

---

## 7. QA output and `ignoreWarnings.txt`

This section is based on the IG Publisher v3.0.4 run of 2026-11-19 19:33, built as `1.0.0-ci-build` / `draft` / `ci-build`.

**Visible messages:** 20452 errors, 4 warnings and 10 information messages.

| ID | Message | Resources | Fix |
|---|---|---|---|
| 7-1 | Value set `eHDSIIllnessandDisorder\|0.2.0` is not valid (ICD-10 version `2019-covid-expanded`) – 20424 errors | `400C-prescription-cefuroxime-singleline`, `example-covid19-vax-admin`, `condition-left-hip-osteoarthritis`, `bundle-swart` (×2), `HDR-Reijer-Wolff-Example` | See 1-1. |
| 7-2 | menu.xml `href='#'` on dropdown items | `fsh-generated/includes/menu.xml` | See 1-2. |
| 7-3 | Download links cannot be resolved (6) | `en/downloads.html` | See 1-3. |
| 7-4 | Hyperlinks to `Bundle-DischargeBundle-Novak-Petr-Subsections.html#urn-uuid-…` do not resolve (36) | 9 Novák Observations | See 5-3. |
| 7-5 | Inactive SNOMED display; Encounter and Composition slices not matched (4) | `HDR-Luigi-De-Luca-Example` | See 5-1. |
| 7-6 | Conditions do not match `condition-eu-core`; Composition slice not matched (5) | `bundle-swart` | See 5-2. |
| 7-7 | Warnings: finding codes used as `Observation.code` (2), LOINC panel with a value (1), outdated extensions package (1) | `bundle-swart`, Novák Observation, IG | See 5-4, 5-5, 2-5. |
| 7-8 | Information: SNOMED substance codes used as medication (Paracetamol, Cefazolin) | `HDR-Reijer-Wolff-Example` | Low: inherited from HDR. Use a medicinal product code if one is available. |

**Publication request check:** consistent with `sushi-config.yaml` (`1.0.0-ci-build`, `draft`, `STU 1`, `working`, `first: true`), but see 2-4.

**Suppressed messages:** 195 warnings and 670 hints.

**Suppressions that hide fixable issues:**

| ID | Lines | Entry (uses) | Fix |
|---|---|---|---|
| 7-9 | `input/ignoreWarnings.txt:91-98` | `No definition could be found for URL value '…'` for Czech, Dutch and other identifier systems (8 entries) | These entries have no justification comment of their own: lines 91–93 sit under the "known non-matching slices" comment, and lines 94–98 have none. Add a comment (identifier systems not registered; nothing to fix in this guide). |
| 7-10 | blanket ids | `NO_VALID_DISPLAY_FOUND_NONE_FOR_LANG_OK` (33), `Terminology_TX_NoValid_3_CC` (28), `TYPE_SPECIFIC_CHECKS_DT_CANONICAL_MULTIPLE_POSSIBLE_VERSIONS` (90) | These suppress every occurrence. They are the same as in HDR 1.0.0; narrow them if new examples are added. |

**Stale entries** (0 uses in the 19:33 run, safe to delete), by line in `ignoreWarnings.txt`:

- **[7-11]** L7 `bdl-dr-2: Found a use of a collection operator…` (FHIRPath false positive no longer reported).
- **[7-12]** L10 `Unknown code 'system' in the CodeSystem 'http://hl7.org/fhir/examplescenario-actor-type'`.
- **[7-13]** L78 `%This element does not match any known slice … deviceUseStatement-eu-dr%`.
- **[7-14]** L117 `MSG_DRAFT`.
- **[7-15]** L134 `The html source has duplicate anchor Ids: 3f85726c-…`.
- **[7-16]** L138 `Error from https://tx.fhir.org/r4: … 'https://www.orpha.net' could not be found`.

---

## 8. Repository hygiene

- **[8-1]** **Uncommitted working copy:** `ig-template/package/package.json` (template v2), `input/ignoreWarnings.txt`, `FHIR-eu-discharge-report.xml` (see 2-3), `input/pagecontent/crossversionanalysis.md` (see 6.4-2), and the deletion of `input/fsh/examples/instances/HDR-Paolo-Marcheschi-example.fsh`. No page links to the Marcheschi example any more. Confirm the deletion is intended (it was the Italian-language example) and commit these changes in coherent commits.
- **[8-2]** `reviews/dr-scope-todo.md` is a to-do file in the repository. Move its open points to `knownIssues.md` or an issue tracker, then delete it.

---

## 9. Suggested order of work

1. Decide how to handle the eHDSI value set errors (1-1), then rebuild to see the real error list.
2. Fix the issues caused by the template switch: menu (1-2), download links (1-3), and check the rendered look (2-2).
3. Fix the examples (5-1, 5-3), then re-check 5-2.
4. Restore the Jira spec URLs (2-3), commit the working copy (8-1), and pin or document the template version (2-1).
5. `changes.md` (6.1-1) and the `knownIssues.md` additions (§6.6).
6. Clean up `ignoreWarnings.txt` (7-9, 7-11 to 7-16) after a clean build.
7. Cleanup: §3.3, 2-7, 5-4 to 5-8, §6.5, 8-2.

---

## Won't fix (accepted)

No items yet.

---

## Fixed since the first review

Not applicable (first review).
