//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  MedicationDispenseEuDr
Parent:   MedicationDispense
Id:       medicationDispense-eu-dr
Title:    "MedicationDispense (DR)"
Description: "This profile constrains the MedicationDispense resource for the purpose of this guide, adapted from the MPD work."
//-------------------------------------------------------------------------------------------

* insert SetFmmAndStatusRule (1, draft)

* medication[x] only CodeableConcept or Reference(MedicationEuCore)



* identifier 
  * ^short = "Dispensation/dispensed item ID"
  * ^comment = "It is the dispensation ID if the prescription includes only one prescribed item"
* status ^short = "Current state of the dispensation"
* subject only Reference( PatientEuCore )

* performer.actor 1..1

* authorizingPrescription only Reference(MedicationRequestEuCore)
* quantity 1..1
* whenHandedOver 1..1


