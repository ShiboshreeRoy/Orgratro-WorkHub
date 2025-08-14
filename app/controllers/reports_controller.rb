class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  # GET /reports
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.includes(:clicks).order(:id).page(params[:page]).per(10)

    respond_to do |format|
      format.html # renders app/views/reports/index.html.erb
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "User Reports", size: 18, style: :bold, align: :center
        pdf.move_down 20

        # Table header
        table_data = [["ID", "Name", "Email", "Clicks"]]

        # Table body
        @users.each do |user|
          table_data << [user.id, user.name.presence || "N/A", user.email, user.clicks.count]
        end

        # Render table
        pdf.table(table_data, header: true, row_colors: ["F0F0F0", "FFFFFF"], width: pdf.bounds.width)

        send_data pdf.render,
                  filename: "user_reports.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  # GET /reports/user_clicks
  def user_clicks
    @q = User.ransack(params[:q])
    @users = @q.result.includes(:clicks).order(:id)

    # Chart data for Chartkick (HTML view only)
    @chart_data = @users.map { |u| [u.name.presence || "N/A", u.clicks.count] }

    respond_to do |format|
      format.html # renders app/views/reports/user_clicks.html.erb
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "User Clicks Report", size: 18, style: :bold, align: :center
        pdf.move_down 20

        # Table header
        table_data = [["ID", "Name", "Email", "Clicks"]]

        # Table body
        @users.each do |user|
          table_data << [user.id, user.name.presence || "N/A", user.email, user.clicks.count]
        end

        # Render table
        pdf.table(table_data, header: true, row_colors: ["F0F0F0", "FFFFFF"], width: pdf.bounds.width)

        send_data pdf.render,
                  filename: "user_clicks_report.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  private

  def ensure_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user.admin?
  end
end
