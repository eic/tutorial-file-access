---
title: "Use Cases"
teaching: 10
exercises: 40
questions:
- "How do users interact with EIC/ePIC data?"
objectives:
- "Explore different use cases for ePIC simulation data and how users work with EIC/ePIC data"
- "Discover how simulation files can be utilised in further analysis"
- "Know how to download files if needed (and when it might be needed)"
keypoints:
- "Files from datasets can be directly streamed in analysis scripts"
- "Files (or whole datasets) can be downloaded locally, but this is usually *not* needed"
---

In this episode, we will explore a few common use cases and how users may want to interact with simulation campaign output in each case. Examples of carrying out some common tasks associated with each use case will be included.

## Physics Analyser - Novice

This use case explores a user new to analysing ePIC data to try and look at a specific physics process. They will likely want to find and identify a specific physics process to pass through their analysis code. Their requirements are likely to include:

- Reconstructed output files (RECO)
- A general type of physics process (or group of processes)
- The latest available files to test
- A specific collider (energy and ion species) configuration

They may also want to only test a small subset of data to test and develop their analysis. **This use case is one example where downloading a small number of files locally may be beneficial**. 

To find files that meet their requirements they could utilise the following tags:

- software\_release
- requester\_pwg
- electron\_beam\_energy\_gev
- ion\_beam\_energy\_gev
- ion\_species
- data\_level

We can use these tags to filter through the DIDs and find datasets of interest:

```bash
rucio did list --filter 'software_release==XXX, requester_pwg==YYY, electron_beam_energy_gev==ZZ, ion_beam_energy_gev==iii, ion_species==jjj' 'epic:*'
```

Where we can substitute in our chosen values for each in place of `XXX`, `YYY`, `ZZ`, `iii` and `jjj`.

> ## `Beam Energies:` 
> Whilst we can enter any number for the `electron_beam_energy_gev` and `ion_beam_energy_gev` values, there are only certain combinations actually in use.
> `electron_beam_energy_gev` is typically 5, 10 or 18 GeV
> `ion_beam_energy_gev` is typically 41, 100, 130, 250 or 275 GeV for protons.
> For other ion species, 110 and 166 may also be used.
{: .callout}

Once we have identified a specific dataset of interest, we can look at the files within it using:

```bash
rucio did content list scope:name
```

and we can get locations of the files within the dataset via:

```bash
rucio replica list file --protocols root --pfns --rses isopenaccess scope:name_of_file
rucio replica list file --protocols root --pfns --rses isopenaccess scope:name_of_Dataset
```
as we saw in the last episode. We can get just the location of a specific file OR the location of all files within the dataest, depending upon which we specify. We could download this file locally using

```bash
xrdcp FILEPATH ./
```

where `FILEPATH` is the path to one specific file from the output of one of the rucio commands above.

> ## `Exercise:`
> Using the suggested tags, find the **latest** available datasets for:
> - Neutral current (NC) DIS events for 10 GeV electrons colliding with 130 GeV protons
> - Download **one** file from this dataset of your choice
{: .challenge}

## Physics Analyser - Experienced

In this use case, we consider an experienced physics analyser that has a well developed analysis script that they want to run on a large number of files, possibly even a full dataset, for a specific physics process they're interested in. Their requirements are likely to include:

- Reconstructed output files (RECO)
- A specific physics process (or group of processes)
- The latest available files to test
- A specific collider (energy and ion species) configuration
- A datasets with machine backgrounds embedded in the simulated output files

To find files that meet their requirements they could utilise the following tags:

- software\_release
- physics\_process
- electron\_beam\_energy\_gev
- ion\_beam\_energy\_gev
- generator
- data\_level

They may also want to use the `q2_min_gev2` ad `q2_max_gev2` tags, along with the `ion_species` tags to narrow down to an even more specific subset of files. They may also want to analyse files with or without background enabled.

As they want to process a large number of files, **it is unlikely (and not recommended) that they download a large number of files to process them locally**. Instead, they may want to stream their files directly in their analysis script. They could do this via:

```c++
auto f = TFile::Open("FILEPATH");
auto tree = f->Get<TTree>("events");
```

or if they're using python:

```python
import uproot
import XRootD
file_path = "FILEPATH"
root_file = uproot.open(file_path)
```

As they may wish to process a full dataset, they might want to feed their script a full list of files to stream and run. They could print the full list of files in a dataset:

```bash
rucio replica list file --protocols root --pfns --rses isopenaccess scope:name_of_Dataset > FileList
```

This could then be processed in the script:

```c++
void FileListProcess(){
  string line;
  ifstream fstream ("FileList");
  int FileCount = 0;
  //TChain *AnalysisChain = new TChain("events"); // We could define a chain to process our files too and add them as we scan over our list
  while(getline(fstream, line)){
    if (FileCount > 5) continue; // Stop loop after 5 files, comment out to read full file
    // Check file exists
    TString tmpFile{line};
    auto RootFile = TFile::Open(tmpFile);
    if(!RootFile){ // Check file exists
      cout << "File not found:"<<tmpFile << endl;
      continue;
    }
    cout << "Found file - " << line << endl;
    //AnalysisChain->Add(tmpFile) // Add to our chain if we want
    FileCount++;
  }
}
```

or if they're using python:

```python
import ROOT
import uproot
import XRootD
import awkward as ak

Files=[]

with open('FileList', 'r') as file:
    lines_list = file.readlines()
    for line in lines_list[:5]: # Read only lines 0:5 - remove [:5] to read all or change 5 to N where N is the number of lines you want
        file_path = line.rstrip() # rstrip to remove trailing white space/new lines
        try:
            with uproot.open(file_path) as file:
                Files.append(file_path) # Add file path to array
                print("Found file - ", file_path, "and appended to list for processing.")
        except Exception as e:
            print(f"Could not open file: {e}")
        
# Use the uproot iterate method to process our list of files - See https://uproot.readthedocs.io/en/stable/uproot.behaviors.TBranch.iterate.html
#for chunk in uproot.iterate({f: "events" for f in Files}, expressions=["MCParticles.PDG"]): # Open files in array f and process events tree with branches specified
    # Process each chunk - Do something
    # print(ak.type(chunk))
```

Note that we have restricted these examples to only print out the first five files in the list we created. We can comment out or change the lines as noted to process the full list (or adjust the cutoff value in the condition to process a different number).

> ## `Exercise:`
> Using the suggested tags, find the **latest** available dataset for:
> - Deeply Virtual Compton Scattering (DVCS) events from the EpIC event generator for 10 GeV electrons colliding with 130 GeV protons *without* background included
> 1. Stream **one** file from this dataset in a script, check the number of events in this file
> 2. Print **all** of the files in this dataset to a text file
> 3. Stream **five** of the files in this dataset in a script, check the total number of events contained in all five files.
{: .challenge}

## Detector Designer/Optimiser, Algorithm/Reconstruction Development

Discussion of use case based upon SIM data - To be added soon.

## Conclusion and Comments

That wraps up our introduction to using Rucio and some example use cases and scenarios.

New tags may be added in the future. We're welcome to take on board any suggestions or changes as we roll out Rucio and it becomes more widely used. Get in touch via - [stephen.kay@york.ac.uk](stephen.kay@york.ac.uk) 

or on Mattermost with suggestions, comments and feedback.

Remember to consider whether you need full datasets before downloading them and keep an eye on whether your files have multiple open access copies when making file lists.

Also, if you find any nice tricks or develop short scripts (maybe one which makes a file list for the latest version of a dataset based upon inputs?) then feel free to share them too!
