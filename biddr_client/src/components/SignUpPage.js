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
        <h1>Sign Up Page</h1>
        { Object.keys(this.state.errors).length > 0 ? (
          <div>Failed to create User</div>
        ) : null
        }
        <form onSubmit={this.handleSubmit}>
          <div>
            <label htmlFor='firstName'>First Name</label>
            <input type='text' name='firstName'/>
          </div>
          <div>
            <label htmlFor='lastName'>Last Name</label>
            <input type='text' name='lastName'/>
          </div>
          <div>
            <label htmlFor='email'>Email</label>
            <input type='email' name='email'/>
          </div>
          <div>
            <label htmlFor='password'>Password</label>
            <input type='password' name='password'/>
          </div>
          <div>
            <label htmlFor='passwordConfirmation'>Confirm Password</label>
            <input type='password' name='passwordConfirmation'/>
          </div>
          <input type='submit' value='Create User'/>
        </form>
      </main>
       )
    }
  }
  
  export default SignUpPage