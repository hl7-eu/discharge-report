//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  MedicationDispenseEuDrObligation
Parent:   MedicationDispenseEuDr
Id:       medicationDispense-obl-eu-dr
Title:    "MedicationDispense: obligations"
Description: "This profile defines obligations for the MedicationDispense resource for the purpose of this guide, adapted from the MPD work."
//-------------------------------------------------------------------------------------------

* insert SetFmmAndStatusRule ( 0, informative)

* insert OblShallPopulateShallProcess

* subject only Reference(PatientEuDrObligation)
* medication[x] only CodeableConcept or Reference(MedicationEuDrObligation)
* authorizingPrescription only Reference(MedicationRequestEuDrObligation)

* subject insert OblShallPopulateShallProcess
* medication[x] insert OblShallPopulateShallDisplayProcess

* status insert OblShallPopulateShallDisplayProcess


* performer.actor insert OblShallPopulateShallProcess

* authorizingPrescription insert OblShallPopulateShallDisplayProcess
* quantity insert OblShallPopulateShallProcess
* whenHandedOver insert OblShallPopulateShallDisplayProcess


