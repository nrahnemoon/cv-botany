import time
import urllib
import urllib2
from bs4 import BeautifulSoup
import os
import PlantImage

imgDirUrl = 'http://mlcv.robotany.ag/data/img_raw/'
imgDirLocal = './images/'

class PlantUtils:

	@staticmethod
	def downloadImages():

		plantImages = []
		page = BeautifulSoup(urllib2.urlopen(imgDirUrl))
		anchors = page.findAll('a')
		image = urllib.URLopener()

		if not os.path.exists(imgDirLocal):
			os.makedirs(imgDirLocal)

		for anchor in anchors:
			href = anchor.get('href')
			if "png" in href:
				imageName = href.split('./', 1)[1]
				urlPath = imgDirUrl + imageName
				savePath = imgDirLocal + imageName
				if os.path.exists(savePath):
					print(imageName + ' already exists.')
				else:
					image.retrieve(urlPath, savePath)
					print('Saved ' + imageName + '.')
				plantImages.append(PlantImage.PlantImage(savePath))

		return plantImages

	@staticmethod
	def getDateFromImageName(imageName):
		return time.strptime(imageName[0:20], '3_%Y-%m-%d%H:%M:%S')

	@staticmethod
	def getImageNameFromPath(path):
		return path.split('./images/', 1)[1]

	@staticmethod
	def getImageDirectory():
		return imgDirLocal
