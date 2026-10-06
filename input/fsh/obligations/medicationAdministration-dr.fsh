//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  MedicationAdministrationEuDrObligation
Parent:   MedicationAdministrationEuDr
Id:       medicationAdministration-obl-eu-dr
Title:    "MedicationAdministration: obligations"
Description: "This profile defines obligations for the MedicationAdministration resource for the purpose of this guide, adapted from the MPD work."
//-------------------------------------------------------------------------------------------

* insert SetFmmAndStatusRule ( 0, informative)

* insert OblShouldPopulateShallProcess

* subject only Reference(PatientEuDrObligation)
* medication[x] only CodeableConcept or Reference(MedicationEuDrObligation)

* subject insert OblShallPopulateShallProcess
* medication[x] insert OblShallPopulateShallDisplayProcess
