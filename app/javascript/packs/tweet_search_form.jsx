import React, { Component } from 'react'
import { Form, FormGroup, Input } from 'reactstrap'
import axios from 'axios'

class TweetSearchForm extends Component {
  constructor (props) {
    super(props)
    this.state = { value: '' }
  }

  getValidationState () {
    const length = this.state.value.length
    return (length < 1) ? 'danger' : 'success'
  }

  handleOnChange (event) {
    clearTimeout(this.state.timer)

    const value = event.target.value
    this.setState({ value })

    if (!value.length) {
      this.props.setAppState({ tweets: [] })
    } else {
      const waitTime = 650
      this.state.timer =
        setTimeout(this.queryForTweets.bind(this), waitTime)
    }
  }

  handleSubmit (event) {
    event.preventDefault()
    this.queryForTweets()
  }

  queryForTweets () {
    axios.get(`/feed.json?username=${this.state.value}`)
         .then(({ data }) => this.props.setAppState({
           user: data.user,
           tweets: data.tweets
         }))
         .catch(error => this.props.setAppState({ error: error }))
  }

  render () {
    return (
      <Form
        action='/feed'
        method='get'
        onSubmit={this.handleSubmit.bind(this)}>

        <FormGroup color={this.getValidationState()}>
          <Input
            name='username'
            value={this.state.value}
            placeholder="Let's find some heckin tweets..."
            state={this.getValidationState()}
            onChange={this.handleOnChange.bind(this)}
            required='true' />
        </FormGroup>
      </Form>
    )
  }
}

export default TweetSearchForm
