
# fileob = open( 'demo.txt', 'r+') # read and write
# # rb- read in binary mode
# data = fileob.read()
# fileob.write('\n\nhey, user adding some contents')
# fileob.close() # save th file
# print( data)

## access modes - r, w, r+, w+, rb, rb+, wb, wb+
## a, ab, ab+ 

## append mode doen't print because the cursor is at last, so we cant read the contents

# fileob = open( 'demo.txt', 'a+')

# print( fileob.tell())

# fileob.seek(0) # changes the position of cursor

# data = fileob.read()
# fileob.write('\nsome more contents...')

# fileob.close() # save th file
# print( data)

# with open('demo.txt', 'r') as fileob:
#     data = fileob.read()

# print( data )

# iterable vs iterator

# x - Open a file for exclusive creation. If the file already exists, the operation fails.
# a - Open a file for appending at the end of the file without truncating it. Creates a new file if it does not exist

# with open('demo.txt', 'a') as fileob:
#     data = fileob.read()

# print( data )

# fileob = open( 'demo.txt', 'a')
# # data = fileob.read()
# fileob.write('\nsome contents...')
# fileob.close()
# print( data)


# import csv

# with open("./bwq.csv", 'r') as file:
#   csvreader = csv.reader(file)
#   for row in csvreader:
#     print(row)

# import pandas as pd
# data = pd.read_csv("bwq.csv")
# data


# import pandas as pd
  
# df = pd.read_json("FILE_JSON.json")
# df.head()


f = open("demo.txt", "r")
# print(f.readline())
print(f.readlines())


