ngx.redis = require "resty.redis"
-- ngx.red = redis:new()

-- ngx.red:set_timeout(1000) -- 1 second

-- local ok, err = ngx.red:connect("172.26.0.2", 6379)
-- if not ok then
--     ngx.log(ngx.ERR, "Failed to connect to redis: ", err)
--     return ngx.exit(500)
-- end