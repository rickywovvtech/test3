class DiscussionsController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :set_discussion, only: %i[ show edit update destroy ]

  # GET /discussions or /discussions.json
  def index
    follow = Follow.where(:sessionuser=>current_user.id)
    @discussions = (Discussion.all.where(:user_id=>current_user.id)+Discussion.where(:user_id=>follow.pluck(:user_id))).uniq
  end

  def all_discussion
    if params[:q].present?
      user= User.where('name LIKE ?',"#{params[:q]}%")
      @discussions = Discussion.all.where(:user_id=>user.pluck(:id))
    else
      @discussions = Discussion.all
    end
  end

  def my_post
    @discussions = Discussion.all.where(:user_id=>current_user.id)
  end

  # GET /discussions/1 or /discussions/1.json
  def show
  end

  def submit_comment
    discussion = Discussion.find(params[:id])
    Comment.create(:comment=>params[:uname],:discussion_id=>params[:id], :user_id=>current_user.id)
    respond_to do |format|
      format.html { redirect_to discussion, notice: " successfully commented" }
      format.json { head :no_content }
    end
  end

  def user_post
     @user_id = params[:id]
     @discussions = Discussion.all.where(:user_id=>@user_id)
  end

  def follow_user
     user_id = params[:id]
     Follow.create(:user_id=>user_id,:sessionuser=>current_user.id)
     respond_to do |format|
      format.html { redirect_to discussions_url, notice: "Discussion was successfully followed" }
      format.json { head :no_content }
    end
  end

  # GET /discussions/new
  def new
    @discussion = Discussion.new
  end

  # GET /discussions/1/edit
  def edit
  end

  # POST /discussions or /discussions.json
  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user_id = current_user.id

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: "Discussion was successfully created." }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1 or /discussions/1.json
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to @discussion, notice: "Discussion was successfully updated." }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1 or /discussions/1.json
  def destroy
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to discussions_url, notice: "Discussion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def discussion_params
      params.require(:discussion).permit(:description, :topic)
    end
end
