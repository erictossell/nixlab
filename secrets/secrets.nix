let
  eriim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBh6+743NINanzS+X6QUbhhj/XN2edYxiD7TrUNclQN1";
  users = [ eriim ];
  nixboard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFxslzX9LKcpUevEafRPlT4lgcRIGCNrwHBGJ1tiNdBU";
  nixbox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIyO3jhe9heIjuUnW6MP/0U3/qjG63kTmM2wRp5nht1";
  nixcube = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1c3qwjqf3eWNl7N1OYjoqa6estljz+VBpeSV9kIhXD";
  nixtop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJS6X46jQ0Wy5wtJsIbpnmRKS2B2zFrBuQ1JRbELxix+";
  systems = [ nixboard nixbox nixcube nixtop ];
in
{
  "wireless.age".publicKeys = users ++ systems;
}
