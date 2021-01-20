class Product < ApplicationRecord

  mount_uploader :qr_code, QrcodeUploader

  belongs_to :business

  belongs_to :categories, optional: true

  before_create {
    generate_uuid
  }

  after_create {
    generate_qr_code!
  }

  scope :order_by, lambda { |o| { :order => o } }
  scope :active_products, -> { where(active: true) }

  mount_uploader :image_01, ImageUploader
  mount_uploader :image_02, ImageUploader
  mount_uploader :image_03, ImageUploader
  mount_uploader :image_04, ImageUploader
  mount_uploader :image_05, ImageUploader



  private
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end

    def generate_qr_code!
      tmp_path = Rails.root.join('tmp', "prod_#{self.uuid}.png")
      tmp_file = RQRCode::QRCode.new("product_uuid:#{self.uuid}").to_img.resize(512, 512).save(tmp_path)

      # Stream is handed closed, we need to reopen it
      File.open(tmp_file.path) do |file|
        self.qr_code = file
      end

      File.delete(tmp_file.path)

      self.save!
    end
end
