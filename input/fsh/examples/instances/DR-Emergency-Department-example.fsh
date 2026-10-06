// ===========================================================================
// Emergency Department Discharge Report example
// Illustrates a discharge report produced at the end of an encounter that is
// not an inpatient hospital stay (encounter class EMER, document type 59258-4).
// ===========================================================================
Instance: DR-Emergency-Department-Example
InstanceOf: BundleEuDr
Title: "Bundle: Emergency Department Discharge Report, Chest Pain"
Description: "HL7 FHIR Bundle example of an Emergency Department Discharge Report (HL7 Europe Discharge Report) for Maria Rossi, discharged home after an emergency department visit for chest pain."
Usage: #example

* language = #en
* type = #document

* identifier[+].type = $v2-0203#PRN
* identifier[=].system = "http://example.org/eu/identifier"
* identifier[=].value = "98590868-f0bc-4588-9773-741ceb782884"

* timestamp = "2026-03-14T23:10:00+01:00"

* entry[composition].fullUrl = "urn:uuid:5bb06169-8614-401b-806b-1e991e44693f"
* entry[=].resource = composition-dr-ed-example

* entry[patient].fullUrl = "urn:uuid:79d8f1c5-636a-4285-9cc5-e9f077d851e9"
* entry[=].resource = patient-ed-example

* entry[+].fullUrl = "urn:uuid:5ae85f20-b911-4021-8c80-59ae1e867ae9"
* entry[=].resource = practitioner-ed-author

* entry[+].fullUrl = "urn:uuid:ca6878b7-8435-422b-bb41-5369c3b17dec"
* entry[=].resource = organization-ed-hospital

* entry[+].fullUrl = "urn:uuid:fb9045d9-8458-4fbd-a586-81a0a493537b"
* entry[=].resource = encounter-ed-example

* entry[+].fullUrl = "urn:uuid:b33f1e71-268e-4cae-912f-3d2262b29dc0"
* entry[=].resource = condition-ed-chest-pain

* entry[+].fullUrl = "urn:uuid:46610ccc-7172-4c45-9a31-9e83c77398a8"
* entry[=].resource = procedure-ed-ecg

Instance: composition-dr-ed-example
InstanceOf: CompositionEuDr
Title: "Composition: Emergency Department Discharge Report, Chest Pain"
Description: "HL7 FHIR Composition example of an Emergency Department Discharge Report (HL7 Europe Discharge Report) for Maria Rossi."
Usage: #inline
* id = "5bb06169-8614-401b-806b-1e991e44693f"
* language = #en
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:6aa3441e-22f0-487b-87bf-dd6cecafa25d"
* status = #final
* type = $loinc#59258-4 "Emergency department Discharge summary"
* subject = Reference(urn:uuid:79d8f1c5-636a-4285-9cc5-e9f077d851e9)
* encounter = Reference(urn:uuid:fb9045d9-8458-4fbd-a586-81a0a493537b)
* date = "2026-03-14T23:00:00+01:00"
* author = Reference(urn:uuid:5ae85f20-b911-4021-8c80-59ae1e867ae9)
* title = "Emergency Department Discharge Report"
* custodian = Reference(urn:uuid:ca6878b7-8435-422b-bb41-5369c3b17dec)
//
// Diagnostic summary
//
* section[sectionDiagnosticSummary].title = "Diagnostic summary"
* section[=].code = $loinc#11535-2 "Hospital discharge diagnosis note"
* section[=].text.status = #generated
* section[=].text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <p>Chest pain, unspecified. Acute coronary syndrome ruled out.</p>
</div>
"""
* section[=].entry[+] = Reference(urn:uuid:b33f1e71-268e-4cae-912f-3d2262b29dc0)
//
// Course of encounter
//
* section[sectionCourseOfEncounter].title = "Course in the emergency department"
* section[=].code = $loinc#8648-8 "Hospital course note"
* section[=].text.status = #generated
* section[=].text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <p>The patient presented at 18:40 with left-sided chest pain that started two hours earlier at rest,
  not radiating and not related to exertion. Vital signs were within normal limits. A 12-lead ECG showed
  sinus rhythm without ischaemic changes. High-sensitivity troponin was negative at presentation and
  after three hours. The pain resolved after oral paracetamol. The patient was observed for four hours
  and discharged home in good condition.</p>
</div>
"""
//
// Significant procedures
//
* section[sectionSignificantProcedures].title = "Procedures"
* section[=].code = $loinc#10185-7 "Hospital discharge procedure note"
* section[=].text.status = #generated
* section[=].text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <p>12-lead electrocardiogram (14 March 2026): sinus rhythm, no ischaemic changes.</p>
</div>
"""
* section[=].entry[+] = Reference(urn:uuid:46610ccc-7172-4c45-9a31-9e83c77398a8)
//
// Discharge medications
//
* section[sectionDischargeMedications].title = "Discharge medications"
* section[=].code = $loinc#75311-1 "Discharge medications note"
* section[=].text.status = #generated
* section[=].text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <p>Paracetamol 1 g orally, if needed for pain, up to three times a day, for a maximum of five days (new).
  Usual home medication unchanged.</p>
</div>
"""
//
// Plan of care
//
* section[sectionPlanOfCare].title = "Recommendations"
* section[=].code = $loinc#18776-5 "Plan of care note"
* section[=].text.status = #generated
* section[=].text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <p>Follow-up with the general practitioner within one week; outpatient exercise stress test to be considered.
  Return to the emergency department immediately in case of recurrent or worsening chest pain,
  shortness of breath or fainting.</p>
