import os

directory = 'U:\\GAIT\\GAIT QC Runs\\Exported Data Folder(s)\\Baseline Exports'

for folder in task_folders:
	TDS = 'U:\\GAIT\\GAIT QC Runs\\Exported Data Folder(s)\\Baseline Exports\\{}\\TDS'.format(folder)
	if not os.path.exists(TDS):
		os.makedirs(TDS)




# this code creates a directory called TDS inside all the folders that are contained within the directory object







