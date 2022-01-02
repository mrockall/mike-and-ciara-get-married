# encoding: utf-8
# 
# Used to import the content from a Google Sheet.
# 
module Import
  class FromSheets
    def initialize(sheet_id)
      @session = setup_session
      @sheet_id = sheet_id
    end

    def execute
      @session
      puts @sheet_id
    end

    private

    def setup_session
      credentials_path = File.join(Rails.root, "tmp", "google_creds.json")
      File.write(credentials_path, JSON.pretty_generate(Rails.application.credentials.google.credentials))
      session = GoogleDrive::Session.from_config(credentials_path)
      File.delete(credentials_path)
      session
    end
  end
end
