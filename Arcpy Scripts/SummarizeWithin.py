import arcpy
import os

workspace = arcpy.env.scratchWorkspace

# accept user-defined input layers
input_lyr1 = arcpy.GetParameterAsText(0)
input_lyr2 = arcpy.GetParameterAsText(1)

# define in_memory output layers (Think of this like a path to the data)
input_layer = r'in_memory/output1'
target_layer = r'in_memory/output2'

# create in_memory layers by copying user-defined inputs
arcpy.CopyFeatures_management(input_lyr1, input_layer)
arcpy.CopyFeatures_management(input_lyr2, target_layer)

# define the final in_memory layer that the tool will create
output_final = workspace + r'\output_final_Acres'

# run the tool with parameters set. Add "" as a placeholder for parameters you don't mean to set, but must include
arcpy.SummarizeWithin_analysis(input_layer, target_layer, output_final, "ONLY_INTERSECTING", "", "ADD_SHAPE_SUM", "ACRES")

# use SearchCursor to return the values in Sq_Acres field for each object in the output_final table
for i in arcpy.da.SearchCursor(output_final, ['SUM_Area_ACRES']):
    arcpy.AddMessage('Acres of overlap: ' + str(i[0]) + ' acres.' )










