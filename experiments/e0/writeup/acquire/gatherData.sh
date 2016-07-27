FIRST=
for FILE in ../experimentCode/output/*.dat
do
    exec 5<"$FILE" # Open file
    read LINE <&5 # Read first line
    [ -z "$FIRST" ] && echo "$LINE" # Print it only from first file
    FIRST="no"
    cat <&5 # Print the rest directly to standard output
    exec 5<&- # Close file
    # Redirect stdout for this section into file.out
done > ../data/data.txt
