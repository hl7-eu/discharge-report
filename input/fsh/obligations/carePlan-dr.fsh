Profile: CarePlanEuDrObligation
Parent: CarePlanEuDr
Id: carePlan-obl-eu-dr
Title:    "CarePlan: obligations"
Description: """This profile defines obligations for the CarePlan resource for the purpose of this guide."""

* insert SetFmmAndStatusRule ( 0, informative)

* insert OblShouldPopulateShallProcess

* subject only Reference(PatientEuDrObligation)
* addresses only Reference(ConditionEuDrObligation)
* goal only Reference(GoalEuDr)

* text insert OblShallPopulateShallProcess
* title insert OblShallPopulateShallDisplayProcess
* description insert OblShallPopulateShallDisplayProcess
* period insert OblShallPopulateShallProcess

* activity insert OblShallPopulateShallProcess
// No obligations on activity.detail: deprecated in R5/R6, activity.reference is used instead (see CarePlanEuDr)
  * reference insert OblShallPopulateShallDisplayProcess


