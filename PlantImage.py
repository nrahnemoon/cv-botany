import PlantUtils
import cv2

class PlantImage:

	def __init__(self, imagePath):
		self.path = imagePath
		self.name = PlantUtils.PlantUtils.getImageNameFromPath(imagePath)
		self.date = PlantUtils.PlantUtils.getDateFromImageName(self.name)
		self.img = cv2.imread(imagePath, cv2.IMREAD_COLOR)

	def show(self):
		cv2.namedWindow(self.name, cv2.WINDOW_NORMAL)
		cv2.startWindowThread()
		cv2.imshow(self.name, self.img)
		cv2.waitKey(0)
		cv2.destroyAllWindows()
		cv2.waitKey(1)
