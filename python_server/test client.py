import requests

BASE = "http://89.74.117.71:5055/"



while True:
    userinput=input("1- get\n 2-post")

    
    if (userinput=="1"):
        response=requests.get(BASE+"grades", {"class": "2"})
        print(response.json()) 
        

    if(userinput=="2"):


        response=requests.post(BASE+"grades", {"class": 2, "grade":1 })
        print(response.json()) 

    
    







