require_relative 'friendship'

# object:
# expect(object).to be value => object.equal? value
# expect(object).to eq value => object == value
# expect(object).to be < value => object < value
# expect(object).to be > value => object > value
# expect(object).to match_array array
# expect([1, 2, 3]).to match_array [2, 1, 3]
# expect([1, 2, 3]).to eq [2, 1, 3]
# expect(object).to be_something => object.something?
# expect(maria).to be_female == expect(maria.female?).to be(true)
#
# expect(object).to be_truthy
# expect(object).to have_something => object.has_something?
#
# expect(object).to include(value)
# expect([1, 2, 3]).to include(2) == expect([1, 2, 3].include?(2)).to be true
#
# expect(failing code ...)
# expect { ...code... }.to raise_error(Error, 'message')
# Всеки мачър си има отрицание
# .to_not
# .not_to

RSpec.describe Friendship::Friend do
  # describe 'friend' do
  #   code...
  # end
  #
  # Should we use let? Food for thought
  let(:stamat) { Friendship::Friend.new('Stamat', :male, 20) }
  let(:maria) { Friendship::Friend.new('Mariya', :female, 18) }

  context 'friends have attributes' do
    describe '#name' do
      it "tells us a friend's name" do
        expect(stamat.name).to eq('Stamat')
      end
    end

    describe '#sex' do
      it 'gives us the sex of a friend' do
        expect(stamat.sex).to eq(:male)
      end
    end

    describe '#age' do
      it 'gives us the age of a friend' do
        expect(stamat.age).to eq(20)
      end
    end
  end

  describe '#male?' do
    it 'tells us whether a friend is male' do
      # expect(stamat.male?).to be(true)
      expect(stamat).to be_male #=> expect(stamat.male?).to be(true)
      expect(maria).to_not be_male #=> expect(maria.male?).to be(false)
    end
  end

  describe '#female?' do
    it 'returns whether a friend is female' do
      expect(maria).to be_female
      expect(stamat).to_not be_female
    end
  end

  describe '#over_eighteen?' do
    it 'tells us whether a friend is over 18' do
      expect(stamat).to be_over_eighteen
      expect(maria).to_not be_over_eighteen
    end
  end

  describe '#long_name?' do
    let(:konstantincho) { Friendship::Friend.new('Konstantincho', :male, 22) }

    it 'tells us whether a friend has a long name' do
      expect(konstantincho).to be_long_name
      expect(maria).to_not be_long_name
    end
  end
end

RSpec.describe Friendship::Database do

  let (:friends) { Friendship::Database.new }

  describe '#add_friend' do
    it 'can add friends' do
      friends.add_friend('Pesho', :male, 20)
      expect(friends.count).to eq 1

      friends.add_friend('Pesho', :male, 20)
      expect(friends.count).to eq 2
    end
  end

  context 'We want to iterate over our friend database' do
    it 'includes Enumerable' do
      expect(Friendship::Database.include? Enumerable)
    end

    describe '#each' do
      it 'iterates our friend' do
        friends.add_friend('Pesho', :male, 20)
        friends.add_friend('Mariya', :male, 20)

        result = []

        friends.each { |friend| result << friend }

        # Is this ok?
        expect(result.size).to be 2
        expect(result.all? { |friend| friend.is_a? Friendship::Friend }).to be true
      end

      it "returns an enumerator when there's no block" do
        expect(friends.each).to be_instance_of Enumerator
      end
    end
  end

  describe '#have_any_friends?' do
    it 'tells us whether we have friends' do
      friends.add_friend('Pesho', :male, 20)

      expect(friends.have_any_friends?).to be true
    end

    it 'shows us whether we dont have friends' do
      expect(friends.have_any_friends?).to be false
    end
  end

  describe '#find' do
    it 'returns all friends by name' do
      friends.add_friend('Pesho', :male, 20)
      friends.add_friend('Pesho', :male, 25)
      friends.add_friend('Maira', :female, 20)

      expect(friends.find(name: 'Pesho').size).to eq 2
    end

    it 'returns all friends by sex' do
      friends.add_friend('Pesho', :male, 20)
      friends.add_friend('Pesho', :male, 25)
      friends.add_friend('Maira', :female, 20)

      expect(friends.find(sex: :female).size).to eq 1
    end

    it 'returns all friends by given lambda' do
      friends.add_friend('Pesho', :male, 20)
      friends.add_friend('Pesho', :male, 25)
      friends.add_friend('Maira', :female, 20)
      male_and_over_twenty = ->(friend) { friend.male? && friend.age > 20 }

      expect(friends.find(filter: male_and_over_twenty).size).to eq 1
    end
  end

  describe '#unfriend' do
    before(:each) do
      # Can we do it in a nicer way?
      @friends = Friendship::Database.new
      (1..1000).each do |number|
        if number < 500
          @friends.add_friend('Pesho', :male, 25)
        else
          @friends.add_friend('Maira', :female, 30)
        end
      end
    end

    it 'removes all friends by name' do

      @friends.unfriend(name: 'Pesho')
      expect(@friends.count).to eq 501

      @friends.unfriend(name: 'Gosho')
      expect(@friends.count).to eq 501

      @friends.unfriend(name: 'Maira')
      expect(@friends.count).to eq 0
    end

    it 'removes all friends by sex' do
      @friends.unfriend(sex: :male)

      expect(@friends.count).to eq 501
    end

    it 'removes all friends by given filter' do
      @friends.unfriend(filter: ->(friend) { friend.age == 30 })
      expect(@friends.count).to eq 499

      @friends.unfriend(filter: ->(friend) { friend.sex == :male })
      expect(@friends.count).to eq 0
    end
  end
end
