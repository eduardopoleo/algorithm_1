require 'set'

def handle_line(a, b, sets)
	a_included = [false, -1]
	b_included = [false, -1]

	sets.each_with_index do |s, i|
		a_included = [true, i] if s.include?(a)
		b_included = [true, i] if s.include?(b)
	end

	sets << [a,b].to_set unless a_included[0] || b_included[0]

	if a_included[0] && !b_included[0]
		sets[a_included[1]].add(b)
	end

	if b_included[0] && !a_included[0]
		sets[b_included[1]].add(a)
	end

	if a_included[0] && b_included[0] && a_included[1] != b_included[1]
		b_set = sets.delete_at(b_included[1])
		a_set = sets[a_included[1]]

		a_set.merge(b_set)
	end
end

# l[0], l[1] are in different sets, merge sets
