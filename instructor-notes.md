---
title: "Instructor Notes"
---

This tutorial teaches learners how to find and access EIC/ePIC simulation campaign data with Rucio
and xrootd. It assumes learners have already completed the
[Setting Up Your EIC Environment](https://eic.github.io/tutorial-setting-up-environment/) tutorial
and have a working `eic-shell`.

## Before the session

- Ask learners to have a working `eic-shell` ready in advance (see the [Setup](../learners/setup.md)
  page). The Rucio client is run from inside `eic-shell`.
- Confirm that learners can run `rucio whoami` from inside `eic-shell` before the live commands, so
  that authentication issues are caught early.
- Remind learners that campaigns older than ~6 months may not be directly accessible, so use a
  recent `software_release`/campaign when demonstrating the `did list` commands live.

## Timing

The lesson is short on teaching (~35 minutes) but the exercises (particularly the use cases in the
final episode) can absorb the rest of the time as learners explore the tag-based queries and stream
or download files.

## Common pitfalls

- DIDs *look* like file paths but are flat; learners frequently expect a hierarchy that is not there.
- Metadata tags are only applied from March 2026 onwards, so tag-based filtering will miss older
  datasets.
- Encourage streaming rather than downloading full datasets.
