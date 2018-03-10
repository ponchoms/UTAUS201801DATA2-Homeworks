# Dependencies
import tweepy
import json
import numpy as np
import pandas as pd
# Import and Initialize Sentiment Analyzer
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()

# Twitter API Keys
consumer_key = "Ed4RNulN1lp7AbOooHa9STCoU"
consumer_secret = "P7cUJlmJZq0VaCY0Jg7COliwQqzK0qYEyUF9Y0idx4ujb3ZlW5"
access_token = "839621358724198402-dzdOsx2WWHrSuBwyNUiqSEnTivHozAZ"
access_token_secret = "dCZ80uNRbFDjxdU2EckmNiSckdoATach6Q8zb7YYYE5ER"

# Setup Tweepy API Authentication
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, parser=tweepy.parsers.JSONParser())

# Target User Account
target_user = "@DalaiLama"
user_list = ["@CNN", "@FoxNews", "@nytimes", "@BBCWorld", "@CBS" ]

# Variables for holding sentiments
tweet_data = {
    "tweet_source":[],
    "tweet_text":[],
    "tweet_date":[],
    "compound_list":[],
    "positive_list":[],
    "negative_list":[],
    "neutral_list":[]}

positive_list=[]
negative_list=[]
neutral_list=[]

#for status in tweepy.Cursor(api.user_timeline).items(100):
#process_status(status)

# Loop through 10 pages of tweets (total 200 tweets)
for x in range(5):

    # Loop through each user
    for user in user_list:

    # Get all tweets from home feed
        tweets = api.user_timeline(user_list, page=x+1)

        # Loop through all tweets
        for tweet in tweets:
            #print(tweet['text'])

            tweet_data["tweet_source"].append(tweet["user"]["name"])
            tweet_data["tweet_text"].append(tweet["text"])
            tweet_data["tweet_date"].append(tweet["created_at"])

            # Run Vader Analysis on each tweet

            tweet_data["compound_list"].append(analyzer.polarity_scores(tweet["text"])["compound"])

            #compound = analyzer.polarity_scores(tweet["text"])["compound"]
            pos = analyzer.polarity_scores(tweet["text"])["pos"]
            neu = analyzer.polarity_scores(tweet["text"])["neu"]
            neg = analyzer.polarity_scores(tweet["text"])["neg"]

            # Add each value to the appropriate list
            #compound_list.append(compound)
            positive_list.append(pos)
            negative_list.append(neg)
            neutral_list.append(neu)

tweet_data["positive_list"]  = positive_list
tweet_data["negative_list"]  = negative_list
tweet_data["neutral_list"]  = neutral_list

all_data=pd.DataFrame(tweet_data, columns=["tweet_source",
    "tweet_text",
    "tweet_date",
    "compound_list",
    "positive_list",
    "negative_list",
    "neutral_list"])

all_data
input("")
