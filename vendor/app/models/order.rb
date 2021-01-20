class Order < ApplicationRecord

  mount_uploader :qr_code, QrcodeUploader

  belongs_to :person
  belongs_to :business
  belongs_to :status

  has_many :items, dependent: :destroy

  before_create {
    generate_uuid
  }

  after_create {
    generate_qr_code!
  }

  scope :all_except, ->(status) { where.not(status_id: status) }

  def get_subtotal
    items.collect { |item| item.valid? ? (item.quantity * item.unit_price) : 0 }.sum
  end

  def get_shipment
    items.collect { |item| item.valid? ? (item.quantity * item.unit_ship) : 0 }.sum
  end

  def get_total
    get_subtotal + get_shipment
  end

  private
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end

    def generate_qr_code!
      tmp_path = Rails.root.join('tmp', "orde_#{self.uuid}.png")
      tmp_file = RQRCode::QRCode.new("order_uuid:#{self.uuid}").to_img.resize(512, 512).save(tmp_path)

      # Stream is handed closed, we need to reopen it
      File.open(tmp_file.path) do |file|
        self.qr_code = file
      end

      File.delete(tmp_file.path)

      self.save!
    end
end
