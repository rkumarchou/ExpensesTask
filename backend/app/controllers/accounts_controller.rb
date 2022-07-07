class AccountsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid do |error|
    account = error.record
    render_error(account.errors.full_messages, 400)
  end

  def index
    render json: Account.order(created_at: :desc)
  end

  def show
    account = Account.find(params[:id])
    render json: account
  end

  def create
    account = Account.new(account_params)
    if account.save
      render json: account
    else
      render_error(account.errors.full_messages, 422)
    end
  end

  def update
    account = Account.find(params[:id])
    if account.update(account_params)
      render json: account
    else
      render_error(account.errors.full_messages, 422)
    end
  end

  def destroy
    account = Account.find(params[:id])
    account.destroy
  end

  private

  def account_params
    params.permit(:name, :number)
  end
end
