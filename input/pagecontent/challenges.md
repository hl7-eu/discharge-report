### Discharge Report structure


One of the primary challenges in implementing a standardised Discharge Report across Europe – and even within the same country – is the variation in how different jurisdictions and healthcare settings organise discharge information. Although there is a common logical structure typically followed – consisting of **admission/anamnestic information**, **course of the encounter**, and **discharge information** – the actual organisation of discharge reports can vary significantly in terms of how information is grouped and how sections are nested.

Some healthcare settings favor **flat structures**, where information is organised as a linear list of sections without significant hierarchical nesting. This approach is often perceived as more straightforward for data processing and integration, but it may compromise **readability** and the ability to present **complex relationships** between clinical data.

In contrast, other settings use a **nested structure**, where sections are organised hierarchically to group related information. This structure is more intuitive and readable for healthcare professionals, as it clearly groups interconnected information, but it also adds complexity to **data extraction** and **interoperability**.

An additional challenge lies in how the information is **displayed to human readers**, which may vary even when the underlying structure is standardised. Different healthcare systems and IT solutions may use diverse presentation formats, ranging from **text-heavy documents** with minimal formatting to **structured layouts** that include tables, graphs, or visual highlights. These variations in display can significantly impact the **usability and accessibility** of discharge reports, especially when shared across systems with differing capabilities.


### One discharge report, many kinds of encounters

The EHDS Regulation identifies the **Discharge Report** as one of the priority categories of personal electronic health data for primary use. However, the term "discharge report" is not used with exactly the same meaning in all Member States, healthcare systems, or implementation contexts. In some countries it is broadly equivalent to the **Hospital Discharge Report (HDR)**, describing the clinical documentation produced at the end of an inpatient hospital stay. In other settings, the same term also covers reports produced after an emergency department encounter, an ambulatory specialist visit, a day-care episode, a rehabilitation stay, or other forms of discharge from a healthcare service.

The previous HL7 Europe guide on this topic, the [Hospital Discharge Report IG](http://hl7.eu/fhir/hdr), deliberately focused on the hospital discharge report as a clearly defined subset of this domain. The Xt-EHR `EHDSDischargeReport` logical model, on the other hand, is defined as *"a generic, flexible model for any kind of discharge report"*, where *"different types of encounters may require adding relevant sections and elements, or omitting irrelevant ones, depending on their data needs"*.

This guide follows the EHDS model and addresses the discharge report in its broader meaning. The main challenges of this broader scope are:

- **Identifying the kind of report.** A single fixed document type is no longer sufficient; the kind of discharge report is conveyed by `Composition.type`, using a generic code when no more specific code applies.
- **Section relevance.** Not every section is meaningful for every kind of encounter (e.g. an admission evaluation is rarely relevant for an emergency department visit). Sections are therefore optional, and the relevant ones are selected according to the kind of encounter.
- **Hospital-oriented terminology.** Several section codes available in LOINC were defined for the hospital setting (e.g. 8648-8 *Hospital course*). They are reused in this version for all kinds of discharge report, pending the identification of setting-neutral codes (see [Known Issues](knownIssues.html)).
- **Specialisation.** Specific kinds of discharge report may need additional constraints; these are expected to be specified by derived (setting-specific, national or cross-border) guides rather than by this common framework.
