# == Schema Information
#
# Table name: coldocuments
#
#  doc_num    :integer
#  divipol_id :integer
#

require 'csv'
class Coldocument < ApplicationRecord

  def self.load_csv()
    index = 0
    CSV.foreach('censo.csv') do |row|
      #  num_document, divpol_id  # <=== CSV format
      # puts $. if ($. % 10_000) == 0
      puts index if ((index % 10_000) == 0)

      self.create(doc_num: row.first.to_i, divipol_id:row.last.to_i)
      index +=1
    end
  end
end
