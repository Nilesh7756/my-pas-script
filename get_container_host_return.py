import subprocess
import requests
import time

t = subprocess.Popen('cf oauth-token', stdout=subprocess.PIPE, shell=True)
cf_token, err = t.communicate()


def get_container_host():

	url = 'http://api.system.pcf.local/v2/spaces?results-per-page=100'
	headers = {'Authorization': cf_token.strip()}
	get_space = requests.get(url, headers=headers)
	x = get_space.json()
	result = {}
	#import pdb;pdb.set_trace()
	for i in x.get('resources'):
	
		spaces = i.get("metadata").get("guid")
	    	#import pdb;pdb.set_trace()	    
	    	url_1 = 'http://api.system.pcf.local/v2/spaces/{0}/apps'.format(spaces)
	    	get_all_apps = requests.get(url_1, headers=headers)
	    	a = get_all_apps.json()
	    	for p in a.get('resources'):
	        	all_apps = p.get("metadata").get("guid")
			#import pdb;pdb.set_trace()
	        	url_2 = 'http://api.system.pcf.local/v2/apps/{0}/stats'.format(all_apps)
			get_all_conatiner_host = requests.get(url_2, headers=headers)
	        	b = get_all_conatiner_host.json()
			for q in b:
                                if result.get(b[q].get("stats").get("host")): 
	       			    result[b[q].get("stats").get("host")].append("{0}, {1}".format(q,b[q].get("stats").get("name")))
                                else:
                                    result[b[q].get("stats").get("host")] = ["{0}, {1}".format(q,b[q].get("stats").get("name"))]
	#import pdb;pdb.set_trace()
	return result

def main():
	
	start_time = time.time()
	out_result = get_container_host()
	end_time = time.time()
	print (end_time - start_time)
	one_diego_cell = out_result.get('195.168.1.27')
	print "App-Instances Deployed on Container Host : 195.168.1.27 -> {0}".format(one_diego_cell)

main()
