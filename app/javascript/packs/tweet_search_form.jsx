import React, { Component } from 'react'
import { Form, FormGroup, Input } from 'reactstrap'

class TweetSearchForm extends Component {
  constructor (props) {
    super(props)
    this.state = {}
  }

  getValidationState () {
    const length = this.props.searchQuery.length
    return (length < 1) ? 'danger' : 'success'
  }

  handleOnChange (event) {
    clearTimeout(this.state.timer)

    const searchQuery = event.target.value
    this.props.setAppState({
      searchQuery: searchQuery,
      userIsPrivate: false
    })

    if (!this.props.searchQuery.length) {
      this.props.clearFetchedTweets()
    } else {
      const waitTime = 600
      this.state.timer = setTimeout(() => {
        this.props.queryForTweets(this.props.searchQuery)
      }, waitTime)
    }
  }

  handleSubmit (event) {
    event.preventDefault()
    this.props.queryForTweets(this.props.searchQuery)
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
            value={this.props.searchQuery}
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
