from selenium import webdriver
#from selenium.webdriver.support.ui import Webdriverwait
driver = webdriver.Firefox()
#chromedriver = "C:/Users/OLYMPIA/Downloads/chromedriver_win32/chromedriver.exe"
#driver = webdriver.Chrome(chromedriver)
#import time
import csv

with open('film_ratings.csv') as csvfile:
	rating_csv = list(csv.reader(csvfile, delimiter=','))
	
with open('film_reviews.csv', 'w', encoding='utf-8') as frev:
	frev.write("title, rating, duration, certificate, release_date, review_date, reviewer, url \n")

with open('film_reviews.csv', 'a', encoding='utf-8') as frev:		
	for row in rating_csv[6250:6500]:
		try:
			url = row[2]
			#print(url)
			#print(row[2])
			
			driver.get(url)
			
			title = driver.find_element_by_xpath('//*[@class="list__keyline delta txt--mid-grey"]/li//a')
			
			rating = driver.find_element_by_xpath('//html/body/main/article/div/div/div[2]/div[2]/div/span')
			#rating = str(len(rating))

			duration = driver.find_element_by_xpath('//html/body/main/article/div/div/div[1]/ul/li[3]')
			#duration = duration.text[13:16]
			
			certificate = driver.find_element_by_xpath('//html/body/main/article/div/div/div[1]/ul/li[2]')
			#certificate = certificate.text[12:]
					
			release_date = driver.find_element_by_xpath('//html/body/main/article/div/div/div[1]/ul/li[1]')

			review_date = driver.find_element_by_xpath('//html/body/main/article/div/div/div[1]/p/time[1]')

			reviewer = driver.find_element_by_xpath('//html/body/main/article/div/div/div[1]/div[2]/span')

			#print(reviewer)

			#print(title + "," + rating.text + "," +  duration + "," + certificate + "," + release_date + "," + review_date + "," + reviewer + "," + url + "\n")
			frev.write(title.text + "," + (str(len(rating.text))) + "," +  duration.text[13:16] + "," + certificate.text[12:] + "," + release_date.text[13:] + "," + review_date.text + "," + reviewer.text + "," + url + "\n")
	
		except Exception as e:
			print(e)
	
driver.close()


