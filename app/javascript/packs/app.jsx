import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import TweetSearchForm from './tweet_search_form'
import TweetSearchResults from './tweet_search_results'
import axios from 'axios'

class App extends Component {
  constructor (props) {
    super(props)
    this.state = {
      user: '',
      tweets: []
    }
  }

  queryForTweets ({user}) {
    axios.get(`/feed.json?username=${user}`)
         .then(({data}) => this.setState({
           user: data.user,
           tweets: data.tweets
         }))
         .catch(error => console.info(error))
  }

  render () {
    return (
      <div>
        <TweetSearchForm
          submitHandler={this.queryForTweets.bind(this)} />
        <TweetSearchResults
          user={this.state.user}
          tweets={this.state.tweets} />
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.body.appendChild(document.createElement('div'))
  )
})
