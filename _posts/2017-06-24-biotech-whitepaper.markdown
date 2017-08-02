---
layout: post
date:   2017-06-22 
categories: psm biotech
---

### Intercepting Transmissions : Improving Public Health Investigations with Genomic Data

Over the course of the past few years, there have been explosive developments in
computational power, networking, and genetic sequencing technologies. However,
the challenges involved with bringing these technologies together to disrupt the
public health sector has been immense. 

There are numerous agencies within the United States and beyond that has the
stated goal of developing and applying disease control and prevention in order
to protect the general population. All of these organizations provide important
services such as collecting useful information in the form of pathogen sequence
data, attributes associated with that sequence data, public works programs to
promote regular testing and health education, and much more.

However, epidemics, by definition, do not simply happen within tighty line-drawn
jurisdictions. In order to be more effective and to have a holistic view of
public health concerns, organizations must be able to coordinate with each other
to share data and research. Security concerns, data standardization, protocols
for sequencing and sharing data, contractual agreements, and workforce training
are all factors that need to be addressed. Indeed, it would be naive for one to
simply state "Just create a shared Dropbox account across sites!". The tech
sector is known to have optimists, which can be endearing, but may cause
frustration when considering the practicalities involved when handling sensitive
public data. 

Furthermore, once protocols are in place and data is shared, there is a severe
lack of discipline in what makes good data science. Visualizations posted on
social networks can be interesting to view on a lazy Sunday afternoon, but
analysis that can affect public policy is a delicate matter that will and should
face intense scrutiny.


### Table of Contents

* Security Concerns
* Data management
* Lack of standardized pipelines
* Data Science as a discipline

### Security Concerns

Navigating information privacy law can be overwhelming. Compliance with Health
Insurance Portability and Accountability Act (HIPAA) and FISMA (Federal
Information Security Management Act), even for those projects deemed as "low
risk" (a system that will not contain data that is deemed Private Health
Information(PHI), is both complex and demanding. The cost of implementation due
to increased paperwork and staff time to meet legal requirements has resulted in
a private industry to help institutions become "in compliance". 

While IRBs and system administrators attempt to meet compliance, workforce
members are still sharing data via Microsoft Excel spreadsheets over email, not
using any sort of revision control system on their data or source code, and have
yet to even agree upon a standard for annotating sequences.

Beyond this, each public health organization must approve data sharing between
sites and each may have their own set of policies to meet compliance. 

A Schengen-like Agreement approach to data in public health would surely benefit
the sector, and thus society as a whole. Furthermore, if larger institutions
disseminated software and configuration files to aid in meeting compliance, the
pathway to collaboration would be eased. For example, the Center for Internet
Security (CIS) could issue its own Linux distribution instead of offering only
"Security Benchmarks".

### Data Management

Data management is another pain point in managing public health data. Despite
much effort and expense being made to ensure that lab equipment and supplies are
stocked, personnel trained, and protocols met, the effort seems to end once the
data from the instruments have been retrieved. The use of unwieldy spreadsheets
that aren't version controlled, lack any sort of template, and are frequently
riddled with typos and mislabeled is a pandemic. Attempting to ask a programmer
or IT to help fix these sort of issues once they've already occured will amount
to frustration between both administration and the technical team.

Data loss is still a prevalent issue. Ensuring that each workstation has an
external backup disk and that servers are backed up nightly should be considered
company policy.

### Lack of Standardized Pipelines

Lost development time due to each programming team coming up with their own
solutions, and re-inventing solutions that have already been addressed countless
times in other organizations has become incredibly costly. Because so many do
not standardize solutions to common problems, it is almost inevitable that the
code that one programming team has worked on in the past will be deemed
unmaintainable, and the new programmer will simply write his or her own
implementation that turns out to not be much better than the previous or perhaps
even worse.

It is not lazy to re-use code, it is practical. Using packages like
[Luigi](https://github.com/spotify/luigi) or
[Snakemake](https://snakemake.readthedocs.io/en/stable/) for pipelines with
multiple tasks allow current and future developers of a project maintain the
software package and expedite new features. Less time will be taken considering
software architectural issues, and more time will be dedicated to the actual
analyses that need to be orchestrated. 

### Data Science

Broadly speaking, the aim of public health sectors is the following

1) Accumulate data on the relationships between genetic traits and diseases across populations
2) Use this information to develop strategies to promote health and prevent disease in populations
3) Target and evaluate population-based interventions

However, how these interventions are actually implemented, and which metrics are
used to come to such conclusions, are not formalized in any way. A loose level of
guidelines when analyzing transmission networks. For example, determining that
using betweenness centrality at a certain threshold within a large enough
network requires a respective node be investigated, would be an improvement
over the shoot-from-the-hip investigations being conducted today.

Decisions on what sort of intervention should actually take place is done in an
opaque manner. It would be better to draft SOPs before a project is even funded.


### Summary

In summary, most of the issues we face are not all that technical at this point,
but have more to do with the management of digital assets. Internet services
have not been much of a solution given the sensitivity of the data involved, and
due to the custom nature of analyzing data based on specific assays. Adhering to
standards set and giving appropriate attention to data management and software
development does seem like a good place to start. Especially given that it
serves as the fundamental background of the services provided.
