import configparser
import requests
import sys

#retrieves api key
def get_config():
    c = configparser.ConfigParser()
    c.read('config.ini') #reads name of file
    return[c['api_key']]

# writing GET request
def get_spotify(api_key):
    url = requests.get("https://api.spotify.com/v1/search?q=Mamoru%20Miyano&type=artist", header={'api_key': api_key},
    params={'q': 'Mamoru Miyano', 'type':'artist'}
    r = requests.get(url)
    return r.json()
    

def main():
	config = get_config()
	api_key= config[0]
	spotify = get_spotify(api_key)

	print(spotify)
    print("{: .if} is the best artist.").format('type')

if __name__ == '__main__':
	main()