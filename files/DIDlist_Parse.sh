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
Path=$(pwd)
DID_Edit=$(echo "${DID}" | sed -r 's/\//_/g') # Edit the DID string, change / to _
DID_Edit=${DID_Edit:1} # Remove the leading _
tmp_file="${Path}/${DID_Edit}_DIDlist_tmp" # Name a tmp file based upon DID
touch ${tmp_file} # Create file
rucio did list ${Scope}:${DID} > $tmp_file # Dump info on DID to file
# Check DID is a dataset
if ! grep -q DATASET $tmp_file; then
    echo "DID is not a dataset! Please provide the DID for a dataset!"
    exit 3
fi

PathListFile="${Path}/${DID_Edit}_DID_Pathlist"
# Need to switch this to name the DID pathlist nicely
touch "${PathListFile}" # Open the file which will contain the path list

rucio replica list file --protocols root --pfns --rses isopenaccess ${Scope}:${DID} > ${PathListFile}

echo "Parsed provided DID - $DID"
echo "All files locations within this dataset have been printed to ${PathListFile}" # Need to automate this in future such that the file is named sensibly
sleep 1

rm $tmp_file # Delete the tmp file

exit 4
