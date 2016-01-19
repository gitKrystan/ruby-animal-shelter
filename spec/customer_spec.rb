require "spec_helper"

describe(Customer) do
  describe('#initialize') do
    it('returns an object') do
      test_customer = create_test_customer
      expect(test_customer.first_name).to eq('Alex')
      expect(test_customer.last_name).to eq('Smith')
      expect(test_customer.phone).to eq('555-555-5555')
      expect(test_customer.animal_type_preference).to eq('cat')
      expect(test_customer.breed_preference).to eq('Maine Coon')
    end
  end
end
