# CoinPortfolio

CoinPortfolio calculates the gains/losses of the current cryptocurrency portfolio.

Typically when checking the evolution of the price of bitcoin you can see how much the price increased/decreased over
a period of time (e.g. day, week, year).

What if you wanted to answer the question: Would it be profitable to sell all my bitcoins now? This small library
attempts to answer that question by calculating the portfolio cost, portfolio value and the
percentage of gains/losses, if the portfolio were to be fully liquidated now.

The library tries to account for scenarios in which an account has multiple incoming and outgoing transactions with
distinct prices using the [FIFO accounting method](https://en.wikipedia.org/wiki/FIFO_and_LIFO_accounting).

This is still a work in progress.

## Usage

The library uses the Coinbase API to:
- access the primary account for a given API key and secret

- iterate through all the account's transactions in order to get a snapshot of the distribution of the portfolio

- get the current price of the account's cryptocurrency

The API keys need to have the following permissions: `wallet:accounts:read`, `wallet:transactions:read`.

```ruby
$ bundle exec rake console
$ api_key = "key"
$ api_secret = "secret"
$ calculator = CoinPortfolio::Calculator.new(api_key: api_key, api_secret: api_secret)
$ calculator.potential_returns
gains percentage: 25.00%
portfolio cost: €100,00
current portfolio value: €125,00
```

## Improvements
Until now the priority has been getting a working version therefore, there are still plenty of improvements to be made:
- API client - the code that interacts with coinbase's gem is isolated in a single class which translates
response hashes into domain objects. Yet the code is tied to coinbase's gem and would require some changes if there was
a need to integrate with another exchange. Additionally a proper handling of API related errors hasn't been
implemented.

- Multiple currencies - the code currently assumes that the user's account has a single cryptocurrency and that its
transactions are all in the same native currency. This might not be true in all cases.

## License
MIT (c) Mário Nzualo
