class Bank < ApplicationRecord
  belongs_to :business
  has_many :statements

  after_create {
    initialize_statement
  }

  def success
    statements.collect { |statement| statement.status == "success" ? (statement.debit.to_f - statement.credit.to_f) : 0 }.sum
  end

  def pending
    statements.collect { |statement| statement.status == "pending" ? (statement.debit.to_f - statement.credit.to_f) : 0 }.sum
  end

  def request
    statements.collect { |statement| statement.status == "request" ? (statement.debit.to_f - statement.credit.to_f) : 0 }.sum
  end

  def total
    self.success + self.pending
  end

  protected
    def initialize_statement
      self.statements.create!(
        description: "Initialize opening balance.",
        ref_no: "INIT-#{Statement.all.count + 1}",
        debit: 0.00,
        status: "success"
      )
    end
end
