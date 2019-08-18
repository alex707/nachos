class RepoCheckerService
  MAX_OF_TOP = 3

  attr_reader :api_link

  def initialize(source_link)
    @api_link = make_api_link(source_link) if source_link
  end

  def call
    contributers
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

    response&.code == '200' ? JSON.parse(response.body) : nil
  end

  def contributers
    return [] unless @api_link

    content = request_data
    content ? content.first(MAX_OF_TOP).map { |elem| elem['login'] } : []
  end
end
