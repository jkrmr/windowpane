import React from 'react'
import { ListGroup } from 'reactstrap'
import TweetSearchResult from './tweet_search_result'

const TweetSearchResults = ({user, tweets}) => {
  if (tweets.length === 0) { return <div /> }

  return (
    <div>
      <div style={{textAlign: 'center'}}>
        Recent tweets by {user}
      </div>

      <ListGroup>
        {tweets.map((tweet) =>
          <TweetSearchResult tweet={tweet} key={tweet.id} />)}
      </ListGroup>
    </div>
  )
}

export default TweetSearchResults
