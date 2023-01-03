import os
import shutil
import re

root_directory = 'D:\\RPM_Cloud_QC\\'

list_of_folders = []

for folder in os.listdir(root_directory):
	path = os.path.join(root_directory, folder)
	list_of_folders.append(path)

latest_folder = max(list_of_folders, key=os.path.getmtime)	

if os.path.exists(latest_folder):  		
	for file in os.listdir(latest_folder):		
			if re.search(r'_c03.img', file): 
				filepath = os.path.join(latest_folder, file) 
				finalpath = re.sub(r'_c03', '_c03_qc', filepath) 
				
				if not os.path.exists(finalpath): 
					shutil.copyfile(filepath, finalpath)
