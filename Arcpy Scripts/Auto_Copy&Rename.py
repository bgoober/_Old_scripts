import os
import shutil
import re
import glob

root_directory = 'D:\\RPM_Cloud_QC\\' # define the root_directory

list_of_folders = [] # create a blank list to serve as the list_of_folders

for folder in os.listdir(root_directory): # for folders in the root directory, list them
	path = os.path.join(root_directory, folder) # define the path variable equal to the joined paths of the root_directory and the folder in the listed root_directory
	list_of_folders.append(path) # append the path to the list_of_folders list object

latest_folder = max(list_of_folders, key=os.path.getmtime) # define the latest_folder as the max value of list_of_folders based on last modified time

if os.path.exists(latest_folder):  		# if the path in the directory object exists: continue to the next line
	for file in os.listdir(latest_folder):		# for files in the directory object: continue
			if re.search(r'_c03.img', file): # if a file has the ' ' string in it; continue:	
				filepath = os.path.join(latest_folder, file) # define filepath object by joining directory and file together
				finalpath = re.sub(r'_c03', '_c03_qc', filepath) # substitutes the second parameter string for the first paramater string in the filepath object
				
				if not os.path.exists(finalpath): # if the finalpath does not exist; continue:
					shutil.copyfile(filepath, finalpath) # copy the filepath object to the finalpath object name
