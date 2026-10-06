Profile: DeviceUseStatementEuDrObligation
Parent: DeviceUseStatementEuDr
Id: deviceUseStatement-obl-eu-dr
Title: "DeviceUseStatement: obligations"
Description: "This profile defines obligations for the DeviceUseStatement resource for the purpose of this guide."

* insert SetFmmAndStatusRule ( 0, informative)

* source only Reference(PatientEuDrObligation or PractitionerEuDrObligation or PractitionerRoleEuDrObligation or RelatedPersonEuDrObligation)
* subject only Reference(PatientEuDrObligation)
* device only Reference(DeviceEuDrObligation)

* subject insert OblShallPopulateOnly
* status insert OblShallPopulateOnly
* timing[x] insert OblShouldPopulateOnly
* device insert OblShallPopulateOnly
* bodySite insert OblShouldPopulateOnly
* bodySite.extension[bodySite] insert OblShouldPopulateOnly
* note insert OblShouldPopulateOnly

