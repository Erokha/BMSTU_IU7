import requests

files = {'file': open('/Users/erokha/Desktop/test_screen.png', 'rb')}
requests.post('http://localhost:8000/api/v1/image', files=files)
