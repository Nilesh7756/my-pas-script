import subprocess
import requests

t = subprocess.Popen('cf oauth-token', stdout=subprocess.PIPE, shell=True)
cf_token, err = t.communicate()


def get_all_apps():

	url = 'http://api.system.pcf.local/v2/apps'
	headers = {'Authorization': cf_token.strip()}
	get_apps = requests.get(url, headers=headers)
	x = get_apps.json()

	for i in x.get('resources'):

		print i.get("metadata"),i.get("entity").get("name")

def main():
	
	print get_all_apps()

main()
