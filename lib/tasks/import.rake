namespace :import do
  desc "Imports questions from a Google Sheet."
  task :from_sheets, [:sheet_id] => :environment do |t, args|
    Import::FromSheets.new(args[:sheet_id]).execute
  end

  desc "Imports game content from a yaml file."
  task :from_yaml => :environment do |t, args|
    Import::FromYaml.new.execute
  end
end
