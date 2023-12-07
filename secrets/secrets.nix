let
  eriim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBh6+743NINanzS+X6QUbhhj/XN2edYxiD7TrUNclQN1";
  users = [ eriim ];
  nixboard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO9scH83gPs0dbiliNHvnRjZDo4hCwe3R0W26SN4f7Jb";
  nixbox = "ssh-ed25519 AAAC3NzaC1lZDI1NTE5AAAIAhKvn+by6FngLSbbTdXKPAirdEAaSHnK8IQGXyXF/jQ";
  nixcube = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1c3qwjqf3eWNl7N1OYjoqa6estljz+VBpeSV9kIhXD";
  systems = [ nixboard nixbox nixcube ];
in
{
  "wireless.age".publicKeys = users ++ systems;
  "tailscale.age".publicKeys = users ++ systems;
  "firefly_env.age".publicKeys = [ eriim ] ++ [ nixboard] ;
  "firefly_db.age".publicKeys = [ eriim ] ++ [ nixboard ];

}
