import React, { Component } from 'react'
import { Form, FormGroup, Input } from 'reactstrap'

class TweetSearchForm extends Component {
  constructor (props) {
    super(props)
    this.state = {
      value: ''
    }
  }

  getValidationState () {
    const length = this.state.value.length
    return (length < 1) ? 'error' : 'success'
  }

  handleOnChange (event) {
    this.setState({value: event.target.value})
  }

  handleSubmit (event) {
    event.preventDefault()
    this.props.submitHandler({user: this.state.value})
  }

  render () {
    return (
      <Form action='/feed' method='get' onSubmit={this.handleSubmit.bind(this)}>
        <FormGroup>
          <Input
            name='username'
            value={this.state.value}
            placeholder="Let's find some heckin tweets..."
            onChange={this.handleOnChange.bind(this)}
            state={this.getValidationState()}
            required='true'
          />
        </FormGroup>
      </Form>
    )
  }
}

export default TweetSearchForm
