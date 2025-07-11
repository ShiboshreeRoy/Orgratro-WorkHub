class WithdrawalsController < ApplicationController
  before_action :set_withdrawal, only: %i[ show edit update  ]

  # GET /withdrawals or /withdrawals.json
 def index
  @withdrawals = current_user.admin? ? Withdrawal.all.includes(:user) : current_user.withdrawals
end

def new
  @withdrawal = Withdrawal.new
end

def create
  @withdrawal = current_user.withdrawals.build(withdrawal_params)
  if @withdrawal.amount <= current_user.balance
    @withdrawal.status = "pending"
    current_user.balance -= @withdrawal.amount
    Withdrawal.transaction do
      @withdrawal.save!
      current_user.save!
    end
    redirect_to withdrawals_path, notice: "Withdrawal requested."
  else
    flash.now[:alert] = "Insufficient balance."
    render :new
  end
end




def update
  @withdrawal = Withdrawal.find(params[:id])
  if current_user.admin? && @withdrawal.status == "pending"
    @withdrawal.update(status: "approved")
    redirect_to withdrawals_path, notice: "Withdrawal approved."
  else
    redirect_to withdrawals_path, alert: "Action not allowed."
  end
end

private

def withdrawal_params
  params.require(:withdrawal).permit(:amount)
end

end
