import subprocess
import requests

t = subprocess.Popen('cf oauth-token', stdout=subprocess.PIPE, shell=True)
cf_token, err = t.communicate()


def get_container_host():

	url = 'http://api.system.pcf.local/v2/spaces'
	headers = {'Authorization': cf_token.strip()}
	get_space = requests.get(url, headers=headers)
	x = get_space.json()

	for i in x.get('resources'):
	
	    spaces = i.get("metadata").get("guid")
	    url_1 = 'http://api.system.pcf.local/v2/spaces/{0}/apps'.format(spaces)
	    get_all_apps = requests.get(url_1, headers=headers)
	    a = get_all_apps.json()
	    for p in a.get('resources'):
	        all_apps = p.get("metadata").get("guid")
	        url_2 = 'http://api.system.pcf.local/v2/apps/{0}/stats'.format(all_apps)
		get_all_conatiner_host = requests.get(url_2, headers=headers)
	        b = get_all_conatiner_host.json()
	        for q in b:
        	    return "INDEX: {0}".format(q), "APP-NAME: " + b[q].get("stats").get("name"), "Conatiner-Host: " + b[q].get("stats").get("host")
#	return output_ch


def main():
	
	print get_container_host()

main()
