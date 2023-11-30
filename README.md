# Ruby on Rails Payment Integration with Rapyd API

## Accept Payments

Explore a wide range of payment methods and learn how to seamlessly integrate Rapyd's payment features into your Ruby on Rails application. Provide your customers with their preferred local payment options through a single integration.

### Prerequisites

Before running the application, make sure you have the following installed:

- Ruby on Rails
- Ngrok

## Getting Started

To get started with this application, you'll need a Rapyd Account and your API Keys. If you don't have one yet, you can sign up at [Rapyd Client Portal](https://dashboard.rapyd.net/sign-up).

### Exposing Port for Rapyd Integration

When integrating Rapyd into your application, it's important to note that Rapyd doesn't accept requests from localhost. To properly test and interact with Rapyd APIs, you'll need to expose the corresponding port of your computer to the outside world. By default, the application uses port 3000. To achieve this, you can use tools like [ngrok](https://ngrok.com), which generates a temporary web address and redirects traffic to a specified port on your local machine. This allows you to securely test and experience Rapyd's features within your development environment.

## Running the Application

1. Clone this repository to your local machine.
2. Navigate to the project directory.

### Configure ngrok

1. Install ngrok by following the instructions on [ngrok's website](https://ngrok.com).
2. Once installed, expose port 3000 using the following command:
   ```shell
   ngrok http 3000
   ```
3. Copy the ngrok URL generated, e.g., http://abcdef123456.ngrok.io.

### Configure Application

1. In your Rails application, open `config/application.rb`.
2. Look for the line that starts with config.hosts.
3. Add the ngrok URL to the array, separated by a comma. It should look like this:

```ruby
config.hosts << 'abcdef123456.ngrok.app'
```
### Launch the Rails Server

1. Run the following commands to install dependencies and set up the database:

```shell
bundle install
rails db:create db:migrate
```

2. Start the Rails server:

```shell
rails server
```

3. Access the application by visiting http://localhost:3000 or your ngrok-generated URL.

### Rapyd API Keys

1. Log in to your Rapyd account.
2. Make sure you are in "sandbox" mode (switch located at the bottom left of the panel).
3. Go to the "Developers" tab and find your API keys. Copy them for use in the sample application.

### Get Support

For additional support and community engagement, visit the [Rapyd Community](https://community.rapyd.net/).

Happy coding!

Feel free to adjust the instructions to match your application's structure and any specific requirements.
