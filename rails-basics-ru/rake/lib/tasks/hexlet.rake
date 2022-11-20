# frozen_string_literal: true

require 'csv'

namespace :hexlet do
  desc "Import users from csv file"
  task :import_users, [:path] => :environment do |_t, args|
    abort 'Path is empty' unless args.path
    abort "File '#{args.path}' not exist" unless File.file?(args.path)

    file = File.read(args.path)
    data = CSV.parse(file, headers: true)
    puts "Records in file: #{data.count}"

    data.each do |row|
      User.create!(
        first_name: row['first_name'],
        last_name: row['last_name'],
        birthday: Date.strptime(row['birthday'], '%m/%d/%Y'),
        email: row['email']
      )
    end
    puts 'Users were imported'
  end
end
