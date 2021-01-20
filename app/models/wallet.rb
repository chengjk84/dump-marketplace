class Wallet < ApplicationRecord
  belongs_to :person
  has_many :transactions

  after_create {
    initialize_transaction
  }

  def success
    transactions.collect { |transaction| transaction.status == "success" ? (transaction.debit.to_f - transaction.credit.to_f) : 0 }.sum
  end

  def pending_debit
    transactions.collect { |transaction| transaction.status == "pending" ? (transaction.debit.to_f) : 0 }.sum
  end

  def pending_credit
    transactions.collect { |transaction| transaction.status == "pending" ? (transaction.credit.to_f) : 0 }.sum
  end

  def request
    transactions.collect { |transaction| transaction.status == "request" ? (transaction.debit.to_f - transaction.credit.to_f) : 0 }.sum
  end

  def total
    self.success + self.pending
  end

  protected
    def initialize_transaction
      self.transactions.create!(
        description: "Initialize opening balance.",
        ref_no: "init_#{Transaction.all.count + 1}",
        debit: 0.00,
        status: "success"
      )
    end

end
