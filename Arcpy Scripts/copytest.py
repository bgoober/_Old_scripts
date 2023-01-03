import os
import shutil
import re

granule = raw_input('Enter Granule ').upper()
# this iteration is for Sentinel imagery, and the granule name must be typed into the python CLI and not dragged-and-dropped.

directory = 'D:\\GeoCue_Data\\SentinelRPM_Cloud_Edits\\{}\\'.format(granule)
# formats the granule object into the space between {} in the above line, thereby creating a full path to the specific folder
if os.path.exists(directory):

	for file in os.listdir(directory):
	
		if re.search(r'SCZ', file):
			filepath = os.path.join(directory, file)
			finalpath = re.sub(r'SCZ','SCZ_v01',filepath)
			
			if not os.path.exists(finalpath):
				shutil.copyfile(filepath, finalpath)
		
