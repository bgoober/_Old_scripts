import os
import shutil
import re

root_directory = 'D:\\GeoCue_Data\\SentinelRPM_Cloud_Edits\\'

list_of_folders = []

for folder in os.listdir(root_directory):
	path = os.path.join(root_directory, folder)
	list_of_folders.append(path)

latest_folder = max(list_of_folders, key=os.path.getmtime)	

if os.path.exists(latest_folder):  		
	for file in os.listdir(latest_folder):		
			if re.search(r'_SCZ.img', file): 
				filepath = os.path.join(latest_folder, file) 
				finalpath = re.sub(r'_SCZ.img', '_SCZ_v01.img', filepath) 
				
				if not os.path.exists(finalpath): 
					shutil.copyfile(filepath, finalpath)
