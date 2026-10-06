// --------------------------------------------------
ValueSet:   DischargeReportTypeDrVS
Id:         discharge-report-type-eu-dr
Title:      "Discharge Report Type Value Set"
Description:  """Discharge Report Type value set includes selected LOINC document type codes used to identify the kind of discharge report. The generic code 18842-5 (Discharge summary) is used when no more specific code applies, for example for reports produced at the end of a day-care, rehabilitation or ambulatory episode."""
* insert SetFmmAndStatusRule (1, draft)
* insert LOINCCopyrightForVS
* ^experimental = false
* $loinc#18842-5 "Discharge summary"
* $loinc#34105-7 "Hospital Discharge summary"
* $loinc#59258-4 "Emergency department Discharge summary"
* $loinc#11490-0 "Physician Discharge summary"
* $loinc#28655-9 "Attending Discharge summary"
* $loinc#34106-5 "Physician Hospital Discharge summary"
* $loinc#34745-0 "Nurse Discharge summary"
