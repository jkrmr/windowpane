import React, { Component } from 'react'
import ReactDOM from 'react-dom'
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

    if (length < 1) {
      return 'error'
    } else {
      return 'success'
    }
  }

  handleOnChange (event) {
    this.setState({value: event.target.value})
  }

  render () {
    return (
      <Form action='/feed' method='get'>
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

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <TweetSearchForm name='React' />,
    document.body.appendChild(document.createElement('div'))
  )
})
