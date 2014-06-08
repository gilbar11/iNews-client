require 'settingslogic'

class Settings < Settingslogic
  if ARGF.argv
    source ARGF.argv.first
  else
    puts "##### Loading Settings from local file settings.yml #####"
    puts "##### PLEASE Check Your Settings #####"
    sleep(3)
    source "settings.yml"
  end
end
