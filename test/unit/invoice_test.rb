require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  def test_save_find_and_delete_record

    record = Invoice.new({:purchaser_name=>"Snake Plissken",
      :item_description=>"$10 off $20 of food",
      :item_price=>10.0,
      :purchase_count=>2,
      :merchant_address=>"987 Fake St",
      :merchant_name=>"Bob's Pizza"})

    assert record.save

    record_copy = Invoice.find(record.id)

    assert_equal record.purchase_count, record_copy.purchase_count

    assert record.destroy
  end
  
  def test_that_file_can_be_imported
    filePath = Rails.root + "example_input.tab"
    invoicesBeforeInsert = Invoice.find(:all)
    Invoice.import(filePath);
        
    invoicesAfterInsert = Invoice.find(:all)
    assert_operator invoicesBeforeInsert.count, :<, invoicesAfterInsert.count
  end
  
end
