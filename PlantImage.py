import PlantUtils
import cv2

class PlantImage:

	def __init__(self, imagePath):
		self.path = imagePath
		self.name = PlantUtils.PlantUtils.getImageNameFromPath(imagePath)
		self.date = PlantUtils.PlantUtils.getDateFromImageName(self.name)
		self.img = cv2.imread(imagePath, 0)

	def show(self):
		cv2.namedWindow('image', cv2.WINDOW_NORMAL)
		cv2.imshow(self.name, self.img)
		cv2.waitKey(0)