</div>
"""
//
// Discharge details
//
* section[sectionDischargeDetails].title = "Discharge details"
* section[=].code = $loinc#8650-4 "Hospital discharge disposition note"
* section[=].text.status = #generated
* section[=].text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <p>Discharged home on 14 March 2026 at 22:50, in good general condition and pain-free.</p>
</div>
"""

Instance: patient-ed-example
InstanceOf: PatientEuCore
Title: "Patient: Maria Rossi"
Description: "Patient Maria Rossi, subject of the Emergency Department Discharge Report example."
Usage: #inline
* id = "79d8f1c5-636a-4285-9cc5-e9f077d851e9"
* language = #en
* identifier[+].type = $v2-0203#NI
* identifier[=].system = "https://hl7europe.org/example-identifier"
* identifier[=].value = "RSSMRA71C52H501Z"
* name[+].family = "Rossi"
* name[=].given[+] = "Maria"
* name[=].text = "Maria Rossi"
* gender = #female
* birthDate = "1971-03-12"
* address[+].use = #home
* address[=].type = #physical
* address[=].line[+] = "Via Roma 10"
* address[=].city = "Pisa"
* address[=].postalCode = "56126"
* address[=].country = "IT"

Instance: practitioner-ed-author
InstanceOf: PractitionerEuCore
Title: "Practitioner: dr Luca Bianchi (author)"
Description: "Emergency physician, author of the Emergency Department Discharge Report example."
Usage: #inline
* id = "5ae85f20-b911-4021-8c80-59ae1e867ae9"
* language = #en
* name.prefix = "dr"
* name.given = "Luca"
* name.family = "Bianchi"
* telecom.system = #email
* telecom.value = "luca.bianchi@example.org"

Instance: organization-ed-hospital
InstanceOf: OrganizationEuCore
Title: "Organization: Example General Hospital"
Description: "Hospital whose emergency department issued the Emergency Department Discharge Report example."
Usage: #inline
* id = "ca6878b7-8435-422b-bb41-5369c3b17dec"
* language = #en
* name = "Example General Hospital - Emergency Department"
* address.city = "Pisa"
* address.postalCode = "56124"
* address.country = "IT"

Instance: encounter-ed-example
InstanceOf: EncounterEuDr
Title: "Encounter: Emergency department visit, Maria Rossi"
Description: "Emergency department encounter for chest pain, ended with discharge home."
Usage: #inline
* id = "fb9045d9-8458-4fbd-a586-81a0a493537b"
* language = #en
* status = #finished
* class = $v3-ActCode#EMER "emergency"
* priority = $v3-ActPriority#EM "emergency"
* subject = Reference(urn:uuid:79d8f1c5-636a-4285-9cc5-e9f077d851e9)
* period.start = "2026-03-14T18:40:00+01:00"
* period.end = "2026-03-14T22:50:00+01:00"
* reasonReference = Reference(urn:uuid:b33f1e71-268e-4cae-912f-3d2262b29dc0)
* hospitalization.dischargeDisposition = $discharge-disposition#home "Home"
* serviceProvider = Reference(urn:uuid:ca6878b7-8435-422b-bb41-5369c3b17dec)

Instance: condition-ed-chest-pain
InstanceOf: ConditionEuCore
Title: "Condition: Chest Pain"
Description: "Condition representing chest pain, the reason for the emergency department visit."
Usage: #inline
* id = "b33f1e71-268e-4cae-912f-3d2262b29dc0"
* language = #en
* clinicalStatus = $condition-clinical#resolved
* code.coding[+] = $sct#29857009 "Chest pain (finding)"
* code.coding[+] = $icd10#R07.4 "Chest pain, unspecified"
* subject = Reference(urn:uuid:79d8f1c5-636a-4285-9cc5-e9f077d851e9)
* onsetDateTime = "2026-03-14T16:30:00+01:00"

Instance: procedure-ed-ecg
InstanceOf: ProcedureEuCore
Title: "Procedure: Electrocardiogram"
Description: "Procedure representing the 12-lead electrocardiogram performed in the emergency department."
Usage: #inline
* id = "46610ccc-7172-4c45-9a31-9e83c77398a8"
* language = #en
* status = #completed
* code = $sct#29303009 "Electrocardiographic procedure (procedure)"
* subject = Reference(urn:uuid:79d8f1c5-636a-4285-9cc5-e9f077d851e9)
* performedDateTime = "2026-03-14T18:55:00+01:00"
