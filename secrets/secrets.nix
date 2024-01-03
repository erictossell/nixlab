let
<<<<<<< HEAD
  eriim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBh6+743NINanzS+X6QUbhhj/XN2edYxiD7TrUNclQN1";
  users = [ eriim ];
  nixboard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO9scH83gPs0dbiliNHvnRjZDo4hCwe3R0W26SN4f7Jb";
  nixbox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhKvn+by6FngLSbbTdXKPAirdEAaSHnK8IQGXyXF/jQ";
  nixcube = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgy9a9W8cIxkyylPdq4uRZKGSmZfPWPu+lbhS4XdDQy";
  systems = [ nixboard nixbox nixcube ];
in
{
  "wireless.age".publicKeys = users ++ systems;
  "tailscale.age".publicKeys = users ++ systems;
=======
   eriim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAETSTzRnvYIQsOwhdwcbVRyZVnP6/F3b+inurb9+RMu";
   users = [ eriim ];
   nixbox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIyO3jhe9heIjuUnW6MP/0U3/qjG63kTmM2wRp5nht1";
   systems = [ nixbox ];
in
{
  "ssid.age".publicKeys = [ eriim nixbox ];
  "ssidPass.age".publicKeys = [ eriim nixbox ];
  "eriimSSHKey.age".publicKeys = [ eriim nixbox ];
  "initPassword.age".publicKeys = [ eriim nixbox ];
  "wireless.age".publicKeys = [ eriim nixbox ];
>>>>>>> 241a050 (russh config.json)
}
