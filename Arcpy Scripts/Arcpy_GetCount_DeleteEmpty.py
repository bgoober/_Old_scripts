import arcpy, os

arcpy.env.workspace = input(['Enter path to geodatabase here: '])

featureClasses = arcpy.ListFeatureClasses()

input_tables = []

for fc in featureClasses:
    input_tables.append(fc)

for fc in input_tables:
    print(fc)
    result = arcpy.GetCount_management(fc)
    count = int(result.getOutput(0))
    print(count)
    if count == 0:
        print("The number of features in {} is 0".format(fc))
        print("Deleting {}".format(fc))
        #arcpy.Delete_management(fc)

for fc in input_tables:
    print(fc)
        
