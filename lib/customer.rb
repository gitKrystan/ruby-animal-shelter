class Customer
  attr_reader(:id, :first_name, :last_name, :phone, :animal_type_preference, :breed_preference)

  def initialize(arguments)
    @id = arguments[:id]
    @first_name = arguments[:first_name]
    @last_name = arguments[:last_name]
    @phone = arguments[:phone]
    @animal_type_preference = arguments[:animal_type_preference]
    @breed_preference = arguments[:breed_preference]
  end
end
