class PortfoliosController < ApplicationController
    layout "portfolio"
    access all: [:show, :index, :react], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all

    def index
        @portfolio_items = Portfolio.all
    end

    def react
      @react_portfolio_items = Portfolio.react
    end

    def new 
        @portfolio_item = Portfolio.new
        3.times { @portfolio_item.technologies.build }
    end

    def create
        @portfolio_item = Portfolio.new(portfolio_params)
        
        respond_to do |format|
          if @portfolio_item.save
            format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.' }
          else
            format.html { render :new }
          end
        end
    end
    
    def update
      @portfolio_item = Portfolio.find(params[:id])

      respond_to do |format|
        if @portfolio_item.update(portfolio_params)
          format.html { redirect_to portfolios_path, notice: 'Portfolio was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    def edit
      @portfolio_item = Portfolio.find(params[:id])
    end

    def show
      @portfolio_item = Portfolio.find(params[:id])
    end

    def destroy
      # Perform the lookup
      @portfolio_item = Portfolio.find(params[:id])

      # Destroy/Delete the item
      @portfolio_item.destroy

      # Redirect
      respond_to do |format|
        format.html { redirect_to portfolios_url, notice: 'Record was removed.' }
      end
    end

    private

    def portfolio_params
      params.require(:portfolio).permit(:title,
                                        :subtitle, 
                                        :body,
                                        technologies_attributes: [:name]
                                      )
    end
end
