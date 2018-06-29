#!/usr/bin/env bash
# rsync_exclude_symlink_cycles.sh: rsync stuff but be smarter with symlinks
#
# Call this like so:
# ./rsync_exclude_symlink_cycles.sh [source_directory] [destination_directory]

# Grab paths passed in
rsync_source_path=$1
rsync_destination_path=$2

# Find all self loops. The following will give us lines like the
# following:
#
# find: File system loop detected; ‘./temp’ is part of the same file system loop as ‘.’.
# find: File system loop detected; ‘./tempasdf’ is part of the same file system loop as ‘.’.
#
# Although there is some variation in the type of quotes used depending
# on the OS
lines=$(find $rsync_source_path -follow -printf "" 2>&1 >/dev/null)

# Grep the lines from the find command to get the problem symlinks to
# exclude
IFS=$'\n'
exclude_paths=''

for line in $lines
do
    full_exclude_path=$(echo "$line" | grep -o -P -m 1 "(?<=[‘'\`]).*?(?=[’'\`])" | head -1)
    exclude_paths+="--exclude=\"$(python get_exclude_path.py $full_exclude_path $rsync_source_path)*\" "
done

# Flavour text
echo about to run the command
echo
echo rsync -avPL $exclude_paths $rsync_source_path $rsync_destination_path
echo
echo good luck!

# Now do the rsync
eval rsync -avPL $exclude_paths $rsync_source_path $rsync_destination_path
