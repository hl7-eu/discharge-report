//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Profile:  ImmunizationEuDrObligation
Parent:   ImmunizationEuCore
Id:       immunization-obl-eu-dr
Title:    "Immunization: obligations"
Description: """This profile defines obligations for the Immunization resource for the purpose of this guide."""

//-------------------------------------------------------------------------------------------

* insert SetFmmAndStatusRule ( 0, informative)

* extension[administeredProduct] insert OblShallPopulateShouldDisplayShallProcess

* vaccineCode insert OblShallPopulateShallDisplayProcess

* patient insert OblShallPopulateShallProcess
* occurrence[x] insert OblShallPopulateShallDisplayProcess


* performer[administeringCentreOrHp] insert OblShallPopulateShallDisplayProcess


* protocolApplied.targetDisease insert OblShallPopulateShouldDisplayShallProcess
