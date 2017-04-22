from PlantUtils import PlantUtils as utils
import cv2

class PlantImage:

	def __init__(self, imagePath):
		self.path = imagePath
		self.name = utils.getImageNameFromPath(imagePath)
		self.date = utils.getDateFromImageName(self.name)
		self.img = cv2.imread(imagePath, 0)

	def show():
		cv2.imshow(self.img)
