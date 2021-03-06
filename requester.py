import requests
import sys

from colorama import Fore, Back, Style

requests.packages.urllib3.disable_warnings(requests.packages.urllib3.exceptions.InsecureRequestWarning)

def format_text(title, item):
    cr = '\r\n'
    section_break = cr + "*" * 20 + cr
    item = str(item)
    text = Style.BRIGHT + Fore.RED + title + Fore.RESET + section_break + item + section_break
    return text;

inp = raw_input("Do you want to set a proxy? ")

proxies = {}

if inp == "yes":
    while True:
        pr = raw_input("Enter the protocol type (http/https) and the proxy in the form PROTOCOL://IP:PORT [http, http://127.0.0.1:8080] -  (enter q to quit): ")
        if pr.lower() == 'q':
            break
        k, v = pr.split(',')
        proxies[k] = v.strip()
    print proxies
    r = requests.get(sys.argv[1], verify=False, proxies=proxies)
else:
    r = requests.get(sys.argv[1], verify=False)

print format_text('Status code is: ', r.status_code)
print format_text('Headers is: ', r.headers)
print format_text('Cookies is: ', r.cookies)
print format_text('Text is: ', r.text)
