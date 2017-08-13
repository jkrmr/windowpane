import React from 'react'
import ReactDOM from 'react-dom'
import { Alert } from 'reactstrap'

class FlashMessage extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      visible: true
    }
  }

  onDismiss () {
    this.setState({ visible: false })
  }

  getMessageType () {
    switch (this.props.type) {
      case 'alert':
        return 'danger'
      case 'notice':
        return 'info'
      default:
        return 'warning'
    }
  }

  render () {
    return (
      <Alert
        color={this.getMessageType()}
        isOpen={this.state.visible}
        toggle={this.onDismiss.bind(this)}>
        {this.props.message}
      </Alert>
    )
  }
}

export default Alert

document.addEventListener('DOMContentLoaded', () => {
  const node = document.querySelector('.js-flash-message')
  if (!node) { return }

  const data = JSON.parse(node.getAttribute('data'))
  const type = data[0]
  const message = data[1]

  ReactDOM.render(<FlashMessage type={type} message={message} />, node)
})
