-----------------------------------
-- func: provokeall
-- desc: Makes all enemies in the current zone target you and sets their TP to 3000.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local zone = player:getZone()
    for _, mob in pairs(zone:getMobs()) do
        mob:updateEnmity(player)
        mob:setTP(3000)
    end
end

return commandObj
