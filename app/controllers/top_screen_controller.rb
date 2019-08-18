class TopScreenController < ApplicationController
  def search
    if params[:link]
      @contributers = RepoCheckerService.new(params[:link]).call
    end
  end

  private

  def search_params
    params.require(:top_screen).permit(:link)
  end
end
