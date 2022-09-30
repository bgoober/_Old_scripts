import math

def ht(sun, shadow):
	ht = math.tan(sun*math.pi/180.0)*shadow
	print(ht)
	return;

# ht = height
# sun = the angle of the sun when the image was taken
# shadow = shadow length from the base of the object in question
