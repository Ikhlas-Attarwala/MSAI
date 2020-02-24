import requests
import bs4
Soup = bs4.BeautifulSoup
import re

page = requests.get("http://www.chessgames.com/perl/chessgame?gid=1817323")
print(page.content)

soup = BeautifulSoup(page.content, 'html.parser')
