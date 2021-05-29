local key = ngx.var.uri
key = key:gsub("/", "") -- ngx.var.http_user_agent
if not key then
    ngx.log(ngx.ERR, "no user-agent found")
    return ngx.exit(400)
end

-- start connect to redis

-- local redis = require "resty.redis"
-- if not ngx.red then
local red = ngx.redis:new()

red:set_timeout(1000) -- 1 second    
-- end

local ok, err = red:connect("redis.local", 6379, {
        pool = "redis-connection-pool",
        pool_size = 50000   
    })

if not ok then
    ngx.log(ngx.ERR, "failed to connect to redis: ", err)
    return ngx.exit(500)
end


---- end connect

local host, err = red:get(key)
if not host then
    ngx.log(ngx.ERR, "Failed to get redis key: ", err)
    return ngx.exit(500)
end

if host == ngx.null then
    ngx.log(ngx.ERR, "no host found for key ", key)
    return ngx.exit(400)
end

local ok, err = red:set_keepalive(50000, 10000)
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end

ngx.var.target = host