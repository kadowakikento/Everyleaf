class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.order(created_at: :DESC).page(params[:page]).per(6)
    @tasks = Task.all.order(deadline: :DESC).page(params[:page]).per(6) if params[:sort_deadline]
    @tasks = Task.all.order(priority: :DESC).page(params[:page]).per(6) if params[:sort_priority]

    # title = params[:task][:title]
    # status = params[:task][:status]
    
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = Task.status_title(params).page(params[:page]).per(6)
      elsif params[:task][:title].present?
        @tasks = Task.title(title).page(params[:page]).per(6)
      elsif params[:task][:status].present?
        @tasks = Task.status(status).page(params[:page]).per(6)
      end
      # @tasks = Task.where(“title LIKE ?“, “%#{params[:task][:title]}%“) if params[:task][:title].present?
      # @tasks = @tasks.where(status: params[:task][:status]) if params[:task][:status].present?
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :deadline, :priority, :content, :status)
    end
end
