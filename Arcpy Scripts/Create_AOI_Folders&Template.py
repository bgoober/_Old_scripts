import os 
import shutil 
import re

root_directory = '/home/ben/Documents/'
template = '/home/ben/Documents/bitcoin.pdf'

tasks = ['a', 'b', 'c', 'd', 'e', 'f']
for task in tasks:
	folders = '/home/ben/Documents/{}/'.format(task)
	if not os.path.exists(folders):
		os.makedirs(folders)

for folder in os.listdir(root_directory):
	shutil.copy(template, root_directory)
		
'''
directory = 'U:\\GAIT QC\\Baseline Exports\\'
directory1 = '/home/ben/Documents/'
template1 = '/home/ben/Desktop/bitcoin.pdf'
template = 'C:\\usr\\be006884\\Desktop\\TDS7_Template.gdb' 

tasks = ['a', 'b', 'c', 'd', 'e', 'f'] # a list of all the aoi task designations such as a07w075a which are the f15min column in the aoi shapefile 

for task in tasks:
	task_folders = os.mkdir(tasks, directory1)
# make folders with the names of all the values in the tasks list object

for folders in directory:
	aoi_templates = os.copy(template1, folders)

'''


root_directory = '/home/ben/Documents/a/' # 'C:\\GAIT_QC\\Baseline Exports\\'
template = '/home/ben/Documents/bitcoin.pdf' #'\\TDS7_Template.gdb'

tasks = ['a', 'b', 'c', 'd', 'e', 'f'] # full f15min list
for task in tasks:
	aoi_folders = '/home/ben/Documents/a/{}/'.format(task)  # 'C:\\GAIT_QC\\Baseline Exports\\{}'.format(task)
	if not os.path.exists(aoi_folders):
		os.makedirs(aoi_folders)

list_of_folders = []	

for folders in os.listdir(root_directory):
	folder_paths = os.path.join(root_directory, folders)
	list_of_folders.append(folder_paths)
	shutil.copy(template, folder_paths)

'''
Then, we make a list of the specific paths to the .gdb files in all of those os.path(aoi_folders) list
which then become our inputs for the Output GDB File parameter, according to the AOI that we queried for 

Can we do a mass query attribute on the aoi.shp for all of the different values in the tasks list object,
and use that output as the clip parameter? Or does each one have to be done individually?




'''


import os
import csv
import shutil


root_directory = 'U:\\GAIT\\GAIT QC Runs\\Exported Data Folder(s)\\Baseline Exports'
template = 'C:\\Users\\be006884\\Desktop\\TDS7_Template.gdb'

tasks = []

def get_atts():

	csv_file = 'C:\\Users\\be006884\\Desktop\\aois.csv'
	with open(csv_file, 'r') as file:
		reader=csv.reader(file)
		fieldnames = csv.DictReader(file).fieldnames
		for row in reader:
			tasks.append(row[8])

get_atts()

print(tasks)

for task in tasks:
	aoi_folders = 'U:\\GAIT\\GAIT QC Runs\\Exported Data Folder(s)\\Baseline Exports\\{}'.format(task)  
	if not os.path.exists(aoi_folders):
		os.makedirs(aoi_folders)

for folders in os.listdir(root_directory):
	folder_paths = os.path.join(root_directory, folders)
	shutil.copy(template, folder_paths)

