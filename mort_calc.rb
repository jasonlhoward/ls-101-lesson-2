# m = monthly payment
# p = loan amount
# j = monthly interest rate
# n = loan duration in months
# m = p * (j / (1 - (1 + j)**(-n)))

def integer?(n)
  n.to_s().length() == n.to_i().to_s().length()
end

def float?(f)
  f_arr = f.to_s().split('.')
  return false if f_arr.length() > 2
  if f_arr.length() == 1
    integer?(f)
  else
    integer?(f_arr[0]) && integer?(f_arr[1])
  end
end

def get_amt
  loan_amt = nil
  loop do
    print 'Enter the loan amount: '
    loan_amt = Kernel.gets().chomp()
    break if float?(loan_amt)
    puts 'Invalid input!'
  end
  loan_amt.to_f
end

def get_apr
  apr = nil
  loop do
    print 'Enter the APR (5 = 5%): '
    apr = Kernel.gets().chomp()
    break if float?(apr)
    puts 'Invalid input!'
  end
  apr.to_f
end

def get_duration
  loan_duration = nil
  loop do
    print 'Loan duration (in years): '
    loan_duration = Kernel.gets().chomp()
    break if integer?(loan_duration)
    puts 'Invalid input!'
  end
  loan_duration.to_f
end

def calc_payment(loan_amt, apr, loan_duration)
  monthly_rate = apr / 10 / 12
  loan_duration_months = loan_duration * 12

  p = loan_amt.to_f
  j = monthly_rate.to_f
  n = loan_duration_months.to_f

  p * (j / (1 - (1 + j)**(-n)))
end

puts 'Mortgage Calculator'
payment = calc_payment(get_amt, get_apr, get_duration).to_i
puts "Your payments will be about $#{payment} per month!"
