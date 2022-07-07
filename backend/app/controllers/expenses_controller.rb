class ExpensesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid do |error|
    expense = error.record
    render_error(expense.errors.full_messages, 400)
  end

  def index
    render json: Expense.order(date: :desc)
  end

  def show
    expense = Expense.find(params[:id])
    render json: expense
  end

  def create
    expense = Expense.new(expense_params)
    if expense.save
      render json: expense
    else
      render_error(expense.errors.full_messages, 422)
    end
  end

  def update
    expense = Expense.find(params[:id])
    if expense.update(expense_params)
      render json: expense
    else
      render_error(expense.errors.full_messages, 422)
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
  end

  private

  def expense_params
    params.permit(:amount, :date, :description, :account_id)
  end
end
