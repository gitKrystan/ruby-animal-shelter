require "spec_helper"

describe(Animal) do
  describe('#initialize') do
    it('creates a new animal and allows us to access its characteristics') do
      test_animal = create_test_animal(2)
      expect(test_animal.name()).to(eq('Harry Princess'))
      expect(test_animal.sex()).to(eq('M'))
      expect(test_animal.date_of_admittance()).to(eq('2016-01-01'))
      expect(test_animal.type()).to(eq('cat'))
      expect(test_animal.breed()).to(eq('Maine Coon'))
      expect(test_animal.customer_id()).to(eq(2))
    end
  end

  describe('#id') do
    it('sets its ID when you save it') do
      test_animal = create_test_animal(2)
      test_animal.save()
      expect(test_animal.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Animal.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds an animal to the array of saved animals') do
      test_animal = create_test_animal(2)
      test_animal.save()
      expect(Animal.all()).to(eq([test_animal]))
    end
  end

  describe('.sort_by') do
    it('sorts the animals by a specified column') do
      test_dog = create_second_test_animal(1)
      test_dog.save()
      test_cat = create_test_animal(2)
      test_cat.save()
      expect(Animal.sort_by('name')).to(eq([test_cat, test_dog]))
      expect(Animal.sort_by('date_of_admittance')).to(eq([test_dog, test_cat]))
    end
  end

  describe('.filter_by') do
    it('filters the animals by a specified column') do
      test_dog = create_second_test_animal(1)
      test_dog.save()
      test_cat = create_test_animal(2)
      test_cat.save()
      expect(Animal.filter_by('type', 'dog')).to(eq([test_dog]))
      expect(Animal.filter_by('breed', 'Maine Coon')).to(eq([test_cat]))
    end
  end
end
