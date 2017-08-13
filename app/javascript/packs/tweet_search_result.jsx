import React from 'react'
import {
  ListGroupItem,
  ListGroupItemText
} from 'reactstrap'

const TweetSearchResult = ({tweet}) => {
  return (
    <ListGroupItem className='justify-content-center'>
      <ListGroupItemText>
        <div dangerouslySetInnerHTML={{__html: tweet.body}} />
        <small class='text-muted justify-content-center'>
          {tweet.tweet_type} at {tweet.date_posted}
        </small>
      </ListGroupItemText>
    </ListGroupItem>
  )
}

export default TweetSearchResult
