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
    
    # Get the max length of each column text
    # Enumerable.max_by -> http://ruby-doc.org/core-2.2.1/Enumerable.html#method-i-max_by
    dateLength = @mailbox.emails.max_by { |e| e.date.length}.date.length
    fromLength = @mailbox.emails.max_by { |e| e.from.length}.from.length
    subjectLength = @mailbox.emails.max_by { |e| e.subject.length}.subject.length
    
    out = "Mailbox: #{@mailbox.name}\n"
    
    out+=getHeader(dateLength,fromLength,subjectLength)
    @mailbox.emails.each do |email|
      out+="| #{email.date}" + " "*(dateLength-email.date.length+1)
      out+="| #{email.from}" + " "*(fromLength-email.from.length+1) 
      out+="| #{email.subject}" + " "*(subjectLength-email.subject.length+1) + "|"
      out+="\n"
    end
    out+=getLine(dateLength,fromLength,subjectLength)
  end
  
  private
  
  def getHeader(dateLength,fromLength, subjectLength)
    getLine(dateLength,fromLength, subjectLength) +
    "| Date" + " "*(dateLength+1-4) + "| From" + " "*(fromLength+1-4) + "| Subject" + " "*(subjectLength+1-7) + "|\n" +
    getLine(dateLength,fromLength, subjectLength) 
  end
  
  def getLine(dateLength,fromLength, subjectLength)
    "+"+"-"*(dateLength+2)+"+"+"-"*(fromLength+2)+"+"+"-"*(subjectLength+2)+"+\n"
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