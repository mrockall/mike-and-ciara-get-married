# encoding: utf-8
# 
# Used to import the content from a Google Sheet.
# 
module Import
  class QuestionsFromGoogle

    def initialize
      @session = setup_session
    end

    def execute
      @session
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
