---
title: "xrootd"
---

[XrootD](https://xrootd.org/) is a software suite for data access and management.

In the tutorial, we used XrootD to copy files and to stream files. We could also use it to search for files as well if we wanted. However, the limitation is that typically when browsing we must specify a server. If our file isn't on this server, we won't see it, unlike in Rucio.

## Directory Structure

Unlike Rucio, if we use XrootD, we *do* have a file structure. Typically, file paths typically look like:

- /volatile/eic/EPIC/<span style="color:#1845fb">OUTPUT_TYPE</span>/<span style="color:#ff5e02">CAMPAGIN</span>/<span style="color:#c91f16">DETECTOR_GEOMETRY</span>/<span style="color:#c849a9">PHYSICS_PROCESS_TYPE</span>/<span style="color:#adad7d">PHYSICS_PROCESS</span>/<span style="color:#86c8dd">BEAM_ENERGY</span>/<span style="color:#578dff">OTHER_CONDITIONS</span>/FILE.eicrecon.edm4eic.root
  - <span style="color:#1845fb">OUTPUT_TYPE</span>  - Is this event generator, simulation or reconstruction output?
  - <span style="color:#ff5e02">CAMPAIGN</span>  - Which simulation campaign is this from?
  - <span style="color:#c91f16">DETECTOR_GEOMETRY</span>  - Which detector geometry/design was used to run this simulation?
  - <span style="color:#c849a9">PHYSICS_PROCESS_TYPE</span>  - Broadly, what category of physics process is this?
  - <span style="color:#adad7d">PHYSICS_PROCESS</span>  - What physics process is this?
  - <span style="color:#86c8dd">BEAM_ENERGY</span>  - What beam energy combination was used?
  - <span style="color:#578dff">OTHER_CONDITIONS</span>  - Other simulation conditions, such as a range for a specific kinematic variable (Q2, t or similar)

Some directories may include event generator versions after the physics process too. You may also find some examples where there are multiple sets of additional conditions.

::::::::::::::::::::::::::::::::::::::::::::: callout

## Warning - Non-JLab Servers

Notice the `/volatile/` at the front of the path. This is specific to files on the JLab XrootD server.

Files stored elsewhere may just be under `/eic/EPIC/...`

:::::::::::::::::::::::::::::::::::::::::::::

## Browsing the Simulation Output with XrootD

We can browse the simulation output using XrootD from within the eic-shell. To browse the directory structure and exit, one can run the commands:

```bash
./eic-shell
xrdfs root://dtn-eic.jlab.org
ls /volatile/eic/EPIC/RECO/26.02.0
exit
```

`xrdfs` is the command to log in to a specific server, in this case `root://dtn-eic.jlab.org`.

When calling ls, we should see everything in this subfolder. In this case, all files from the **February 2026** campaign.

Files can also be copied locally by replacing `ls` with `cp`.

It is also possible to copy a file and open it locally using the `xrdcp` command:
```bash
./eic-shell
xrdcp root://dtn-eic.jlab.org//volatile/eic/EPIC/RECO/26.02.0/path-to-file .
exit
```

The trailing . indicates that the file will be copied to your current path with its current name. Change this as desired.

In our earlier episode, we used this command to copy a file we found using Rucio. **This is now the recommended workflow**:

1. Find file location with Rucio
2. Stream or download with XrootD

## Streaming Files

It is also possible to open a file directly in ROOT if you have XrootD installed too. Note that the following command should be executed after opening root and `TFile::Open()` should be used:

```c++
auto f = TFile::Open("root://dtn-eic.jlab.org//volatile/eic/EPIC/RECO/path-to-file")
```

or using python and uproot:

```python
import uproot
import XRootD
file_path = "root://dtn-eic.jlab.org//volatile/eic/EPIC/RECO/path-to-file"
root_file = uproot.open(file_path)
```

or directly with Pyroot:

```python
import ROOT
import XRootD
file_path = "root://dtn-eic.jlab.org//volatile/eic/EPIC/RECO/path-to-file"
file = ROOT.TFile.Open(file_path, "READ")
```
