class User < ActiveRecord::Base
	has_many :advertisement, dependent: :destroy

	before_save {self.email = email.downcase}

	validates :username, presence: { message: 'Име е задолжително поле' }, 
												length: { minimum: 3, maximum: 40, message: 'Името може да содржи минимум 3, максимум 40 карактери' }

	VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: { message: 'Емаил е задолжително поле' },
										length: { maximum: 100, message: 'Емаил адресата е премногу долга (максимум 100 карактери)' },
										uniqueness: { case_sensitive: false, message: 'Емаил адресата веќе постои' },
										format: { with: VALID_EMAIL_REGEX, message: 'Емаил адресата е невалидна' }

	validates :phone, allow_nil: true, numericality: { message: 'Телефон полето може да содржи само бројки' }

	validates :password, presence: { message: 'Лозинка мора да внесете' }

	validates :password_confirmation ,presence: { message: 'Мора да ја потврдите лозинка' } , :if => '!password.nil?'  

	has_secure_password
end