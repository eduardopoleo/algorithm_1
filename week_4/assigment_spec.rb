require 'rspec'
require 'set'

require_relative './assigment'

describe '#handle_line' do
	before do
		@set1 = [1,2,3].to_set
		@set2 = [4,5,6].to_set
		@set3 = [7,8,9].to_set

		@sets = [@set1, @set2, @set3]
	end

	context 'when both a and b are in the same set' do
		it 'does nothing' do
			handle_line(1,2, @sets)

			expect(@sets.size).to eq(3)
			expect(@set1.size).to eq(3)
			expect(@set2.size).to eq(3)
			expect(@set3.size).to eq(3)
		end
	end

	context 'when a, b are not in any set' do
		it 'creates a new set containing both numbers' do
			handle_line(10,11, @sets)
			
			expect(@sets.size).to eq(4)
			expect(@sets.last.size).to eq(2)
			expect(@sets.last.include?(10)).to be_truthy
			expect(@sets.last.include?(11)).to be_truthy
		end
	end

	context 'when a, b are not in any set' do
		it 'adds b to the set where a is' do
			handle_line(10,11, @sets)

			expect(@sets.size).to eq(4)
			expect(@sets.last.size).to eq(2)
			expect(@sets.last.include?(10)).to be_truthy
			expect(@sets.last.include?(11)).to be_truthy
		end
	end

	context 'when b is an set and a is not in any set' do
		it 'adds a to the set where b is' do
			handle_line(10,9, @sets)

			expect(@sets.size).to eq(3)
			expect(@sets.last.size).to eq(4)
			expect(@sets.last.include?(9)).to be_truthy
		end
	end

	context 'when a is in a set and b is in another set' do
		it 'merges both sets' do
			handle_line(1,9, @sets)

			expect(@sets.size).to eq(2)
			expect(@sets.first.size).to eq(6)
			expect(@sets.first.include?(9)).to be_truthy
		end
	end
end