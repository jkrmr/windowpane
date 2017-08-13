import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { Form, FormGroup, Input } from 'reactstrap'

class TweetSearchForm extends Component {
  getValidationState () {
    const length = this.props.searchQuery.length
    return (length < 1) ? 'danger' : 'success'
  }

  handleOnChange (event) {
    clearTimeout(this.timer)

    const searchQuery = event.target.value
    this.props.setAppState({
      searchQuery: searchQuery,
      userIsPrivate: false
    })

    if (!this.props.searchQuery.length) {
      this.props.clearFetchedTweets()
    } else {
      const waitTime = 600
      this.timer = setTimeout(this.props.queryForTweets, waitTime)
    }
  }

  handleSubmit (event) {
    event.preventDefault()
    this.props.queryForTweets()
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

TweetSearchForm.propTypes = {
  searchQuery: PropTypes.string.isRequired,
  setAppState: PropTypes.func.isRequired,
  clearFetchedTweets: PropTypes.func.isRequired,
  queryForTweets: PropTypes.func.isRequired
}

export default TweetSearchForm
