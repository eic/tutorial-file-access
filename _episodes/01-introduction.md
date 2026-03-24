---
title: "Introduction"
teaching: 10
exercises: 
questions:
- "How are EIC/ePIC simulation outputs organised?"
objectives:
- "Understand how the simulation output is organised"
- "Find out how to request a new simulation"
- "Discover the tools that are available to browse and access the simulation output"
keypoints:
- "Simulation campaigns run on a regular (monthly basis)" 
- "Input requests **must** be formatted in a specific way and meet certain pre-requisites"
- "Rucio is the primary way to browse and access simulated EIC/ePIC data"
---

## Simulation Campaigns

Simulations of a range of physics processes in the ePIC detector are typically run on a monthly basis by the Production Working Group. Information on simulation campaigns can be found on the [Production Working Group pages](https://eic.github.io/epic-prod/). This includes details of files produced in previous campaigns.

A list of current request from Detector Subsystem Co-ordinators and the Physics Analysis Co-ordinators can be found [here](https://docs.google.com/spreadsheets/d/1BJeq3AYwefNC9m3palH6T0SHMxmRmHpOzLTSa_6SZIU/edit?usp=sharing).

Campaigns are designated by a standardised format - **YY.MM.Ver**
- YY - Year the campaign ran, e.g. 26 is 2026
- MM - Month the campaign ran, e.g. 02 is February
- Ver - Version of the campaign, starts from 0. May have different versions

These are linked to specific software releases following the same format.

> **Note that campaigns more than ~6 months old will not directly be accessible using the methods we will explore in this tutorial.**
{: .callout}

Various types of files are produced as part of the simulation campaign as we will discuss in the next section. The files you may wish to access will differ depending upon your use case. In this tutorial, we will explore a few different common use cases and the types of files you may want in each.

### Submitting a New Simulation Request

If you would like to submit a new request to a future campaign for a dataset that is not in production, please follow the following process:

1. Coordinate with your physics or detector working group and the detector subsystem or physics analysis co-ordinators to add your request to the overview spreadsheet and assign a priority. 
2. Generate the Monte-Carlo input for your new request.
  - Please follow the [pre-processing guidelines](https://github.com/eic/epic-prod/blob/main/docs/_documentation/input_preprocessing.md) when preparing your new input files for submission.
3. Once your input files are ready, submit a [simulation request form](https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.google.com_forms_d_e_1FAIpQLScDqiEaHayAcwBDGAWa4W6k-2D6yUFzS-2DXiWuhLolpy64mLk5FA_viewform&d=DwMFAg&c=CJqEzB1piLOyyvZjb8YUQw&r=1bclzxVlhTV419LkWWxwLTl3ztSqyuA_Q_Vnypx1RD4&m=q9b8IbAHm_MLsvy4XkI2Px2QKzFNqjpf0qc4nctB9ZHyf-uL5bZuiegs5-hwb-Ec&s=TFdsmJL2wPtUD-CCXVdkWIF5lxB1QYbz5MKGhB6nroA&e=).
  - If your input is not pre-processed following the [pre-processing guidelines](https://github.com/eic/epic-prod/blob/main/docs/_documentation/input_preprocessing.md), it will not be simulated. Please review these carefully.

## Simulation Files Organisation

Within a simulation campaign, there are three broad classes of files that are produce:
- EVGEN: The input hepmc3 datasets
    - E.g. some files that have been supplied by a physics event generator
- FULL: The full GEANT4 output root files (usually only saved for a fraction of runs)
    - If running a simulation yourself, this would be your output from processing npsim
- RECO: The output root files from the reconstruction
    - And again, if running yourself, this would be your output from EICrecon (after you've used your awesome new reconstruction algorithm from the later tutorial of course)

Most users and use cases will interact with RECO files, the output of the full simulation and reconstruction chain. We will explore some use cases and how to find the relevant files in each case.

## How can I Browse the Simulation Campaign Output and Access Files?

To browse the campaign output and find the files we want, we can use [Rucio](https://rucio.cern.ch/). *Rucio* is an open source scientific data management system. It is utilised in other large physics experiments such as ATLAS.

### Wait, I read I should use XrootD to find and access files?

You may find reference to or instructions on using Xrootd to browse and access files.These may still work and indeed, we will use some of these commands later in this tutorial. However, Rucio is now the preferred method for the cases we will examine.

Why? This change isn't just to make everybody learn something new, it is also a consequence of the expansion of the volume of ePIC data now available. Previously (before 2026), all simulated data was stored on Jefferson Lab servers. However, data is now spread between multiple sites. This makes finding an accessing it using XrootD more complicated. Rucio can deal with this "issue" in a straightforward way.

> You may also find reference to an S3 server. This is now deprecated and cannot be used. 
> If you find such references or instructions to S3 server usage in tutorial material, please raise an issue on the GitHub page for this tutorial flagging that this should be removed.
{: .callout}
