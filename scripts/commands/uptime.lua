-----------------------------------
-- func: uptime
-- desc: prints zone uptime
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

local function formatSeconds(seconds)
    local days = math.floor(seconds / 86400)
    seconds = seconds % 86400  -- Use modulo to get remaining seconds after days
    local hours = math.floor(seconds / 3600)
    seconds = seconds % 3600   -- Use modulo again for remaining seconds after hours
    local minutes = math.floor(seconds / 60)
    seconds = seconds % 60     -- And again for remaining seconds

    local parts = {}

    if days > 0 then
        table.insert(parts, string.format('%d day%s', days, days > 1 and 's' or ''))
    end

    if hours > 0 then
        table.insert(parts, string.format('%d hour%s', hours, hours > 1 and 's' or ''))
    end

    if minutes > 0 then
        table.insert(parts, string.format('%d minute%s', minutes, minutes > 1 and 's' or ''))
    end

    if seconds > 0 or #parts == 0 then
        table.insert(parts, string.format('%d second%s', seconds, seconds > 1 and 's' or ''))
    end

    return table.concat(parts, ' ')
end

commandObj.onTrigger = function(player)
    local zone = player:getZone()
    if zone then
        local uptime = zone:getUptime()
        player:printToPlayer('The zone has been up for ' .. formatSeconds(uptime), xi.msg.channel.SYSTEM_3)
    end
end

return commandObj
