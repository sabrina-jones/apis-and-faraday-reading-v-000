class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    req.params['client_id'] = "YNBPE5EFHQ4XETZ0VB0BGKP53RCOULQBC2ZMUS4SEHMY1QTA"
    req.params['client_secret'] = "CEFBMAQOK0QYDPTUC0WBFHXQ3LJDQMWP05XJMBBSRTXUTR0D"
    req.params['v'] = '20160201'
    req.params['near'] = params[:zipcode]
    req.params['query'] = 'coffee shop'
    req.options.timeout = 0
  end
  body = JSON.parse(@resp.body)
  if @resp.success?
    @venues = body["response"]["venues"]
  else
    @error = body["meta"]["errorDetail"]
  end

rescue Faraday::ConnectionFailed
  @error = "There was a timeout. Please try again."
end
render 'search'

end


end
