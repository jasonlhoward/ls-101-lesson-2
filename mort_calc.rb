def integer?(n)
  n.to_s().length() == n.to_i().to_s().length() && n.to_i > 0
end

def float?(f)
  f_arr = f.to_s().split('.')
  return false if f_arr.length() > 2
  if f_arr.length() == 1
    integer?(f) && f.to_i > 0
  else
    integer?(f_arr[0]) && integer?(f_arr[1]) && f.to_f > 0
  end
end

def amt
  loan_amt = nil
  loop do
    print 'Enter the loan amount: '
    loan_amt = Kernel.gets().chomp()
    break if float?(loan_amt) && loan_amt.to_f > 0
    puts 'Invalid input!'
  end
  loan_amt.to_f
end

def rate
  apr = nil
  loop do
    print 'Enter the APR (5 = 5%): '
    apr = Kernel.gets().chomp()
    break if float?(apr)
    puts 'Invalid input!'
  end
  apr.to_f
end

def duration
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
  monthly_rate = apr / 100 / 12
  loan_duration_months = loan_duration * 12

  p = loan_amt.to_f
  j = monthly_rate.to_f
  n = loan_duration_months.to_f

  p * (j / (1 - (1 + j)**-n))
end

puts 'Mortgage/Loan Calculator'
payment = calc_payment(amt, rate, duration)
puts "Your loan payments will be $#{format('%.2f', payment)} per month!"
