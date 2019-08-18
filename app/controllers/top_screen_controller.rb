class TopScreenController < ApplicationController
  def search
    if params[:link]
      repo_checker = RepoCheckerService.new(params[:link]).call
      @contributers = []

      if repo_checker.response_code == '200'
        @contributers = repo_checker.contributers
      else
        flash[:alert] = 'Check the correctness of the entered link'
      end
    end
  end

  private

  def search_params
    params.require(:top_screen).permit(:link)
  end
end
