import os
import shutil
import re

granule = raw_input('Enter Granule ') 

directory = '{}\\'.format(granule)
# .format() formats the contents of the granule object into the space between {} in the below line, 
# thereby creating a full path to the specific file



if os.path.exists(directory):  		# if the path in the directory object exists: continue 
	for file in os.listdir(directory):		# for files in the directory object: continue
			if re.search(r'_v02.img', file): # if a file has the ' ' string in it; continue:	
				filepath = os.path.join(directory, file) # define filepath object by joining directory and file together
				finalpath = re.sub(r'_v02', '_v03', filepath) # substitutes the second parameter string for the first paramater string in the filepath object
				
				if not os.path.exists(finalpath): # if the finalpath does not exist; continue:
					shutil.copyfile(filepath, finalpath) # copy the filepath object to the finalpath object name

os.startfile('C:\\Users\\be006884\\Desktop\\Sentinel_QC_Copy&Rename.py')
