#! /bin/bash

# If no arguments or more than one given, complain
if [ "$#" -ne 1 ]; then
    echo ""
    echo "!!! ERROR !!! - Expected 1 argument - !!! ERROR !!!"
    echo "Expect - DID dataset to parse"
    echo "!!! ERROR !!! - Expected 1 argument - !!! ERROR !!!"
    echo ""
    exit 0
fi

# Set variables equal to arguments provided
DID=$1
Scope="epic" # Scope will always be epic

# Check DID is singular, do not allow wildcards
if [[ $DID =~ \* ]]; then
    echo "Provided DID string includes a wild card. Please provide a singular DID dataset path only!"
    exit 1
fi
# Check DID is valid
DID_Check=$(rucio did list --short ${Scope}:${DID})
if [[ $DID_Check == "" ]]; then
    echo "DID provided is blank! Please provide the DID for a dataset!"
    exit 2
fi
touch "DIDlist_Parse_tmp"
rucio did list ${Scope}:${DID} > DIDlist_Parse_tmp
# Check DID is a dataset
if ! grep -q DATASET DIDlist_Parse_tmp; then
    echo "DID is not a dataset! Please provide the DID for a dataset!"
    exit 3
fi

# Checks passed, now process the file
rucio did content list --short ${Scope}:${DID} > DIDlist_Parse_tmp # Dump list of files in dataset to a file
touch "DID_Pathlist" # Open the file which will contain the path lst
NLines=$(wc --lines < tmp) # Check number of files to process in total
NLinesRed=$(( ((${NLines%.*}+5)/10)*10 )) # Round to nearest value of 10 to make the progress counter simpler

echo "Processing ${NLines} files in dataset ${Scope}:${DID}$ and creating file with list of paths."
i=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    rucio replica list file --protocols root --pfns --rses isopenaccess $line >> DID_Pathlist
    i=$(( $i + 1 ))
    if [[ $(( $i % $(( ${NLinesRed}/10 )) )) == 0 ]]; then  # Go to the Microsoft school of progress tracking (aka, lying) and calculate progress
	Prog=$(printf %.0f "$((10**2 * ${i}/${NLinesRed}))e-0")
	echo "${Prog} % of file list processed"
    fi
done < "DIDlist_Parse_tmp"
echo "Parsed provided DID - $DID"
echo "All files locations within this dataset have been printed to DID_Pathlist" # Need to automate this in future such that the file is named sensibly

rm DIDlist_Parse_tmp # Delete the tmp file

exit 4
