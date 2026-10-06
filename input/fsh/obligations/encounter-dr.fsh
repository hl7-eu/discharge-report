Profile: EncounterEuDrObligation
Parent: EncounterEuDr
Id: encounter-obl-eu-dr
Title:    "Encounter: obligations"
Description: "This profile defines obligations for the encounter documented by a Discharge Report in HL7 FHIR for the scope of this guide."

* insert SetFmmAndStatusRule ( 0, informative)

* insert OblShallPopulateShallProcess

* subject only Reference(PatientEuDrObligation)
* reasonReference only Reference(ObservationEuDrObligation or ConditionEuDrObligation or ProcedureEuDrObligation)
* participant.individual only Reference(PractitionerEuDrObligation or PractitionerRoleEuDrObligation or RelatedPersonEuDrObligation)
* diagnosis.condition only Reference(ConditionEuDrObligation)
* hospitalization.destination only Reference(OrganizationEuDrObligation or LocationEuCore)
* location.location only Reference(LocationEuCore)
* serviceProvider only Reference(OrganizationEuDrObligation)

* class insert OblShallPopulateShallProcess
* subject insert OblShallPopulateShallProcess
* period  insert OblShallPopulateShallDisplayProcess
* reasonCode  insert OblShallPopulateShallDisplayProcess

* participant[admitter]  insert OblShallPopulateShallDisplayProcess
* participant[discharger]  insert OblShallPopulateShallDisplayProcess
* participant[referrer] insert OblShallPopulateShallDisplayProcess

* diagnosis.condition insert OblShallPopulateShallDisplayProcess



