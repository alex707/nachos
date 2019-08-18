require 'net/http'

class RepoCheckerService
  MAX_OF_TOP = 3

  attr_reader :api_link, :response_code, :contributers

  def initialize(source_link)
    @api_link = make_api_link(source_link) if source_link
    @response_code = nil
  end

  def call
    @contributers = check_contributers
    self
  end

  private

  def make_api_link(source_link)
    source_link.delete_suffix!('/')
    owner, repo = source_link.split('/').last(2)
    @api_link = "https://api.github.com/repos/#{owner}/#{repo}" \
      "/contributors?q=contributions&order=desc"
  end

  def request_data
    uri = URI(@api_link)
    request = Net::HTTP::Get.new(uri)

    response = Net::HTTP.start(
      uri.hostname, uri.port, :use_ssl => true,
      veryfi_mode: OpenSSL::SSL::VERIFY_NONE, ca_file: "cacert.pem"
      ) do |http|
      http.request(request)
    end
    @response_code = response.code

    response.body
  end

  def check_contributers
    return [] unless @api_link

    content = request_data
    if @response_code == '200'
      JSON.parse(content).first(MAX_OF_TOP).map { |elem| elem['login'] }
    else
      []
    end
  end
end
