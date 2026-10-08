This guide is part of the group of HL7 FHIR Implementation Guides published by HL7 Europe (see figure 1) to support the priority categories identified by the [European Health Data Space Regulation](http://data.europa.eu/eli/reg/2025/327/oj) (EHDS).


<div>
<img src="ig-overview.png" class="figure-img img-responsive img-rounded center-block" width="70%">
<p><strong>Fig. 1: HL7 EU FHIR IG overview</strong></p>
<p> </p>
</div>

### The EHDS regulation

The EHDS regulation defines a framework to:

* empower individuals to take control of their health data and facilitate the exchange of data for the delivery of healthcare across the EU [primary use of data](https://health.ec.europa.eu/ehealth-digital-health-and-care/electronic-cross-border-health-services_en)
* foster a genuine single market for electronic health record systems
* provide a consistent, trustworthy, and efficient system for reusing health data for research, innovation, policy-making, and regulatory activities [secondary use of data](https://tehdas.eu/)


#### The European EHR eXchange Format (EEHRxF)

A key role in the regulation is played by the **European EHR eXchange Format** (EEHRxF), defined as a format that is *"commonly used, machine-readable, and allowing transmission of personal electronic health data between different software applications, devices and healthcare providers. The format should support transmission of structured and unstructured health data."*

When the regulation enters into application, EHR-systems will be required to support the EEHRxF for providing and receiving personal electronic health data under a **priority category for primary use** established under the EHDS Regulation. 
The six priority categories, listed in Article 14 of the EHDS Regulation, are summarized in the following picture, including **discharge reports**, which are the subject of this guide.

The EHDS treats 'discharge reports' as a single priority category, covering any kind of encounter that ends with a discharge, for example a hospital stay, an emergency department visit, a day-care episode, a rehabilitation stay or an ambulatory specialist episode.

<div>
<img src="ehds-domain.png" class="figure-img img-responsive img-rounded center-block" width="70%">
<p><strong>Fig. 2: EHDS priority categories</strong></p>
</div>

The EEHRxF will be defined by the European Commission through a set of Implementing Acts; proposals supporting these acts have been prepared by the [Xt-EHR Joint Action](https://www.xt-ehr.eu/).

Among these proposals, Xt-EHR has defined the EHDS logical models for the priority categories, including the EHDS logical model for the discharge report ([`EHDSDischargeReport`](https://www.xt-ehr.eu/fhir/models/1.0.0/StructureDefinition-EHDSDischargeReport.html)). This guide fulfils the requirements of that logical model by using HL7 FHIR.


### EEHRxF: not a one-size-fits-all solution

The intended use of the EEHRxF is not limited to cross-border exchange, but includes all the possible contexts and purposes of the primary use of health data.

Considering this, there is no one-size-fits-all solution covering all these scopes, but this expectation can be fulfilled only by a coherent ecosystem of specifications - based on standards wherever possible - covering European common rules, cross-border and national specifications.

The following figure summarizes this layered approach.

<div>

<img src="ehds-ig-strategy.png" class="figure-img img-responsive img-rounded center-block" width="70%">
<p><strong>Fig. 3: EEHRxF proposed IG approach</strong></p>
</div>

Within this ecosystem, this guide is the common European baseline for the 'discharge reports' priority category. It is intentionally generic: the information needed to report a hospital stay, an emergency department visit or a rehabilitation stay differs in its level of detail, in its sections and in the clinical vocabulary it uses. Real-world implementations are therefore expected to build on this guide through specialisations for the specific kinds of discharge report and care settings, defined at European, national or domain level.
