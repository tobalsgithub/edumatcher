class WelcomeController < ApplicationController
  def proxy_test
    @testdata = [
      {
        'thing 1' => 'thing ONE'
      },
      {
        'thing 2' => 'thing TWO'
      }
    ]
    render json: @testdata
  end
end
