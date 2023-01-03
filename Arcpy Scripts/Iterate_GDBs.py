import arcpy, os

# accept input for root folder containing multiple GDBs
root_folder = input(["Enter root folder containing geodatabases here: "])

# list the contents of the root folder and create the full path of each gdb by joining the root folder to the gdb
for gdb in os.listdir(root_folder):
    workspaces = os.path.join(root_folder, gdb)
    print(workspaces)

# create an empty list in which to place the gdb paths
    ws_list = []

# if the workspace path exists, append it to the ws_list and print the list to ensure it is in the correct datatype
    if os.path.exists(workspaces):
        ws_list.append(workspaces)
    print(ws_list)

# for each workspace in the ws_list: set the environment equal to that workspace, print the workspace to check it is correct, then list the feature classes within the gdb using arcpy
    for workspace in ws_list:
        arcpy.env.workspace = workspace
        print("The current workspace is {}".format(workspace))

# list the feature classes and assign them to an object 
        featureClasses = arcpy.ListFeatureClasses()

# create an empty list with which to append each feature class 
        in_table = []

# append each feature class to the empty list
        for fc in featureClasses:
            in_table.append(fc)

# for each feature class in the in_table: print the fc, get the feature count of each feature class, then use getOutput to assign the integer value to an object. Print the count.   
        for fc in in_table:
            print(fc)
            result = arcpy.GetCount_management(fc)
            count = int(result.getOutput(0))
            print(count)

# If the count == 0: Print the feature class name, announce its deletion, then use arcpy to delete the empty feature class from the gdb
            if count == 0:
                print("The number of features in {} is 0".format(fc))
                print("Deleting {}".format(fc))
                arcpy.Delete_management(fc)


