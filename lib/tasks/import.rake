namespace :import do
  desc "Imports questions from a Google Sheet."
  task :from_sheets, [:sheet_id] => :environment do |t, args|
    Import::FromSheets.new(args[:sheet_id]).execute
  end
end
