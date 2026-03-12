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
- physics\_process
- electron\_beam\_energy
- ion\_beam\_energy

We can use these tags to filter through the DIDs and find datasets of interest:

```bash
Example command
```

Once we have identified a specific dataset of interest, we can look at the files within it using:

```bash
Example command
```

as we saw in the last episode. We could download this file locally using

```bash
Example command
```

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
- electron\_beam\_energy
- ion\_beam\_energy
- generator

They may also want to use the `q2\_min` ad `q2\_max` tags, along with the `ion\_species` tags to narrow down to an even more specific subset of files. They may also want to analyse files with or without background enabled.

As they want to process a large number of files, **it is unlikely (and not recommended) that they download a large number of files to process them locally**. Instead, they may want to stream their files directly in their analysis script. They could do this via

```c++
root based streaming example
Full working script
```

or if they're using python -

```python
Python based streaming example
Full working script
```

As they may wish to process a full dataset, they might want to feed their script a full list of files to stream and run. They could print the full list of files in a dataset via -

```bash
Example command to pipe dataset list to a file
```

> ## `Note:` 
> We have limited this to only pipe 5 files in the dataset to our list.
> Remove the `fragment` part of the command to instead print all lines.
> Alternatively, edit this to be the number of lines that you want.
{: .callout}

This could then be processed in the script via -

```c++
root based streaming example
Full working script
```

or if they're using python -

```python
Python based streaming example
Full working script
```

> ## `Exercise:`
> Using the suggested tags, find the **latest** available dataset for:
> - Deeply Virtual Compton Scattering (DVCS) events from the EpIC event generator for 10 GeV electrons colliding with 130 GeV protons *without* background included
> 1. Stream **one** file from this dataset in a script, check the number of events in this file
> 2. Print **all** of the files in this dataset to a text file
> 3. Stream **five** of the files in this dataset in a script, check the total number of events contained in all five files.
{: .challenge}

## Detector Designer/Optimiser

Discussion of use case based upon SIM data

## Algorithm/Reconstruction Development

Discussion of use case based upon SIM data and tags - merge with previous?

## General Comments

Some general comments and info. Pointers, things to avoid or recommendations etc.
