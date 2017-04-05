# == Schema Information
#
# Table name: usuarios
#
#  id                   :integer          not null, primary key
#  primer_apellido      :string
#  segundo_apellido     :string
#  nombres              :string
#  tipo_de_documento_id :integer
#  numero_documento     :string
#  fecha_expedicion     :date
#  role_type            :integer
#  uid                  :string
#  valido               :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  document_photo_id    :integer
#  email                :string
#  password_hash        :string
#  password_salt        :string
#

FactoryGirl.define do
  factory :usuario do

    primer_apellido { Faker::Name.last_name }
    segundo_apellido { Faker::Name.last_name }
    nombres { Faker::Name.first_name }
    tipo_de_documento { FactoryGirl.create(:tipo_de_documento) }
    fecha_expedicion { Date.today - 1000.days }
    valido false
    email { Faker::Internet.email }
    password "password123@"
    password_confirmation "password123@"
    role_type { rand(0..2) }
    to_create {|instance| instance.save(validate: false) }

  end
end