module ViewFilesHelper
  def download_link_for(file)
    if is_directory(file) || file.web_content_link.nil?
      file.alternate_link
    else
      file.web_content_link 
    end
  end

  def is_directory(file)
    file.mime_type == 'application/vnd.google-apps.folder'
  end
end
