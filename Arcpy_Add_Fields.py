# This script is designed to copy and paste the complete path of a given geodatabase and iterate over the 
# Feature classes contained inside.
# The 8 fields below will be added to each feature class
# more extensive features such as calculating fields will be added once a more solid PostGIS database has been implemented

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
field_Names = ['STATE_NAME', 'SOURCE1', 'SOURCE2', 'ORIG_FC_NA', 'GH_ID', 'GH_NOTES', 'GH_STATUS']
fieldtype = "TEXT"

for fc in in_tables:
    print(fc)
    active_fields = [fields.name for fields in arcpy.ListFields(fc)]
    print(active_fields)
    for field in field_Names:
        if field.upper() in active_fields or field.lower() in active_fields:
            continue
        else:
            arcpy.AddField_management(fc, field, fieldtype, field_length=225)

print('AddFields Complete.')
