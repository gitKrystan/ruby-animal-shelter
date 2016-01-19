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

  describe('.all') do
    it('returns empty array at first') do
      expect(Customer.all).to eq([])
    end
  end

  describe('#save') do
    it('saves customer to database') do
      test_customer = create_test_customer
      test_customer.save()
      expect(Customer.all).to eq([test_customer])
    end
  end

  describe('.sort_by') do
    it('sorts the customer by a specified column') do
      test_customer2 = create_second_test_customer()
      test_customer2.save()
      test_customer = create_test_customer()
      test_customer.save()
      expect(Customer.sort_by('last_name')).to(eq([test_customer2, test_customer]))
    end
  end

  describe('.filter_by') do
    it('filters the animals by a specified column') do
      test_customer2 = create_second_test_customer()
      test_customer2.save()
      test_customer = create_test_customer()
      test_customer.save()
      expect(Customer.filter_by('breed_preference', 'Maine Coon')).to(eq([test_customer]))
    end
  end
end
