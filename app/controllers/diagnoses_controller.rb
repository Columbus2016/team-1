class DiagnosesController < ApplicationController
  before_action :load_diagnosis, except: [:index, :create]

  def index
    @diagnoses = policy_scope(Diagnosis)
  end

  def show
  end

  def new
    @diagnosis = Diagnosis.new
  end

  def create
    @diagnosis = Diagnosis.new(diagnosis_params)
    authorize @diagnosis
    if @diagnosis.save
      redirect_to @diagnosis
    else
      render 'new', errors: @diagnosis.errors
    end
  end

  def edit
  end

  def update
    if @diagnosis.update(diagnosis_params)
      redirect_to current_user
    else
      render 'edit', errors: @diagnosis.errors
    end
  end


  protected
  def load_diagnosis
    @diagnosis = Diagnosis.find(params[:id])
    authorize @diagnosis
  end

  def diagnosis_params
    params.require(:diagnosis)
      .permit(:cancer_id, :diagnosed_at)
      .merge(user_id: current_user.id)
  end
end
