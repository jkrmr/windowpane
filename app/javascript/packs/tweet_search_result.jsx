import React from 'react'
import { ListGroupItem } from 'reactstrap'
import PropTypes from 'prop-types'

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

TweetSearchResult.PropTypes = {
  tweet: PropTypes.object.isRequired
}

export default TweetSearchResult
