require 'net/smtp'
require 'yaml'

class Notifier

  def initialize(params)
    if (params[:login].nil? || params[:password].nil?) && params[:auth_file].nil?
      raise ArgumentError, "You must either provide a login, " +
                    "and password or an authentication file."
    end

    if not params[:auth_file].nil?
      auth = params[:auth_file].parse
      @login = auth[:name]
      @password = auth[:password]
    else
      @login = params[:login]
      @password = params[:password]
    end

  end

  def send(to, subject, body)
    msg = "Subject: #{subject}\n\n#{body}"
    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls
    smtp.start('Hazmatt', @login, @password, :login) do
      smtp.send_message(msg, @login, to)
    end
  end

end

class AuthenticationFile

  def initialize(path)
    @path = path
  end

  def AuthenticationFile.make_file(path, name, password)
    user = Process::Sys.getuid

    if user != 0
      raise SecurityError, 'Only root can make an authentication file.'
    end

    File.write(path, { name: name, password: password }.to_yaml)

    File.chmod(0600, path)
    File.chown(0, 0, path)
  end

  def parse
    YAML.load_file(@path)
  end

end
