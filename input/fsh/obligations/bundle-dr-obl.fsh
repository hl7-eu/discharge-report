Profile: BundleEuDrObligation
Parent: BundleEuDr
Id: bundle-obl-eu-dr
Title: "Bundle: obligations"
Description: """This profile defines obligations for the Discharge Report for the scope of this guide."""

* insert SetFmmAndStatusRule ( 0, informative)

* identifier insert OblShallPopulateShallProcess
* type insert OblShallPopulateShallProcess
* language insert OblShallPopulateShallProcess
* timestamp insert OblShallPopulateShallProcess
* entry insert OblShallPopulateShallProcess
* entry.fullUrl insert OblShallPopulateShallProcess
* entry.resource insert OblShallPopulateShallProcess
// No obligation on entry.resource.language: Bundle.entry.resource is of type Resource
// (abstract), so its children cannot be profiled - see BundleEuDr.

* entry[composition].resource only CompositionEuDrObligation
* entry[patient].resource only PatientEuDrObligation
* entry[encounter].resource only EncounterEuDrObligation
* entry[allergyIntolerance].resource only AllergyIntoleranceEuDrObligation
* entry[condition].resource only ConditionEuDrObligation
* entry[device].resource only DeviceEuDrObligation
* entry[deviceUseStatement].resource only DeviceUseStatementEuDrObligation
* entry[diagnosticReport].resource only DiagnosticReportEuCore
* entry[imagingStudy].resource only ImagingStudy
* entry[immunization].resource only ImmunizationEuDrObligation
* entry[media].resource only Media
* entry[medication].resource only MedicationEuDrObligation
* entry[medicationRequest].resource only MedicationRequestEuDrObligation
* entry[medicationStatement].resource only MedicationStatementEuDrObligation
* entry[medicationAdministration].resource only MedicationAdministrationEuDrObligation
* entry[medicationDispense].resource only MedicationDispenseEuDrObligation
* entry[practitioner].resource only PractitionerEuDrObligation
* entry[practitionerRole].resource only PractitionerRoleEuDrObligation
* entry[procedure].resource only ProcedureEuDrObligation
* entry[organization].resource only OrganizationEuDrObligation
* entry[observation].resource only Observation
* entry[specimen].resource only SpecimenEuDrObligation
* entry[flag].resource only FlagEuDrObligation
* entry[documentReference].resource only DocumentReference
* entry[location].resource only LocationEuCore
* entry[careplan].resource only CarePlanEuDrObligation
* entry[relatedPerson].resource only RelatedPersonEuDrObligation

