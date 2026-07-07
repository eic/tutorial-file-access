---
title: "Rucio Metadata Tags"
---

This is just a copy of the information on the tags given in the tutorial. Think of this page as a quick reference sheet.

The following tags are available as of March 2026:

- **software\_release**
  - Software release used in the simulation. Written as a container version tag/simulation campaign naming:
  - **YY**.**MM**.**v**
  - E.g. 25.06.2-stable -> June 2025 software container, version 2 stable
    - Note, campaign release files will almost always be from a **-stable** release/container version
- **is\_background\_mixed**
  - True/false depending upon whether sample includes any background mixing
- **data\_level**
  - Level of simulation data, `simulation` or `reconstruction`
- **geometry\_config**
  - Geometry config tag, e.g. `craterlake_18x275`, `craterlake_5x41_He3`
- **generator**
  - MC event generator used to generate the simulated data
    - `pythia6`, `pythia8`, `beagle`, `djangoh`, `rapgap`, `dempgen`, `sartre`, `lager`, `estarlight`, `eic_sr_geant4`, `eic_esr_xsuite`, `sherpa`, `single_particle`, `epic`, `other` 
- **requester\_pwg**
  - Defines the physics working group (PWG) that the simulated data relates to, options are:
    - `edt` (exclusive, diffractive and tagging), `inclusive`, `jets_hf`, `semi_inclusive`, `ew_bsm`, `other`
  - **Can be one or more**
  - Skipped for SINGLE/BACKGROUNDS
- **requester\_dsc**
  - Detector subsystem collaboration requester
    - `tracking`, `other`
  - Set to `tracking` for background related datasets
- **electron\_beam\_energy\_gev**
  - Electron beam energy in GeV
- **ion\_beam\_energy\_gev**
  - Ion/nucleus beam energy in GeV
- **ion\_species**
  - Ion species in the simulation, defaults to `p`, proton, if not specified
    - `p`, `Au197`, `Cu63`, `He3`, `H2`, `Ru96`
- **q2\_min\_gev2**
  - Minimum Q2 value (GeV^2) in the simulation file, entered as a number.
- **q2\_max_gev2**
  - Maximum Q2 value (GeV^2) in the simulation file, entered as a number.
- **gun\_particle**
  - Single particle type
    - `e-`, `e+`, `proton`, `neutron`, `pi+`, `pi-`, `pi0`, `kaon-`, `kaon+`, `gamma`, `mu-`
- **gun\_momentum\_min\_gev**
  - Minimum gun momentum in GeV
- **gun\_momentum\_max\_gev**
  - Maximum gun momentum in GeV
- **gun\_theta\_min\_deg**
  - Minimum gun polar angle in degrees
- **gun\_theta\_max\_deg**
  - Maximum gun polar angle in degrees
- **gun\_phi\_min\_deg**
  - Minimum gun azimuthal angle in degrees, default 0
- **gun\_phi\_max\_deg**
  - Maximum gun azimuthal angle in degrees, default 360
- **gun\_distribution**
  - Type of distribution for particle gun
    - `uniform`, `cos(theta)`, `eta`, `pseudorapidity`, `ffbar`

{% include links.md %}
