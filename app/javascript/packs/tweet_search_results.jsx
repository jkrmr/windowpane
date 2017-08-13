import React from 'react'
import { ListGroup } from 'reactstrap'
import TweetSearchResult from './tweet_search_result'

const TweetSearchResults = ({ userIsPrivate, searchQuery, user, tweets }) => {
  if (searchQuery.length === 0) {
    return <div />
  }

  if (userIsPrivate) {
    return (
      <div className='search-results-header'>
        No tweets found
        for <a href={`https://twitter.com/${searchQuery}`}>
          <span className='user-handle'>{searchQuery}</span>
        </a>.
        That feed may be private.
      </div>
    )
  }

  if (tweets.length === 0) {
    return (
      <div className='search-results-header'>
        <span className='text-muted'>
          Searching...
        </span>
      </div>
    )
  }

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
