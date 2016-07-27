Facter.add("lob") do
  setcode do
    lob = "unknown"
    ipaddr = Facter.value(:ipaddress)
    if ipaddr.match(/^a.(x|y|z).b\.\d{1,3}/)
      lob = "testing"
     end
     lob
     end
     end
