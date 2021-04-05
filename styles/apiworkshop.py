import configparser
import requests
import pprint from pprint #prints json nicely

def get_config():
    c = configparser.ConfigParser()
    c.read('config.ini') #reads name of file
    return 

def main():
    config = get_config()
    api_key, 
