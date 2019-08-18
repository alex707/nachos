require 'zip'

class ExportsController < ApplicationController
  def download
    # TODO: move to separated sevices

    file_name = nil

    if params[:contributer]
      contributer = params[:contributer]
      html = render_to_string(
        partial: 'exports/diploma.pdf.erb',
        locals: { contributer: contributer }
      )
      pdf = WickedPdf.new.pdf_from_string(html)

      save_path = Rails.root.join('tmp', contributer + '.pdf')
      File.open(save_path, 'wb') do |file|
        file << pdf
      end

      file_name = contributer + '.pdf'
    elsif params[:contributers]
      params[:contributers].each do |contributer|
        html = render_to_string(
          partial: 'exports/diploma.pdf.erb',
          locals: { contributer: contributer }
        )
        pdf = WickedPdf.new.pdf_from_string(html)

        save_path = Rails.root.join('tmp', contributer + '.pdf')
        File.open(save_path, 'wb') do |file|
          file << pdf
        end
      end


      folder = "#{Rails.root}/tmp"
      zipfile_name = Rails.root.join('tmp', 'diplomas.zip')

      Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        params[:contributers].each do |filename|
          zipfile.add(filename + '.pdf', folder + '/' + filename + '.pdf')
        end
      end

      params[:contributers].each do |filename|
        if File.exist?(folder + '/' + filename + '.pdf')
          File.delete(folder + '/' + filename + '.pdf')
        end
      end

      file_name = 'diplomas.zip'
    end


    File.open("#{Rails.root}/tmp/#{file_name}", 'rb') do |f|
      send_data(
        f.read,
        filename: file_name,
        disposition: 'attachment'
      )
    end
    File.delete("#{Rails.root}/tmp/#{file_name}")
  end

  private

  def download_params
    params.require(:exports).permit(:contributer, contributers: [])
  end
end
