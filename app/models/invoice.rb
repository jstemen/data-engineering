class Invoice < ActiveRecord::Base
  attr_accessible :purchase_count,
   :item_description,
   :merchant_address,
   :merchant_name,
   :item_price,
   :purchaser_name
  def self.import(filePath)
    running_revenue = 0
    n = SmarterCSV.process(filePath, {:col_sep=>"\t" }) do |array|
      nextRecordHash = array.first
    nextRecord = Invoice.create!(nextRecordHash)
      running_revenue +=nextRecord.calc_revenue
    end
    running_revenue
  end
  def calc_revenue
    self.purchase_count * self.item_price
  end
end