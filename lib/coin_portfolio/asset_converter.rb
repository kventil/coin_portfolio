module CoinPortfolio
  class AssetConverter
    def initialize(transactions)
      @transactions = transactions
    end

    def convert
      outgoing_amount = total_outgoing_amount
      incoming_transactions.each_with_object([]) do |transaction, assets|
        remaining_amount = transaction.amount - outgoing_amount
        if remaining_amount > 0
          asset = Asset.new(amount: remaining_amount, price: transaction.price)
          assets.push(asset)
        end

        outgoing_amount = [0, outgoing_amount - transaction.amount].max
      end
    end

    private

    attr_reader :transactions

    def incoming_transactions
      transactions.select(&:incoming?)
    end

    def total_outgoing_amount
      transactions.reject(&:incoming?).reduce(0) do |sum, transaction|
        sum + transaction.amount
      end
    end
  end
end