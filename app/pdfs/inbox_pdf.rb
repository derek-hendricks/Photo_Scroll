require 'prawn/table'

class InboxPdf < Prawn::Document
  def initialize(receipts, conversation)
    super()
    @receipts = receipts
    @conversation = conversation
    header
    text_content
    table_content
  end
 
  def header
    image "#{Rails.root}/app/assets/images/E-mail-icon.png", width: 100, height: 100
  end
 
  def text_content
    y_position = cursor - 50
    bounding_box([0, y_position], :width => 270, :height => 50) do
      text "Conversation with #{@conversation.originator.username} #{@conversation.originator.email}", size: 15, style: :bold
    end
    bounding_box([300, y_position], :width => 270, :height => 50) do
      text "Date #{@conversation.created_at.to_formatted_s(:long)}", size: 15, style: :bold
    end
 
  end
 
  def table_content
    table receipt_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [150, 100, 200]
    end
  end

  def receipt_rows
    [['To','Subject', 'Message']] +
      @receipts.map do |receipt|
        author = Author.find(receipt.receiver_id)
        message = receipt.message
        [author.email, message.subject, message.body]
    end
  end
end