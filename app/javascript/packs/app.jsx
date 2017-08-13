import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import axios from 'axios'

import TweetSearchForm from './tweet_search_form'
import TweetSearchResults from './tweet_search_results'

class App extends Component {
  constructor (props) {
    super(props)
    this.state = {
      searchQuery: '',
      fetchedUser: '',
      fetchedTweets: [],
      userIsPrivate: false,
      error: ''
    }
  }

  queryForTweets (username = this.state.searchQuery) {
    this.setState({ searchQuery: username })
    axios.get(`/feed.json?username=${username}`)
         .then(response => {
           const { user, tweets } = response.data
           this.setState({
             fetchedUser: user,
             fetchedTweets: tweets,
             userIsPrivate: (tweets.length === 0)
           })
         })
         .catch(error => this.setState({ error }))
  }

  clearFetchedTweets () {
    this.setState({
      fetchedUser: '',
      fetchedTweets: [],
      userIsPrivate: false
    })
  }

  handleClick (event) {
    const { nodeName, text } = event.target

    if (nodeName === 'A' && text[0] === '@') {
      event.preventDefault()
      const username = text.slice(1)
      this.clearFetchedTweets()
      this.queryForTweets(username)
    }
  }

  setAppState (state) {
    this.setState(state)
  }

  render () {
    return (
      <div onClick={this.handleClick.bind(this)}>
        <TweetSearchForm
          searchQuery={this.state.searchQuery}
          setAppState={this.setAppState.bind(this)}
          clearFetchedTweets={this.clearFetchedTweets.bind(this)}
          queryForTweets={this.queryForTweets.bind(this)} />

        <TweetSearchResults
          userIsPrivate={this.state.userIsPrivate}
          searchQuery={this.state.searchQuery}
          user={this.state.fetchedUser}
          tweets={this.state.fetchedTweets} />
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const anchor = document.body.querySelector('.js-twitter-search')
  if (!anchor) { return }
  ReactDOM.render(<App />, anchor)
})
