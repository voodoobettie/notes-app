class DocsController < ApplicationController
  before_action :find_doc, only: [:show, :edit, :update, :destroy]
  def index
    @docs = Doc.where(user_id: current_user).order("created_at DESC")
    # @docs = Doc.all.order("created_at DESC")
  end

  def show
  end

  def new
    # @doc = Doc.new
    @doc = current_user.docs.build
  end

  def create
    # @doc = Doc.new(doc_params)
    @doc = current_user.docs.build(doc_params)
    if @doc.save
      redirect_to @doc
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @doc.update(doc_params)
      redirect_to @doc
    else
      render 'edit'
    end
  end

  def destroy
    @doc.destroy
    # respond_to do |format|
      #format.html {redirect_to 'index'}
      # redirect_to 'index'
    # end
  end

  private

    def find_doc
      @doc = Doc.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:title, :content)
    end
end
