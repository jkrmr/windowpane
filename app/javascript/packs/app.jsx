import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import TweetSearchForm from './tweet_search_form'
import TweetSearchResults from './tweet_search_results'

class App extends Component {
  constructor (props) {
    super(props)
    this.state = {
      user: '',
      tweets: []
    }
  }

  setAppState (state) {
    this.setState(state)
  }

  clearTweets () {
    this.setState({ tweets: [] })
  }

  render () {
    return (
      <div>
        <TweetSearchForm
          setAppState={this.setAppState.bind(this)} />

        <TweetSearchResults
          user={this.state.user}
          tweets={this.state.tweets} />
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const anchor = document.body.querySelector('.js-twitter-search')
  if (!anchor) { return }
  ReactDOM.render(<App />, anchor)
})
