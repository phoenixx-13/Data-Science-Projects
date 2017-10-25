import csv
from selenium import webdriver
#from selenium.webdriver.support.ui import Webdriverwait
driver = webdriver.Firefox()
#chromedriver = "C:/Users/OLYMPIA/Downloads/chromedriver_win32/chromedriver.exe"
#driver = webdriver.Chrome(chromedriver)

with open('film_ratings.csv', 'w', encoding='utf-8') as fr:
	fr.write("Title, Rating \n")

for x in range(1, 475):
	url = "https://www.empireonline.com/movies/reviews/" + str(x)
	driver.get(url)
	
	titles = driver.find_elements_by_xpath('//p[@class="hdr no-marg gamma txt--black pad__top--half"]')

	ratings = driver.find_elements_by_class_name("stars--on")  # find all ratings

	#films_urls = driver.find_elements_by_xpath('//a[@href]')
	films_urls = driver.find_elements_by_xpath('//html/body/main/section/div[2]/article/a')

	with open('film_ratings.csv', 'a', encoding='utf-8') as fr:
		
		for i in range(len(titles)):
	
			try:
				fr.write(titles[i].text + " , " + str(len(ratings[i].text)) + " , " + films_urls[i].get_attribute('href') + "\n")  
			except Exception as e:
				print(e)
#time.sleep(3)
driver.close()