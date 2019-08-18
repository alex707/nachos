class ExportsController < ApplicationController
  def download
    html = render_to_string(
      partial: 'exports/diploma.pdf.erb',
      locals: { contributer: params[:contributer] }
    )
    pdf = WickedPdf.new.pdf_from_string(html)

    send_data(pdf,
      filename: "#{params[:contributer]}.pdf",
      disposition: 'attachment'
    )
  end

  private

  def download_params
    params.require(:exports).permit(:contributer)
  end
end
