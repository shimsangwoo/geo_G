import requests

# Replace YOUR_API_KEY with your actual API key
api_key = 'YOUR_API_KEY'

# Specify the endpoint URL for geocoding
endpoint_url = 'http://api.vworld.kr/req/address'

# Set the query parameters for the API request
params = {
    'service': 'address',
    'request': 'getCoord',
    'version': '2.0',
    'crs': 'EPSG:4326',
    'address': '서울특별시 강남구 역삼동 825-22',
    'refine': 'true',
    'simple': 'false',
    'format': 'json',
    'type': 'road'
}

# Send the API request and retrieve the response
response = requests.get(endpoint_url, params=params, headers={'User-Agent': 'Mozilla/5.0'})

# Parse the API response and extract the latitude and longitude
data = response.json()
latitude = data['response']['result']['point']['y']
longitude = data['response']['result']['point']['x']

# Print the latitude and longitude
print('Latitude:', latitude)
print('Longitude:', longitude)
