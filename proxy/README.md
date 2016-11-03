# Proxy configuration files place holder

## b2d proxy change cmd profile definition

Your can store here the proxy profile configuration.

- 1 file per profile
- Each file name corresponds to a profile name you can use with ```b2d proxy change PROFILE_NAME```

A file should be set like an ```/etc/environment``` file:

```HTTP_PROXY=http://proxy.domain.net:3128
HTTPS_PROXY=http://proxy.domain.net:3128
FTP_PROXY=
NO_PROXY=localhost,127.0.0.1
http_proxy=http://proxy.domain.net:3128
https_proxy=http://proxy.domain.net:3128
ftp_proxy=
no_proxy=localhost,127.0.0.1
```

**Important:** you should use a prefix in your filename like ```fr_proxy``` to help other custom feature like auto pac auto select depending your prefix.

## b2d syncd with custom proxy.pac

By default, the docker transparent proxy daemon ```dk_proxyd``` uses ```http://wpad/wpad.dat``` to try to autodetect the proxy configuration file.

If you don't have this file on your network you can define your own by adding a ```proxy.pac``` file in this folder.

The ```dk_proxyd``` will auto-detect it and use it directly instead of wpad method.

**Important:** if you have multiple proxy.pac depending your country for instance, you can prefix the proxy.pac like your proxy definition, ex: ```fr_proxy.pac```. With this system, b2d will associate the right proxy.pac with your current proxy definition (red from http_proxy env var)*[]: 

If your proxy.pac is stored somewhere on your network, just put the url inside a ```proxy.pac.url``` file. Don't forget to use the right prefix if requested (see previous important note). 

The configuration are selected in the following priority: proxy.pac, proxy.pac.url, default wpad system.

**Sample proxy.pac:**

```function FindProxyForURL(url, host) {
    
   // If the hostname matches, send direct.
       if (dnsDomainIs(host, "intranet.domain.com") ||
           shExpMatch(host, "(*.abcdomain.com|abcdomain.com)"))
           return "DIRECT";
    
   // If the protocol or URL matches, send direct.
       if (url.substring(0, 4)=="ftp:" ||
           shExpMatch(url, "http://abcdomain.com/folder/*"))
           return "DIRECT";
    
   // If the requested website is hosted within the internal network, send direct.
       if (isPlainHostName(host) ||
           shExpMatch(host, "*.local") ||
           isInNet(dnsResolve(host), "10.0.0.0", "255.0.0.0") ||
           isInNet(dnsResolve(host), "172.16.0.0",  "255.240.0.0") ||
           isInNet(dnsResolve(host), "192.168.0.0",  "255.255.0.0") ||
           isInNet(dnsResolve(host), "127.0.0.0", "255.255.255.0"))
           return "DIRECT";
    
   // If the IP address of the local machine is within a defined
   // subnet, send to a specific proxy.
       if (isInNet(myIpAddress(), "10.10.5.0", "255.255.255.0"))
           return "PROXY 1.2.3.4:8080";
    
   // DEFAULT RULE: All other traffic, use below proxies, in fail-over order.
       return "PROXY 4.5.6.7:8080; PROXY 7.8.9.10:8080";
    
   }
```

You can get more information on the net to know what is the best help for you like http://findproxyforurl.com/example-pac-file/
