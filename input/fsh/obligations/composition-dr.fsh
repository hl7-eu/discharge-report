Profile: CompositionEuDrObligation
Parent: CompositionEuDr
Id: composition-obl-eu-dr
Title: "Composition: obligations"
Description: "This profile defines obligations for a Discharge Report (DR) for the scope of this guide."

* insert SetFmmAndStatusRule ( 0, informative)

// Header
* identifier insert OblShallPopulateShouldDisplayShallProcess
* status insert OblShallPopulateShallDisplay
* type insert OblShallPopulateOnly
* category insert OblShallPopulateOnly
* subject only Reference(PatientEuDrObligation)
* subject insert OblShallPopulateShallDisplayProcess
* encounter only Reference(EncounterEuDrObligation)
* encounter insert OblShallPopulateShallProcess
* date insert OblShallPopulateShallDisplay
* author only Reference(PractitionerEuDrObligation or PractitionerRoleEuDrObligation or DeviceEuDrObligation or OrganizationEuDrObligation)
* author insert OblShallPopulateShallDisplay
* title insert OblShallPopulateOnly
* language insert OblShallPopulateOnly
* event.period insert OblShallPopulateOnly
* custodian insert OblShallPopulateOnly
* attester insert OblShallPopulateShallDisplay
* attester.mode insert OblShallPopulateOnly
* attester.time insert OblShallPopulateOnly
* attester.party only Reference(PractitionerEuDrObligation or PractitionerRoleEuDrObligation or OrganizationEuDrObligation)
* attester.party insert OblShallPopulateShallDisplay
* extension[informationRecipient].valueReference only Reference(PractitionerRoleEuDrObligation or PractitionerEuDrObligation or DeviceEuDrObligation or PatientEuDrObligation or RelatedPersonEuDrObligation or OrganizationEuDrObligation)

// Presented form is part of the EHDS logical model, but the corresponding
// Composition extension is not currently enabled in CompositionEuDr.

// Body
* section insert OblShallPopulateShallProcess
* section.text insert OblShouldPopulateShallProcess

// body.alerts
* section[sectionAlert] insert OblShouldPopulateShouldProcess
  * text insert OblShouldPopulateShallProcess
  * entry only Reference(FlagEuDrObligation or DocumentReference)
  * entry insert OblShouldPopulateShallProcess
  * entry[flag] only Reference(FlagEuDrObligation)
  * entry[flag] insert OblShouldPopulateShallProcess

// body.encounterInformation
// Represented by Composition.encounter plus EncounterEuDrObligation.

// body.admissionEvaluation
* section[sectionAdmissionEvaluation] insert OblShallPopulateShallProcess
  * text insert OblShouldPopulateShallProcess
  * extension[section-note] insert OblShouldPopulateShallProcess

* section[sectionPhysicalFindings] insert OblShouldPopulateShallProcess
  * entry only Reference(ObservationEuDrObligation or DocumentReference)
  * entry insert OblShouldPopulateShallProcess

* section[sectionFunctionalStatus] insert OblShouldPopulateShallProcess
  * entry only Reference(ConditionEuDrObligation or ClinicalImpression or ObservationEuDrObligation or DocumentReference or QuestionnaireResponse)
  * entry insert OblShouldPopulateShallProcess
  * entry[condition] only Reference(ConditionEuDrObligation)
  * entry[condition] insert OblShouldPopulateShallProcess
  * entry[observation] only Reference(ObservationEuDrObligation)
  * entry[observation] insert OblShouldPopulateShallProcess

// body.patientHistory
* section[sectionPatientHx] insert OblShouldPopulateShallProcess
  * text insert OblShouldPopulateShallProcess
  * extension[section-note] insert OblShouldPopulateShallProcess

* section[sectionProblems] insert OblShouldPopulateShallProcess
  * entry only Reference(ConditionEuDrObligation or DocumentReference)
  * entry insert OblShouldPopulateShallProcess
  * entry[problem] only Reference(ConditionEuDrObligation)
  * entry[problem] insert OblShouldPopulateShallProcess

* section[sectionMedicalDevices] insert OblShouldPopulateShallProcess
  * entry only Reference(DeviceUseStatementEuDrObligation or ProcedureEuDrObligation or DocumentReference)
  * entry insert OblShouldPopulateShallProcess
  * entry[deviceStatement] only Reference(DeviceUseStatementEuDrObligation)
  * entry[deviceStatement] insert OblShouldPopulateShallProcess

