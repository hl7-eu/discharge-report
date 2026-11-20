# HL7 Europe Discharge Report – Consistency Review for 1.0.0-ci-build (first draft)

- **Date:** 2026-11-20. Last updated after the fixes for §1, §2, 5-1 and the IG Publisher run of 2026-11-20 06:50. Items that have been fixed have been removed; they are listed under *Fixed since the first review* at the end of the report.
- **Scope:** FSH sources (`input/fsh`), narrative pages (`input/pagecontent`, `input/includes`), configuration (`sushi-config.yaml`, `publication-request.json`, `ig.ini`), the local template (`ig-template`), examples, the latest IG Publisher QA output (`output/qa.*`) and `input/ignoreWarnings.txt`.
- **Build status:**
  - SUSHI ran as part of the Publisher build; its error and warning counts were not captured separately in this review.
  - The IG Publisher 3.0.5 run of 2026-11-20 06:50 was built as `hl7.fhir.eu.discharge-report#1.0.0-ci-build`, status `draft`, release label `ci-build`. It includes all commits up to `c09b852` plus the working copy (fixes for 1-1 to 1-3, 2-1, 2-2, 2-5, 2-7 and 5-1, and the aliases copied from HDR). None of these changes is committed yet.
  - It reports **20480 errors, 234 warnings and 8 information messages**, plus 195 suppressed warnings and 21090 suppressed hints. 20424 of the errors are still the terminology problem of 1-1; 33 errors and 231 warnings are new and come from the pinned template (1-4).

Severity: **High** means fix before publication. **Medium** means it should be fixed for 1.0.0-ci-build. **Low** means cleanup or editorial.

File references are relative to the repository root. Line numbers are those of the current working copy.

Each open item has an id `<section>-<n>` (e.g. `3.1-2`). Ids are stable: fixed or accepted items keep their id when they move to *Won't fix (accepted)* or *Fixed since the first review*, and new items get the next free number.

---

## 1. Release blockers (High)

| ID | Area | Finding | Fix |
|---|---|---|---|
| 1-1 | QA / terminology | Still 20424 errors: the eHDSI value set `eHDSIIllnessandDisorder\|0.2.0` (from the EU Base bindings) cannot be expanded, because its ICD-10 codes (e.g. `I70.20`) are not in `http://hl7.org/fhir/sid/icd-10\|2019-covid-expanded`. The suppression added in `input/ignoreWarnings.txt:153-157` matches the messages but does not remove them: the Publisher does not suppress errors. The errors also make `condition-meerling` and `condition-growth` fail `condition-eu-core` (5-2). | Report it to the EU Base / eHDSI maintainers (the codes are not in the WHO ICD-10) and check whether HDR 1.0.0 now shows the same errors. Delete the ineffective suppression, and describe the problem in `knownIssues.md` (6.6-1) if it is still there at publication. |
| 1-4 | Template | **New:** `fhir2.base.template#0.1.0`, pinned for 2-1, produces 33 errors and 231 warnings that the `current` template did not produce. Its `layouts/layout-profile-history.html:13-14` writes a second, unclosed `<h2 id="root">`, so each profile's *Change History* page has two top-level headings (33 errors), duplicate ids and malformed HTML (198 warnings). Its `layouts/layout-profile.html:395-396` and `layout-ext.html:266-267` write a stray `</p>` on each profile page (33 warnings). | Go back to `fhir2.base.template#current` in `ig-template/package/package.json` and document the choice (6.6-2), until a release newer than 0.1.0 is published. Then check the rendered look (header, menu, footer, search). |

---

## 2. Configuration and publication

| ID | Sev | Location | Finding | Fix |
|---|---|---|---|---|
| 2-1 | Medium | `ig-template/package/package.json:9` | The template is now pinned to `fhir2.base.template` 0.1.0, the only release (2025-07-05), but that release does not work with the current Publisher: see 1-4. | Follow 1-4. Pin again once a working release is published. |
| 2-4 | Medium | `sushi-config.yaml:7,10`, `publication-request.json` | Version `1.0.0-ci-build` and release label `ci-build` are fine for CI, but not for a publication: the publication request would publish at `…/1.0.0-ci-build`. | Before publishing, choose the release version and label (e.g. `0.1.0` / `ballot` or `draft`) and update both files together. |
| 2-6 | Low | `sushi-config.yaml` | `hl7.terminology.r4` is not pinned; the Publisher resolves it. | Pin it, or note the resolved version in `knownIssues.md`. |

---

## 3. Profiles (FSH)

### 3.1 Composition sections vs Bundle entry slices

