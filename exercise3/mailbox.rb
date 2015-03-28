class Email
  attr_accessor :subject, :date, :from
  
    def initialize(subject, headers)
    @subject= subject
    @date = headers[:date]
    @from = headers[:from]
  end
end

class Mailbox
  attr_accessor :name,:emails
  
  def initialize(name,emails)
    @name = name
    @emails = emails
  end
end

class MailboxTextFormatter
  
  def initialize(mailbox)
    @mailbox = mailbox
  end
  
  def format
    out = "Mailbox: #{@mailbox.name}\n"
    
    out+=getHeader
    @mailbox.emails.each do |email|
      out+="| #{email.date} " 
      out+="| #{email.from[0,8]}"+" "*(8-email.from.length) # space + 8 chars
      out+="| #{email.subject[0,23]}"+ " "*(23-email.subject.length) +"|" # space + 23 chars
      out+="\n"
    end
    out+=getLine
  end
  
  private
  
  def getHeader
    getLine + "| Date       | From    | Subject                |\n"+getLine 
  end
  
  def getLine
    "+------------+---------+------------------------+\n"
  end
  
end

emails = [
  Email.new("Homework this week", { :date => "2014-12-01", :from => "Ferdous" }),
  Email.new("Keep on coding! :)", { :date => "2014-12-01", :from => "Dajana" }),
  Email.new("Re: Homework this week", { :date => "2014-12-02", :from => "Ariane" })
]
mailbox = Mailbox.new("Ruby Study Group", emails)
formatter = MailboxTextFormatter.new(mailbox)

puts formatter.format