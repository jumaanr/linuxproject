for file in $(ls images)
do
        if [[ $file = *.jpeg ]]
                then
                new_name=$(echo $file| sed 's/jpeg/jpg/g')
                mv images/$file images/$new_name
        fi
done
#
#The sed command you've shown is used to replace all occurrences of the string "jpeg" with "jpg" in the input provided to it. 
#sed is a stream editor for filtering and transforming text. Here's a breakdown of the command:
#sed: Invokes the stream editor.
#'s/jpeg/jpg/g': This is the command given to sed, enclosed in single quotes to treat it as a single argument.
#s: Specifies the substitution operation.
#jpeg: The pattern to search for in the input text.
#jpg: The replacement string.
#g: A flag that stands for "global", meaning the substitution should happen globally across each line of input, replacing all occurrences of the pattern, not just the first on

sed -i 's/jpeg/jpg/g' filename.txt
# The -i option tells sed to edit files in-place. Be careful with this option, as it will overwrite the file.
echo "This is a jpeg image file." | sed 's/jpeg/jpg/g'
# If you want to replace "jpeg" with "jpg" in the output of another command, you can use a pipe (|):
sed 's/jpeg/jpg/g' filename.txt
# If you just want to see what the changes would look like without actually modifying the file, you can simply input the file to sed without the -i option: