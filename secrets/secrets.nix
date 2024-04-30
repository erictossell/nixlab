let
  eriim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBh6+743NINanzS+X6QUbhhj/XN2edYxiD7TrUNclQN1";
  users = [ eriim ];
  nixboard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO9scH83gPs0dbiliNHvnRjZDo4hCwe3R0W26SN4f7Jb";
  nixbox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhKvn+by6FngLSbbTdXKPAirdEAaSHnK8IQGXyXF/jQ";
  nixcube = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgy9a9W8cIxkyylPdq4uRZKGSmZfPWPu+lbhS4XdDQy";
  systems = [ nixboard nixbox nixcube ];
  soft_serve = [ nixbox eriim ];
in
{
  "wireless.age".publicKeys = users ++ systems;
  "tailscale.age".publicKeys = users ++ systems;

  "soft_serve_host.age".publicKeys = soft_serve;
  "soft_serve_client.age".publicKeys = soft_serve;

  "backblaze_api_id.age".publicKeys = users ++ systems;
  "backblaze_api_key.age".publicKeys = users ++ systems;
}
