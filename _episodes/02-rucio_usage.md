---
title: "Rucio Usage"
teaching: 10
exercises: 20
questions:
- "How can I use Rucio?"
objectives:
- "Become familiar with aspects of Rucio"
- "Use Rucio tags to find specific types of files"
keypoints:
- "Rucio works with datasets and Data Identifiers (DIDs)"
- "ePIC DIDs may look or be formatted like a nested filepath, but they are flat"
- "Tags can be used to quickly sort and find data of interest"
---

## Datasets and DIDs

Info on DIDs and datasets.

## Metadata Tags

The following tags are available as of March 2026:

- software\_release
  - Software release used in the simulation. Written as a container version tag:
  - v**YY**.**MM**.**v**
  - E.g. v25.06.2 -> June 2025 Software Container, version 2
- physics\_process
  - Defines the physics working group (PWG) that the simulated data relates to, options are:
  - excl\_diff\_tagging
  - inclusive
  - jets\_hf
  - semi\_inclusive
  - ew\_bsm
  - other
  - **Can be one or more**
- q2\_min
  - Minumum Q2 value (GeV^2) in the simulation file, entered as a number.
  - **Optional tag** - Not all simulated files use this
- q2\_max
  - Maximum Q2 value (GeV^2) in the simulation file, entered as a number.
  - **Optional tag** - Not all simulated files use this
- electron\_beam\_energy
  - Electron beam energy in GeV
- ion\_beam\_energy
  - Ion/nucleus beam energy in GeV
- is\_background\_mixed
  - True/false depending upon whether sample includes any background mixing
- ion\_species
  - Ion species in the simulation, defaults to `p`, proton, if not specified
- generator
  - MC event generator used to generate the simulated data
  - E.g. Pythia8, Herwig etc
  
As noted on some items in this list, some tags are optional and may not be applied to all datasets. However, the following tags are **required** for all datasets:

- software\_release
- physics\_process
- electron\_beam\_energy
- ion\_beam\_energy
- is\_background\_mixed
- ion\_species
- generator

We can use these tags to filter through the available datasets and identify those of interest to us. For example:

```bash
Example command
```
  
