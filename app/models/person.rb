class Person < ApplicationRecord

  has_secure_password

  mount_uploader :avatar, AvatarUploader
  mount_uploader :qr_code, QrcodeUploader
  mount_uploader :identification_photo, PhotoUploader

  scope :got_identification, -> { where.not(identification: '') }
  scope :active_person, -> { where(active: true) }

  belongs_to :gender

  belongs_to :role, optional: true

  belongs_to :sponsor, class_name: "Person", optional: true
  has_many :sponsee, class_name: "Person", foreign_key: "sponsor_id"

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :favorites

  has_many :wallets

  has_many :subscriptions

  has_many :businesses

  has_many :orders

  has_many :collections

  has_many :conversations

  validates :email, presence: true,
                    length: {minimum: 3},
                    uniqueness: true,
                    format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 8..16},
                       :on => :create

  validates :password, :confirmation => true,
                       :length => {:within => 8..16},
                       :allow_blank => true

  before_create {
    generate_uuid
    generate_token(:sponsor_token)
  }

  after_create {
    initialize_wallets
    generate_qr_code!
  }

  #validate :validate_avatar_dimension
  #validate :validate_avatar_size

  def validate_avatar_dimension
    if avatar.path.present?
      image = MiniMagick::Image.open(avatar.path)
      unless image[:width] == 640 && image[:height] == 640
        errors.add :avatar, "should be 640x640px fixed!"
      end
    end
  end

  def validate_avatar_size
    errors[:avatar] << "should be less than 1MB" if avatar.size > 1.megabytes
  end

  def cash_wallet
    self.wallets.first
  end

  def reward_point
    self.wallets.last
  end

  def address
    street_1", \n" + street_2 + ", \n" + postcode + city + ", \n" + state + ", " + country
  end

  def to_param
    "#{id}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def get_membership
    orders = self.orders.where('paid_at BETWEEN ? AND ?', DateTime.now.in_time_zone.beginning_of_month, DateTime.now.in_time_zone.end_of_month)
    if orders.present?
      if orders.count > 1
        "Premium"
      else
        "Standard"
      end
    else
      "Free"
    end
  end

  private
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Person.exists?(column => self[column])
    end

    def generate_qr_code!
      tmp_path = Rails.root.join('tmp', "pers_#{self.uuid}.png")
      tmp_file = RQRCode::QRCode.new("sponsor_token:#{self.sponsor_token}").to_img.resize(512, 512).save(tmp_path)

      # Stream is handed closed, we need to reopen it
      File.open(tmp_file.path) do |file|
        self.qr_code = file
      end

      File.delete(tmp_file.path)

      self.save!
    end

  protected
    def initialize_wallets
      self.wallets.create( format: "cash" )
      self.wallets.create( format: "point")
    end

end
