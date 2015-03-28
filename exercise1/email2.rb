class Email
  
  def initialize(subject, headers)
    @subject= subject
    @date = headers[:date]
    @from = headers[:from]
  end
  
  def subject
    @subject
  end
  
  def date
    @date
  end
  
  def from
    @from
  end
  
end

email = Email.new("Keep on coding! :)", { :date => "2014-12-01", :from => "Ferdous" })

puts "Date:    #{email.date}"
puts "From:    #{email.from}"
puts "Subject: #{email.subject}"