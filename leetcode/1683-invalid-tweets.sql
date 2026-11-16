-- New operator needed to count the number of characters. CHAR_LENGTH(Col_1)
select tweet_id from Tweets
where CHAR_LENGTH(content) > 15; 