* section[sectionProceduresHx] insert OblShouldPopulateShallProcess
  * entry only Reference(ProcedureEuDrObligation or DocumentReference)
  * entry insert OblShouldPopulateShallProcess
  * entry[procedure] only Reference(ProcedureEuDrObligation)
  * entry[procedure] insert OblShouldPopulateShallProcess

// body.courseOfEncounter
* section[sectionCourseOfEncounter] insert OblShallPopulateShallProcess
  * text insert OblShouldPopulateShallProcess
  * extension[section-note] insert OblShouldPopulateShallProcess

* section[sectionDiagnosticSummary] insert OblShouldPopulateShallProcess
  * entry only Reference(ConditionEuDrObligation)
  * entry insert OblShouldPopulateShallProcess

* section[sectionSignificantProcedures] insert OblShouldPopulateShallProcess
  * entry only Reference(ProcedureEuDrObligation)
  * entry insert OblShouldPopulateShallProcess

* section[sectionImplantedDevices] insert OblShouldPopulateShallProcess
  * entry only Reference(DeviceUseStatementEuDrObligation or ProcedureEuDrObligation)
  * entry insert OblShouldPopulateShallProcess

* section[sectionPharmacotherapy] insert OblShouldPopulateShallProcess
  * entry only Reference(MedicationStatementEuDrObligation or MedicationRequestEuDrObligation or MedicationDispenseEuDrObligation or MedicationAdministrationEuDrObligation)
  * entry insert OblShouldPopulateShallProcess
  * entry[medicationStatement] only Reference(MedicationStatementEuDrObligation)
  * entry[medicationStatement] insert OblShouldPopulateShallProcess

* section[sectionSignificantResults] insert OblShouldPopulateShallProcess
  * entry only Reference(ObservationEuDrObligation or LaboratoryObservationEuDrObligation or DiagnosticReport or DocumentReference)
  * entry insert OblShouldPopulateShallProcess
  * entry[results-medicalTestResult] only Reference(LaboratoryObservationEuDrObligation)
  * entry[results-medicalTestResult] insert OblShouldPopulateShallProcess
  * entry[results-diagnosticReport] only Reference(DiagnosticReportEuCore)
  * entry[results-diagnosticReport] insert OblShouldPopulateShallProcess

// body.dischargeDetails
* section[sectionDischargeDetails] insert OblShouldPopulateShallProcess
  * text insert OblShouldPopulateShallProcess
  * extension[section-note] insert OblShouldPopulateShallProcess

// body.medicationSummary
* section[sectionDischargeMedications] insert OblShallPopulateShallProcess
  * text insert OblShouldPopulateShallProcess
  * entry only Reference(MedicationRequestEuDrObligation or MedicationDispenseEuDrObligation or MedicationStatementEuDrObligation)
  * entry insert OblShallPopulateShallProcess
  * extension[section-note] insert OblShouldPopulateShallProcess

// body.carePlan
* section[sectionPlanOfCare] insert OblShouldPopulateShallProcess
  * text insert OblShouldPopulateShallProcess
  * entry only Reference(CarePlanEuDrObligation or DocumentReference)
  * entry insert OblShouldPopulateShallProcess

// body.synthesis
* section[sectionSynthesis] insert OblShouldPopulateShallProcess
  * text insert OblShouldPopulateShallProcess

// Sections present in CompositionEuDr but not explicitly covered by the
// EHDSDischargeReportObligations logical model.
* section[sectionVitalSigns]
  * entry 0..
  * entry only Reference(ObservationEuDrObligation or DocumentReference or $vitalsigns)

* section[sectionAllergies]
  * entry only Reference(AllergyIntoleranceEuDrObligation or DocumentReference)
  * entry[allergyOrIntolerance] only Reference(AllergyIntoleranceEuDrObligation)
  * entry[allergyOrIntolerance] insert OblShouldPopulateShallProcess
* section[sectionImmunizations]
  * entry only Reference(ImmunizationEuDrObligation or DocumentReference)
  * entry[immunization] only Reference(ImmunizationEuDrObligation)
  * entry[immunization] insert OblShouldPopulateShallProcess
* section[sectionAttachments]
  * entry only Reference(DocumentReference or Binary)
  * entry insert OblShallPopulateShallProcess
