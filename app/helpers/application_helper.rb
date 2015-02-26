module ApplicationHelper

  # turns 1 into 1st, 2 into 2nd, etc.
  def add_suffix_to_number number
    num_chars = number.to_s.split ''
    ones_digit = num_chars.last

    case ones_digit
    when '1'
      number.to_s + 'st'
    when '2'
      number.to_s + 'nd'
    when '3'
      number.to_s + 'rd'
    else
      number.to_s + 'th'
    end
  end
end
