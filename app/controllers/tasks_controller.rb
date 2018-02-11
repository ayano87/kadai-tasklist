class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        @tasks = current_user.tasks
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "Taskを登録しました"
            redirect_to root_url
        else
            flash.now[:danger] = "Taskが登録できませんでした"
            render "toppages/index"
        end
    end
    
    def edit
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = "Taskが更新されました"
            redirect_to @task
        else
            flash.now[:danger] = "Taskが更新できませんでした"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "Taskが削除されました"
        redirect_to tasks_url
    end
    
    private
    
    def set_task
        @task = Task.find(params[:id])
        redirect_to root_url if @task.user != current_user
    end
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
end
