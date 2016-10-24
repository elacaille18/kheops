class Parcel < ActiveRecord::Base
  #Associations
  belongs_to :owner, class_name: "User"
  belongs_to :origin, class_name: "User"
  belongs_to :destination, class_name: "User"

  has_many :events
  #has_many :users, through: :events
  CODE_WORDS = ["ABRI", "ACTE", "AIDE", "AIME", "ALLO", "AMER", "AOUT", \
  "AUBE", "AUTO", "AZUR", "BABY", "BEAU", "BIDE", "BLEU", "BLOC", "BOBO", "BOSS", \
  "BOUC", "BOUE", "BOUM", "BOXE", "BRAS", "BREF", "BENI", "CAFE", "CAGE", "CAKE", "CAMP", \
  "CANE", "CASA", "CERF", "CHAT", "CHEF", "CHER", "CHOC", "CHOU", "CHUT", "CIAO", \
  "CIME", "CINQ", "CINE", "CLEF", "CLIC", "CLOU", "CLUB", "COCA", "COCO", "CODE",  "COOL", \
  "CUBE", "CUVE", "DADA", "DATE", "DEMI", "DENT", "DEUX", "DODO", "DONC", "DOUX", "DRAP", "DUEL", \
  "DUNE", "DEFI", "DEJA", "DINE", "DOME", "ELLE", "EXIL", "EDEN", "EGAL", "ELAN", "EMIR", "EPEE", "ETAT", "ETUI", "ETRE"]

  before_validation(on: :create) do
    self.word = CODE_WORDS.sample
    self.code = rand(1000..9999).to_s
  end
  # #Validations
  # validates :"user", presence: true
  # validates :description, presence: true

  def receiver_full_name
    "#{self.receiver_first_name.capitalize} #{self.receiver_last_name.capitalize}"
  end

  def encode_qr
    "#{self.id};#{self.word};"
  end
end
