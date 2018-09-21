require "digest"
require "io/console"

# initialize constant variables
MINIMUM_PASSWORD_SIZE = 8
SALT                  = "PaXvnqQahiaPXdm5s5"

# initialize program variables
entered_url     = nil
master_password = nil
password_size   = 0

# enter the account URL
begin
  print("Enter URL: ")
  entered_url = gets.chomp.strip
end while entered_url.empty?

loop do
  begin
    # enter the secret password
    # master_password = STDIN.getpass("Enter your master password: ").strip
    print "Enter your master password: "
    master_password = STDIN.noecho(&:gets).chomp.strip
  end while master_password.empty?
  puts ""
  
  begin
    # re-enter the secret password
    # re_entered_password = STDIN.getpass("Type again your secret password: ").strip
    print "Type again your master password: "
    re_entered_password = STDIN.noecho(&:gets).chomp.strip
  end while re_entered_password.empty?  
  puts ""    

  # make sure the entered password matches to that of the re-entered password
  if re_entered_password == master_password
    break
  else
    puts "Entered password doesn't match. Please, re-type your password."
    puts ""
  end
end

while password_size == 0 do
  print("Preferred password size (default is 8 characters): ")
  entered_value = gets.chomp.strip
  password_size = entered_value.empty? ? MINIMUM_PASSWORD_SIZE : entered_value.to_i
end


# build an identity
identity = "#{master_password}-#{entered_url}-#{SALT}"

##
## create a unique generated_password by using SHA-256 hash
generated_password = Digest::SHA256.hexdigest(identity)
##
##


puts ""
puts "Below is the generated password:"
puts ""
puts "#{generated_password[0, password_size]}"
puts ""
