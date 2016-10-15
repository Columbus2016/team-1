class CancersController < ApplicationController
  before_action :load_cancer, except: [:index, :new]

  def show
  end

  def new
    @cancer = Cancer.new
  end

  def create
    @cancer = Cancer.new(cancer_params)
    authorize @cancer
    respond_to do |format|
      if cancer.save
        format.html { redirect_to @cancer }
      else
        format.html { render 'new', errors: @cancer.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if cancer.update(cancer_params)
        format.html { redirect_to @cancer }
      else
        format.hml { render 'edit', errors: @cancer.errors }
      end
    end
  end

  protected
  def cancer_params
    params.require(:cancer).permit(:name)
  end

  def load_cancer
    @cancer = Cancer.find(params[:id])
    authorize @cancer
  end
end
