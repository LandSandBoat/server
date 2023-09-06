-----------------------------------
-- func: posfix
-- desc: Resets a targets account session and warps them to Jeuno.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!posfix <player>')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    if target == nil then
        error(player, 'You must supply the name of an offline player.')
    else
        player:resetPlayer(target)
        player:PrintToPlayer(string.format('Fixed %s\'s position.', target))
    end
end

return commandObj
