# cursor is a reference to the context area, basically a pointer

# file handler
# open, read & write and write


# file I/O, file I/O handling

# fileobj = open('demo.txt', 'r')
fileobj = open('demo3.txt', 'w')

data = fileobj.write('my contents are overridden123')
# if you are writing to a file, you can't read
# w mode- creates a new file and puts the contents

fileobj.close()
print( data)
