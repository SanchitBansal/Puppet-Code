Facter.add("datacenter") do

   setcode do

     datacenter = "unknown"

     ipaddr = Facter.value(:ipaddress)
     if ipaddr.match("^a.x.")
        datacenter = "X"
     elsif ipaddr.match("^a.y.")
        datacenter = "Y"
     elsif ipaddr.match("^a.z.")
        datacenter = "Z"
     end
     datacenter
     end

     end
