# iOSTutorial
This is a simple app that parse user input to create an ouput in a textview with emoticons and links.

Emoticons are defined as anything within (), for instance (anh is cool) is an emoticon, anh is not cool is not an emoticon.
If a link is over https, a title will fetch over that title webpage. For instance, if the input is https//www.google.com, the title of the webpage will be fetched: Google. If the link is not over https, the title will not be fetched, for instance google.com.


To see a demo video, please see here: https://drive.google.com/open?id=0B0Q8RzqtvhaUTGFEekFmempuSWc

Example:
User input: 
(Anh is cool) Anh is not cool, google.com, https://www.google.com

Output: 
emoticons: ["Anh is cool"],
links: [
    link: google.com, title: No Title available,
    
    link: https://www.google.com, title: Google
]
