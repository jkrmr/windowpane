import React from 'react'
import { ListGroup } from 'reactstrap'
import TweetSearchResult from './tweet_search_result'

const TweetSearchResults = ({user, tweets}) => {
  if (tweets.length === 0) { return <div /> }

  return (
    <div>
      <div className='search-results-header'>
        recent tweets by <span className='user-handle'>{user}</span>
      </div>

      <ListGroup>
        {tweets.map((tweet) =>
          <TweetSearchResult tweet={tweet} key={tweet.id} />)}
      </ListGroup>
    </div>
  )
}

export default TweetSearchResults