No open items (3.1-1 and 3.1-2 accepted, see *Won't fix (accepted)*).

### 3.2 Invariants

| ID | Sev | Location | Finding | Fix |
|---|---|---|---|---|
| 3.2-1 | Low | `input/fsh/profiles/composition-dr.fsh:22,426` | LOINC `18842-5` is now both the generic document type (`Composition.type`) and the code of the Discharge summary section that `cmp-dr-2` checks. That is valid, but it can confuse readers. | Add a sentence to the Composition notes or `knownIssues.md`. |

### 3.3 Leftovers in FSH

- **[3.3-1]** **Stale TODO comments:** `input/fsh/alias-systems.fsh:3` ("Temporary canonical"), `:31` and `:34` ("to be checked"), and `:40` (Orphanet OID "to be checked").
- **[3.3-2]** **Commented-out blocks:** `input/fsh/alias-ig.fsh:5` (a Laboratory `$server` alias, now with the HDR suffix `-eu-hdr` after the copy from HDR), `:47`, `:49`; `input/fsh/examples/instances/vaccination.fsh:12`.
- **[3.3-3]** **Unused rulesets (9):** `sectionCareTeamRules` (`input/fsh/rulesSet/ruleSet-dr.fsh:8`), and `ImposeProfile`, `ExtensionContext`, `SetFmmAndStatusRuleInstance`, `SectionElementsRules`, `SectionCommonRules`, `NPUCopyrightForVS`, `NIBSCCopyrightForVS`, `ObligationElement` (`input/fsh/rulesSet/rulesSet-common.fsh`).
- **[3.3-4]** **Aliases:** 167 of 208 unused (mostly IPS, eHDSI and R5 cross-version aliases). The alias files are now the same as HDR 1.0.0's; no duplicates found.

### 3.4 Terminology

- **[3.4-1]** All guide-specific artefacts use `SetFmmAndStatusRule (1, draft)` (15); obligation profiles use `(0, informative)` (24). This is consistent. HDR 1.0.0 uses `(2, trial-use)`: OK for a first draft.

---

## 4. Obligation profiles

No new findings. The obligation profiles are the same as in HDR 1.0.0, except for the renamed `sectionCourseOfEncounter` slice and the setting-neutral descriptions.

---

## 5. Examples

| ID | Sev | Location | Finding | Fix |
|---|---|---|---|---|
| 5-2 | Medium | `input/fsh/examples/instances/HDR-Fiona-Swart-example.fsh` | `bundle-swart`: the conditions in section 3 fail `condition-eu-core`, and the Bundle reports the composition slice as missing (5 errors). Cause: 1-1. | Re-check after 1-1. |
| 5-3 | Medium | `input/fsh/examples/instances/HDR-Petr-Novak-example.fsh:1019-1150,1473-1505` | 9 vital-sign and SDOH Observations (`ExampleBMI`, `ExampleBloodPressure`, …) have no `Usage`, so they are published as standalone examples as well as Bundle entries. Their generated narratives link to anchors in the Bundle page that do not exist (36 errors, 18 broken links). The other Novák resources are `#inline`. | Add `Usage: #inline` to these Observations. |
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
| 6.1-1 | Medium | `input/pagecontent/changes.md:5` | Only says "first version". → Say that the guide is derived from HDR 1.0.0 and list the main differences: `Composition.type` bound to the Discharge Report Type value set, `sectionHospitalCourse` renamed `sectionCourseOfEncounter`, Encounter class value set extended (`EMER`, `AMB`, `HH`), setting-neutral texts, emergency department example, FMM 1 / draft. |

### 6.2 Stale ballot or preview wording

| ID | Location | Original | Proposed |
|---|---|---|---|
| 6.2-1 | `input/pagecontent/background.md:33` | "The EEHRxF will be defined by the European Commission through a set of Implementing Acts" | Check against the current state of the implementing acts; if they are adopted, use "is defined … through the Implementing Acts" with a link to the adopted text. |

### 6.3 Broken or inconsistent links

| ID | Sev | Location | Finding → Fix |
|---|---|---|---|
| 6.3-2 | Medium | Novák Observation pages | See 5-3. |

### 6.4 Content inconsistencies

| ID | Sev | Location | Finding → Proposed |
|---|---|---|---|
| 6.4-1 | Low | `input/pagecontent/index.md`, `background.md` | HDR's paragraph "A result of a collaborative effort … 224 individual contributors from 29 countries" was removed. → Restore it if the content inherited from HDR should keep the acknowledgement, or confirm that the removal was intended. |

### 6.5 Language and editorial conventions

- **[6.5-1]** **Spelling.** Mixed: "organisation" ×12 and "organization" ×7. Use British English, except in FHIR resource and element names.
- **[6.5-2]** **Naming.** Consistent use of "Discharge Report" and "DR" in the guide's own texts. The HDR examples keep "HDR" (see 5-7).
- **[6.5-3]** **Punctuation.** No issues found.
- **[6.5-4]** **Markup.** Empty `<p>`/`<a>` elements and document-level tags in the mapping pages (`input/pagecontent/map-*.xml`, `modelmap.xml`), `authors.md:19`, `background.md:7`, `obligations.md:28`, `input/includes/composition-eu-dr-notes-shared.xml:6,33`. Mostly inherited from HDR; clean when convenient.

### 6.6 `knownIssues.md`: suggested additions

- **[6.6-1]** The eHDSI value set expansion problem (1-1), if it is still present when the guide is published.
- **[6.6-2]** The use of `fhir2.base.template#current` (1-4, 2-1), if it is not pinned.
- **[6.6-3]** The double use of LOINC `18842-5` (3.2-1).

---

## 7. QA output and `ignoreWarnings.txt`

This section is based on the IG Publisher 3.0.5 run of 2026-11-20 06:50, built as `1.0.0-ci-build` / `draft` / `ci-build`.

**Visible messages:** 20480 errors, 234 warnings and 8 information messages.

| ID | Message | Resources | Fix |
|---|---|---|---|
| 7-1 | Value set `eHDSIIllnessandDisorder\|0.2.0` is not valid (ICD-10 version `2019-covid-expanded`) – 20424 errors | `400C-prescription-cefuroxime-singleline`, `example-covid19-vax-admin`, `condition-left-hip-osteoarthritis`, `bundle-swart` (×2), `HDR-Reijer-Wolff-Example` | See 1-1. |
| 7-4 | Hyperlinks to `Bundle-DischargeBundle-Novak-Petr-Subsections.html#urn-uuid-…` do not resolve (36) | 9 Novák Observations | See 5-3. |
| 7-6 | Conditions do not match `condition-eu-core`; Composition slice not matched (5) | `bundle-swart` | See 5-2. |
| 7-7 | Warnings: finding codes used as `Observation.code` (2), LOINC panel with a value (1) | `bundle-swart`, Novák Observation | See 5-4, 5-5. |
| 7-8 | Information: SNOMED substance codes used as medication (Paracetamol, Cefazolin) | `HDR-Reijer-Wolff-Example` | Low: inherited from HDR. Use a medicinal product code if one is available. |
| 7-17 | **New:** "The page has more than one top level heading" (33 errors); malformed HTML and duplicate id `root` (198 warnings) on `*.profile.history.html`; malformed HTML (`</p>`) on the profile pages (33 warnings) | 33 profiles (`output/en/StructureDefinition-*`) | See 1-4. |

**Publication request check:** consistent with `sushi-config.yaml` (`1.0.0-ci-build`, `draft`, `STU 1`, `working`, `first: true`), but see 2-4.

**Suppressed messages:** 195 warnings and 21090 hints (20424 of the hints are the eHDSI messages of 1-1, which are still also counted as errors).

**Suppressions that hide fixable issues:**

| ID | Lines | Entry (uses) | Fix |
|---|---|---|---|
| 7-9 | `input/ignoreWarnings.txt:91-98` | `No definition could be found for URL value '…'` for Czech, Dutch and other identifier systems (8 entries) | These entries have no justification comment of their own: lines 91–93 sit under the "known non-matching slices" comment, and lines 94–98 have none. Add a comment (identifier systems not registered; nothing to fix in this guide). |
| 7-10 | `input/ignoreWarnings.txt:101-113` | Blanket ids: `TYPE_SPECIFIC_CHECKS_DT_CANONICAL_MULTIPLE_POSSIBLE_VERSIONS` (90), `Terminology_TX_NoValid_3_CC` (26), `NO_VALID_DISPLAY_FOUND_NONE_FOR_LANG_OK` (22), `PIN_VERSION` (2), `MSG_DEPENDS_ON_DEPRECATED_NOTE` (2) | These suppress every occurrence. They are the same as in HDR 1.0.0; narrow them if new examples are added. |
| 7-18 | `input/ignoreWarnings.txt:153-157` | **New:** `%The value set '…eHDSIIllnessandDisorder\|0.2.0' is not valid%` (20424) | Ineffective: the messages are errors and stay visible. Delete it (see 1-1). |

**Stale entries** (0 uses in the 06:50 run, safe to delete), by line in `ignoreWarnings.txt`:

- **[7-11]** L7 `bdl-dr-2: Found a use of a collection operator…` (FHIRPath false positive no longer reported).
- **[7-12]** L10 `Unknown code 'system' in the CodeSystem 'http://hl7.org/fhir/examplescenario-actor-type'`.
- **[7-13]** L78 `%This element does not match any known slice … deviceUseStatement-eu-dr%`.
- **[7-14]** L117 `MSG_DRAFT`.
- **[7-15]** L134 `The html source has duplicate anchor Ids: 3f85726c-…`.
- **[7-16]** L138 `Error from https://tx.fhir.org/r4: … 'https://www.orpha.net' could not be found`.

---

## 8. Repository hygiene

- **[8-2]** `reviews/dr-scope-todo.md` is a to-do file in the repository. Move its open points to `knownIssues.md` or an issue tracker, then delete it.

---

## 9. Suggested order of work

1. Go back to the `current` template (1-4, 2-1), rebuild and check the rendered look.
2. Report the eHDSI value set problem and delete the ineffective suppression (1-1, 7-18); re-check 5-2 afterwards.
3. Fix the Novák Observations (5-3).
4. Commit the working copy in coherent commits.
5. `changes.md` (6.1-1) and the `knownIssues.md` additions (§6.6).
6. Clean up `ignoreWarnings.txt` (7-9, 7-11 to 7-16) after a clean build.
7. Before publication: release version and label (2-4), `hl7.terminology.r4` (2-6).
8. Cleanup: §3.3, 3.2-1, 5-4 to 5-8, 6.2-1, 6.4-1, §6.5, 8-2.

---

## Won't fix (accepted)

Items reviewed and accepted as they are. They keep their id and the structure of the section they come from; the last column gives the rationale.

| ID | Sev | Location | Finding | Rationale |
|---|---|---|---|---|
| 3.1-1 | Low | `input/fsh/profiles/composition-dr.fsh`, `bundle-dr.fsh` | Sections reference `ClinicalImpression` and `QuestionnaireResponse`, but the Bundle has no entry slice for them. | Inherited unchanged from HDR 1.0.0; kept as in HDR. |
| 3.1-2 | Low | `input/fsh/profiles/composition-dr.fsh` | 6 sections have no entry constraint (Admission evaluation, Discharge summary, Course of encounter, Synthesis, Patient history, Discharge details), so any resource is allowed. | Inherited unchanged from HDR 1.0.0; kept as in HDR. |

---

## Fixed since the first review

**Commits `e3a0d06`, `6c83437`, `ee752c4`** (made together with the first review):

- 8-1: the template switch, the `ignoreWarnings.txt` alignment with HDR 1.0.0, the deletion of the Marcheschi example and the removal of the R4 vs R5 section are committed.
- 6.4-2: the "R4 vs R5 IG" section of `crossversionanalysis.md` is removed (`ee752c4`).

**Working copy, not yet committed** (confirmed by the 06:50 run):

- 1-2 (and 7-2): `input/includes/menu.xml` replaces the SUSHI menu, with `href="menu.html"` on the dropdown toggles, and the new page `input/pagecontent/menu.md` is listed in `sushi-config.yaml`. The menu error is gone.
- 1-3 (and 6.3-1, 7-3): the links in `input/pagecontent/downloads.md` start with `../`. No broken download links are reported.
- 2-2: `ig-template/README.md` describes this template; `ig-template/package-list.json` has the Discharge Report canonical and CI URL. The check of the rendered look moves to 1-4.
- 2-3: `FHIR-eu-discharge-report.xml` restored to the committed version (`ciUrl` and `gitUrl` set, no `1.0.0-ci-build` entry); nothing to commit.
- 2-5 (part of 7-7): `hl7.fhir.uv.extensions.r4` updated to 5.4.0 in `sushi-config.yaml`; the outdated-package warning is gone. HDR 1.0.0 still uses 5.3.0.
- 2-7: SUSHI template comments and commented-out Laboratory / eHN entries removed from `sushi-config.yaml`.
- 5-1 (and 7-5): the code `714628002` is active in SNOMED CT; only its display was wrong. The display is now `Prediabetes` (`input/fsh/examples/instances/HDR-Luigi-De-Luca-example.fsh:149`). The Encounter, Composition and Bundle slice errors are gone.

**Attempted, not effective:**

- 1-1: the suppression in `input/ignoreWarnings.txt:153-157` does not hide the errors (see 1-1, 7-18).
- 2-1: the pin to `fhir2.base.template#0.1.0` causes new errors (see 1-4).
