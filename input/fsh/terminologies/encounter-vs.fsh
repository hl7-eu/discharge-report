// --------------------------------------------------
ValueSet:     EncounterClassDrVS
Id:	          encounter-class-eu-dr
Title:	      "Encounter Class Value Set"
Description:  """Discharge Report Encounter Class value set includes codes from the HL7 v3-ActCode code system that are used to classify the general type of encounter the discharge report refers to (e.g. inpatient, emergency, ambulatory or home health encounters)."""

* insert SetFmmAndStatusRule (1, draft)
* ^experimental = false
* $v3-ActCode#IMP	    "inpatient encounter"  // should we have this general category ?
* $v3-ActCode#ACUTE	    "inpatient acute"
* $v3-ActCode#NONAC	    "inpatient non-acute"
* $v3-ActCode#OBSENC	"observation encounter"
* $v3-ActCode#SS	    "short stay"
* $v3-ActCode#EMER	    "emergency"
* $v3-ActCode#AMB	    "ambulatory"
* $v3-ActCode#HH	    "home health"


// --------------------------------------------------
ValueSet:   EncounterTypeDrVS
Id:         encounter-type-eu-dr
Title:      "Encounter Type Value Set"
Description:  """Discharge Report Encounter Type value set includes concepts from SNOMED CT descendants of 225351009 (Care provision regime) that are used to classify the care provision regimen during the encounter."""

* insert SetFmmAndStatusRule (1, draft)
* ^experimental = false
* insert SNOMEDCopyrightForVS
* include codes from system $sct where concept is-a #225351009 "Care provision regime"

// --------------------------------------------------
ValueSet:     EncounterStatusDrVS
Id:	     encounter-status-eu-dr
Title:      "Encounter Status Value Set"
Description:  """Discharge Report Encounter Status value set includes codes from the FHIR R4 EncounterStatus code system that are used to represent the state of the encounter."""

* insert SetFmmAndStatusRule (1, draft)
* ^experimental = false
* $encounter-status-r4#triaged	"Triaged"
* $encounter-status-r4#in-progress	"In Progress"
* $encounter-status-r4#onleave	"On Leave"
* $encounter-status-r4#finished	"Finished"	
* $encounter-status-r4#unknown	"Unknown"
