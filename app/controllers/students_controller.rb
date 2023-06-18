class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    
    def index
        render json: Student.all
    end

    def show
        student = Student.find(params[:id])
        render json: student
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :accepted
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :age, :instructor_id, :major)
    end

    def render_record_not_found error
        render json: {errors: error}, status: :not_found
    end

    def render_unprocessable_entity error
        render json: {errors: error}, status: :unprocessable_entity
    end
end
