# Week 3 — Decentralized Authentication

[Click for Week 3 Instruction](https://github.com/omenking/aws-bootcamp-cruddur-2023/blob/week-3/journal/week3.md)


- [Todo Checklist](#todo-checklist)
- [Required work and Class Instructions](#required-work-and-class-instructions)
- [Homework Challenge](#homework-challenges)

***
# Todo Checklist
- [Watched Ashish's Week 3 - Decenteralized Authentication]	(https://youtu.be/tEJIeII66pY?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- Watch Chirag Week 3 - Spending Considerations (Not yet posted)	
- [Setup Cognito User Pool]	(https://youtu.be/9obl7rVgzJw?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Implement Custom Signin Page]	(https://youtu.be/9obl7rVgzJw?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Implement Custom Signup Page]	(https://youtu.be/T4X4yIzejTc?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Implement Custom Confirmation Page]	(https://youtu.be/T4X4yIzejTc?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Implement Custom Recovery Page]	(https://youtu.be/T4X4yIzejTc?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Verify JWT token server side]	(https://youtu.be/d079jccoG-M?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Watch about different approaches to verifying JWTs]	(https://youtu.be/nJjbI4BbasU?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
***
# Required work and Class Instructions

## Provision Cognito User Group
Using the AWS Console we'll create a Cognito User Group

![Alt text](../_docs/assets/AWS%20Cognito%20User%20Pool%20Created.jpg)

## Install [AWS Amplify](https://aws.amazon.com/amplify/)

```
npm i aws-amplify --save
```

## Configure Amplify
We need to hook up our cognito pool to our code in the App.js
```js
import { Amplify } from 'aws-amplify';

Amplify.configure({
  "AWS_PROJECT_REGION": process.env.REACT_APP_AWS_PROJECT_REGION,
  "aws_cognito_region": process.env.REACT_APP_AWS_COGNITO_REGION,
  "aws_user_pools_id": process.env.REACT_APP_AWS_USER_POOLS_ID,
  "aws_user_pools_web_client_id": process.env.REACT_APP_CLIENT_ID,
  "oauth": {},
  Auth: {
    // We are not using an Identity Pool
    // identityPoolId: process.env.REACT_APP_IDENTITY_POOL_ID, // REQUIRED - Amazon Cognito Identity Pool ID
    region: process.env.REACT_AWS_PROJECT_REGION,           // REQUIRED - Amazon Cognito Region
    userPoolId: process.env.REACT_APP_AWS_USER_POOLS_ID,         // OPTIONAL - Amazon Cognito User Pool ID
    userPoolWebClientId: process.env.REACT_APP_AWS_USER_POOLS_WEB_CLIENT_ID,   // OPTIONAL - Amazon Cognito Web Client ID (26-char alphanumeric string)
  }
});
```

Add these to the docker-compose file under react

```yaml
    REACT_APP_AWS_PROJECT_REGION: "${AWS_DEFAULT_REGION}"
    REACT_APP_AWS_COGNITO_REGION: "${AWS_DEFAULT_REGION}"
    REACT_APP_AWS_USER_POOLS_ID: "us-east-1_BzA1k5NLF"
    REACT_APP_CLIENT_ID: "5qk6ml6n9ckj88mron9hbcc9ih"
```

## Conditionally show components based on logged in or logged out
Inside our HomeFeedPage.js under frontend-react-js/src/pages

```js
import { Auth } from 'aws-amplify';

// set a state
const [user, setUser] = React.useState(null);

// check if we are authenicated
const checkAuth = async () => {
  Auth.currentAuthenticatedUser({
    // Optional, By default is false. 
    // If set to true, this call will send a 
    // request to Cognito to get the latest user data
    bypassCache: false 
  })
  .then((user) => {
    console.log('user',user);
    return Auth.currentAuthenticatedUser()
  }).then((cognito_user) => {
      setUser({
        display_name: cognito_user.attributes.name,
        handle: cognito_user.attributes.preferred_username
      })
  })
  .catch((err) => console.log(err));
};
```

### We'll update ProfileInfo.js
```js
import { Auth } from 'aws-amplify';

const signOut = async () => {
  try {
      await Auth.signOut({ global: true });
      window.location.href = "/"
  } catch (error) {
      console.log('error signing out: ', error);
  }
}
```

## Signin Page
go into signinPage.js
```js
import { Auth } from 'aws-amplify';

const onsubmit = async (event) => {
    setErrors('')
    event.preventDefault();
    try {
      Auth.signIn(username, password)
        .then(user => {
          localStorage.setItem("access_token", user.signInUserSession.accessToken.jwtToken)
          window.location.href = "/"
        })
        .catch(err => { console.log('Error!', err) });
    } catch (error) {
      if (error.code == 'UserNotConfirmedException') {
        window.location.href = "/confirm"
      }
      setErrors(error.message)
    }
    return false
}


```
### Troubleshooting
We have to set a password to be able to make the account active./
Use the following AWS CLI code to reset a permenant password, then try again.
```
aws cognito-idp admin-set-user-password \
  --user-pool-id <your-user-pool-id> \
  --username <username> \
  --password <password> \
  --permanent
```
![Alt text](../_docs/assets/Week3-Signin%20Page.png)

## Signup Page
```js
import { Auth } from 'aws-amplify';

const [errors, setErrors] = React.useState('');

const onsubmit = async (event) => {
  event.preventDefault();
  setErrors('')
  try {
      const { user } = await Auth.signUp({
        username: email,
        password: password,
        attributes: {
          name: name,
          email: email,
          preferred_username: username,
        },
        autoSignIn: { // optional - enables auto sign in after user is confirmed
            enabled: true,
        }
      });
      console.log(user);
      window.location.href = `/confirm?email=${email}`
  } catch (error) {
      console.log(error);
      setErrors(error.message)
  }
  return false
}

```
![Alt text](../_docs/assets/Week3-Signup%20Page.png)

## Confirmation Page
```js
import { Auth } from 'aws-amplify';

const resend_code = async (event) => {
  setErrors('')
  try {
    await Auth.resendSignUp(email);
    console.log('code resent successfully');
    setCodeSent(true)
  } catch (err) {
    // does not return a code
    // does cognito always return english
    // for this to be an okay match?
    console.log(err)
    if (err.message == 'Username cannot be empty'){
      setErrors("You need to provide an email in order to send Resend Activiation Code")   
    } else if (err.message == "Username/client id combination not found."){
      setErrors("Email is invalid or cannot be found.")   
    }
  }
}

const onsubmit = async (event) => {
  event.preventDefault();
  setErrors('')
  try {
    await Auth.confirmSignUp(email, code);
    window.location.href = "/"
  } catch (error) {
    setErrors(error.message)
  }
  return false
}
```
![Alt text](../_docs/assets/Week3-Confirmation%20Page.png)

## Recovery Page
```js
import { Auth } from 'aws-amplify';

const onsubmit_send_code = async (event) => {
  event.preventDefault();
  setErrors('')
  Auth.forgotPassword(username)
  .then((data) => setFormState('confirm_code') )
  .catch((err) => setErrors(err.message) );
  return false
}

const onsubmit_confirm_code = async (event) => {
  event.preventDefault();
  setErrors('')
  if (password == passwordAgain){
    Auth.forgotPasswordSubmit(username, code, password)
    .then((data) => setFormState('success'))
    .catch((err) => setErrors(err.message) );
  } else {
    setErrors('Passwords do not match')
  }
  return false
}
![Alt text](../_docs/assets/Week3-Recovery%20Page.png)

## Authenticating Server Side

Add in the `HomeFeedPage.js` a header eto pass along the access token

```js
  headers: {
    Authorization: `Bearer ${localStorage.getItem("access_token")}`
  }
```
In the app.py
```py
cors = CORS(
  app, 
  resources={r"/api/*": {"origins": origins}},
  headers=['Content-Type', 'Authorization'], 
  expose_headers='Authorization',
  methods="OPTIONS,GET,HEAD,POST"
)
```






# Homework Challenges

- [Medium] Decouple the JWT verify from the application code by writing a  Flask Middleware
- [Hard] Decouple the JWT verify by implementing a Container Sidecar pattern using AWS’s official Aws-jwt-verify.js library
- [Hard] Decouple the JWT verify process by using Envoy as a sidecar https://www.envoyproxy.io/
- [Hard]  Implement a IdP login eg. Login with Amazon or Facebook or Apple.
- [Easy] Implement MFA that send an SMS (text message), warning this has spend, investigate spend before considering, text messages are not eligible for AWS Credits
