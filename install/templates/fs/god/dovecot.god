# run with:  god -c /etc/god/dovecot.god
#

God.watch do |w|
  w.name = "dovecot"
  w.group = "mailserv"
  w.interval = 30.seconds # default
  w.start = "/etc/rc.d/dovecot start"
  w.stop = "/etc/rc.d/dovecot stop"
  w.restart = "/etc/rc.d/dovecot restart"
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "/var/dovecot/master.pid"

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

end
