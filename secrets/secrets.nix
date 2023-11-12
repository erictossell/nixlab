let
   nixbox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIyO3jhe9heIjuUnW6MP/0U3/qjG63kTmM2wRp5nht1";
   nixboard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFxslzX9LKcpUevEafRPlT4lgcRIGCNrwHBGJ1tiNdBU";
   nixcube = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1c3qwjqf3eWNl7N1OYjoqa6estljz+VBpeSV9kIhXD";
   systems = [ nixbox nixboard nixcube ];
in
{
  "wireless.age".publicKeys = systems;
}
