import configparser
import requests

def get_config():
    c = configparser.ConfigParser()
    c.read('config.ini') #reads name of file
    return[c['spotify']['api_key']]

# writing GET request
def get_spotify():
    url = "https://api.spotify.com/v1/search?q=Mamoru%20Miyano&type=artist&access_token=\()".format(api_key)
    r = requests.get(url)
    return r.json()

def main():
    config = get_config() 
    api_key = config[0]
    spotify = get_spotify(api_key)

    print(spotify)

