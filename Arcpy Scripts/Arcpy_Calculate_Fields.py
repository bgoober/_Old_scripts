# This script is designed to calculate certain fields inside a geodatabase, using arcpy.

import arcpy, os

# set the workspace equal to the input feature geodatabase path
arcpy.env.workspace = input(['Enter path to geodatabase here: '])

# define featureClasses as the list of feature classes in the current environment
featureClasses = arcpy.ListFeatureClasses()

# create the empty in_tables list variabe
in_tables = []

for fc in featureClasses:
    in_tables.append(fc)

# print which feature classes will be processed
for fc in in_tables:
    print('The following feature class will be processed: ')
    print(str(fc))

#field_Names = ['SPECIES', 'STATE_NAME', 'SOURCE1', 'SOURCE2', 'ORIG_FC_NA', 'GH_ID', 'GH_NOTES', 'GH_STATUS']
#field_Names = ['STATE_NAME', 'SOURCE1', 'SOURCE2', 'ORIG_FC_NA', 'GH_ID', 'GH_NOTES', 'GH_STATUS']
#fieldtype = "TEXT"

field_calc1 = "SOURCE1"
field_calc2 = "SOURCE2"
SN = "STATE_NAME"
gh_notes = "GH_NOTES"
source1 = '"USGS"' # '""' - This single quotes/double quotes sandwich is needed or a Name Error will be thrown when trying to calulcate this object's value
source2 = '"goHUNT"' # '""' - This single quotes/double quotes sandwich is needed or a Name Error will be thrown when trying to calulcate this object's value
state_name = '"Washington"' # '""' - This single quotes/double quotes sandwich is needed or a Name Error will be thrown when trying to calulcate this object's value
notes ='"The GH_ID was not calculated for any NHD layers because there are not enough Unique IDs for all the NHD layers, and all of the time it would take to create and calculate each layer\'s GH_ID."'
# '""' - This single quotes/double quotes sandwich is needed or a Name Error will be thrown when trying to calulcate this object's value

for fc in in_tables:
    print(fc)
    print("Calculating SOURCE1")
    arcpy.CalculateField_management(fc, field_calc1, source1, "PYTHON3", code_block='', field_type="TEXT")
    print("Calculating SOURCE2")
    arcpy.CalculateField_management(fc, field_calc2, source2, "PYTHON3", code_block='', field_type="TEXT")
    print("Calculating STATE_NAME")
    arcpy.CalculateField_management(fc, SN, state_name, "PYTHON3", code_block='', field_type="TEXT")
    print("Calculating GH_NOTES")
    arcpy.CalculateField_management(fc, gh_notes, notes, "PYTHON3", code_block='', field_type="TEXT")

print('Calculate Fields Complete.')
