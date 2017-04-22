from PlantUtils import *
import cv2

class PlantImage:

	def __init__(self, imagePath):
		self.path = imagePath
		self.name = PlantUtils.getImageNameFromPath(imagePath)
		self.date = PlantUtils.getDateFromImageName(self.name)
		self.img = cv2.imread(imagePath, 0)
