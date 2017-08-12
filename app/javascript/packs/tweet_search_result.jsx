import React from 'react'

const TweetSearchResult = ({tweet}) => {
  return (
    <li>
      {tweet.tweet_type} at {tweet.date_posted}
      <br />
      <div dangerouslySetInnerHTML={{__html: tweet.body}} />
    </li>
  )
}

export default TweetSearchResult
