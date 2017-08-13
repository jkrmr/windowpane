import React, { Component } from 'react'
import { Form, FormGroup, Input } from 'reactstrap'

class TweetSearchForm extends Component {
  constructor (props) {
    super(props)
    this.state = { searchQuery: props.searchQuery }
  }

  getValidationState () {
    const length = this.state.searchQuery.length
    return (length < 1) ? 'danger' : 'success'
  }

  handleOnChange (event) {
    clearTimeout(this.state.timer)

    const searchQuery = event.target.value
    this.setState({ searchQuery })
    this.props.setAppState({ searchQuery })

    if (!searchQuery.length) {
      this.props.clearFetchedTweets()
    } else {
      const waitTime = 600
      this.state.timer =
        setTimeout(() => {
          this.props.queryForTweets(searchQuery)
        }, waitTime)
    }
  }

  handleSubmit (event) {
    event.preventDefault()
    this.props.queryForTweets(this.state.searchQuery)
  }

  componentWillUpdate (props) {
    // if in response to a new query, update state so input value updates
    if (props.searchQuery.length > 0) {
      this.state.searchQuery = props.searchQuery
    }
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
            value={this.state.searchQuery}
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
