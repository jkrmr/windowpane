import React from 'react'
import TweetSearchResult from './tweet_search_result'

const TweetSearchResults = ({user, tweets}) => {
  if (tweets.length === 0) { return <div /> }

  return (
    <div>
      <div>
        Recent tweets by {user}
      </div>
      <ul>
        {tweets.map((tweet, i) =>
          <TweetSearchResult tweet={tweet} key={i} />)}
      </ul>
    </div>
  )
}

export default TweetSearchResults
