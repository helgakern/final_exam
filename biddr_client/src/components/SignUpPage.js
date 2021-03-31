import React, { Component } from 'react';
import { User } from "../requests";

class SignUpPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      errors: []
    }
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleSubmit(event) {
    event.preventDefault();
    const { currentTarget } = event;
    const formData = new FormData(currentTarget);
    const params = {
      user: {
        first_name: formData.get('firstName'),
        last_name: formData.get('lastName'),
        email: formData.get('email'),
        password: formData.get('password'),
        password_confirmation: formData.get('passwordConfirmation')
      }
    }
    User.create(params)
      .then(data => {
        if (data.status === 422) {
          this.setState((state) => {
            return {
              errors: data.errors
            }
          })
        } else {
          this.props.history.push('/sign_in', 'hello')
        }
      })
  }

  render() {
    return(
      <main>
        <h1>Sign Up</h1>
        { Object.keys(this.state.errors).length > 0 ? (
          <div>Failed to create User</div>
        ) : null
        }

        <form className="ui form" onSubmit={ this.handleSubmit }>
          <div className="field">
            <label htmlFor="first_name">First Name</label>
            <input
              type="text"
              name="first_name"
              id="first_name"
              placeholder="First Name"
              required
            />
          </div>
          <div className="field">
            <label htmlFor="last_name">Last Name</label>
            <input
              type="text"
              name="last_name"
              id="last_name"
              placeholder="Last Name"
              required
            />
          </div>
          <div className="field">
            <label htmlFor="email">Email</label>
            <input
              type="email"
              name="email"
              id="email"
              placeholder="email@domain.com"
              required
            />
          </div>
          <div className="field">
            <label htmlFor="password">Password</label>
            <input
              type="password"
              name="password"
              id="password"
              placeholder="Enter your password"
              required
            />
          </div>
          <div className="field">
            <label htmlFor="password_confirmation">Password Confirmation</label>
            <input
              type="password"
              name="password_confirmation"
              id="password_confirmation"
              placeholder="Enter your password again"
              required
            />
          </div>

          <button className="ui button" type="submit">
            Submit
          </button>
        </form>
      </main>
    )
  }
}
  
export default SignUpPage