class Business < ApplicationRecord

  mount_uploader :logo, LogoUploader
  mount_uploader :banner, BannerUploader
  mount_uploader :qr_code, QrcodeUploader

  mount_uploader :certificate_photo, PhotoUploader
  mount_uploader :gst_certification_photo, PhotoUploader

  scope :got_certificate, -> { where.not(certificate_id: '') }

  belongs_to :person

  belongs_to :referrer, class_name: "Person"

  belongs_to :type, optional: true
  belongs_to :list, optional: true

  has_many :products

  has_many :orders

  has_one :bank, :dependent => :destroy

  has_many :conversations

  validates :name, presence: true,
                    length: {minimum: 3},
                    uniqueness: true

  validates :email, presence: true,
                    length: {minimum: 3},
                    uniqueness: true,
                    format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}


  validates :mobile, :presence => true,
                       :confirmation => true,
                       :length => {:within => 8..16},
                       :on => :update

  #validate :validate_logo_size
  #validate :validate_banner_size

  before_create {
    generate_uuid
    build_default_bank
  }

  after_create {
    generate_qr_code!
  }

  def validate_logo_dimension
    if logo.path.present?
      image = MiniMagick::Image.open(logo.path)
      unless image[:width] == 640 && image[:height] == 640
        errors.add :logo, "should be 640x640px fixed!"
      end
    end
  end

  def validate_banner_dimension
    if banner.path.present?
      image = MiniMagick::Image.open(banner.path)
      unless image[:width] = 640 && image[:height] = 640
        errors.add :banner, "should be 1180x380px fixed!"
      end
    end
  end

  def validate_logo_size
    errors[:logo] << "should be less than 5MB" if logo.size > 5.megabytes
  end

  def validate_banner_size
    errors[:banner] << "should be less than 5MB" if banner.size > 5.megabytes
  end

  def address
    street_1", \n" + street_2 + ", \n" + postcode + city + ", \n" + state + ", " + country
  end

  private
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end

    def generate_qr_code!
      tmp_path = Rails.root.join('tmp', "busi_#{self.uuid}.png")
      tmp_file = RQRCode::QRCode.new("business_uuid:#{self.uuid}").to_img.resize(512, 512).save(tmp_path)

      # Stream is handed closed, we need to reopen it
      File.open(tmp_file.path) do |file|
        self.qr_code = file
      end

      File.delete(tmp_file.path)

      self.save!
    end

    def build_default_bank
      build_bank
      true
    end

end
