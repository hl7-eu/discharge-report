//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  MedicationAdministrationEuDr
Parent:   MedicationAdministration
Id:       medicationAdministration-eu-dr
Title:    "MedicationAdministration (DR)"
Description: "This profile constrains the MedicationAdministration resource for the purpose of this guide, adapted from the MPD work."
//-------------------------------------------------------------------------------------------

* insert SetFmmAndStatusRule (1, draft)

* identifier 
  * ^short = "Medication Administration Identifier"
* subject only Reference( PatientEuCore )
* medication[x] only CodeableConcept or Reference(MedicationEuCore)


