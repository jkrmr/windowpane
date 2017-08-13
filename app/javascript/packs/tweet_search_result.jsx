import React from 'react'
import { ListGroupItem } from 'reactstrap'

const TweetSearchResult = ({tweet}) => {
  return (
    <ListGroupItem
      className='justify-content-center'
      style={{display: 'block'}}>

      <div dangerouslySetInnerHTML={{__html: tweet.body}} />

      <small className='text-muted'>
        {tweet.tweet_type} on {tweet.date_posted}
      </small>
    </ListGroupItem>
  )
}

export default TweetSearchResult
